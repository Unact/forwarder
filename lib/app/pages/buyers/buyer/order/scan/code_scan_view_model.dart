part of 'code_scan_page.dart';

class CodeScanViewModel extends PageViewModel<CodeScanState, CodeScanStateStatus> {
  static final String kCryptoSeparator = '\u001D';
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final GS1BarcodeParser parser = GS1BarcodeParser.defaultParser();

  StreamSubscription<List<OrderLineWithCode>>? orderLineWithCodeListSubscription;
  StreamSubscription<List<OrderLineCode>>? orderLineCodesSubscription;

  CodeScanViewModel(this.appRepository, this.ordersRepository, {required Order order}) :
    super(CodeScanState(order: order));

  @override
  CodeScanStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    orderLineWithCodeListSubscription = ordersRepository.watchOrderLinesByOrderId(state.order.id).listen((event) {
      emit(state.copyWith(status: CodeScanStateStatus.dataLoaded, codeLines: event));
    });
    orderLineCodesSubscription = ordersRepository.watchOrderLineCodes().listen((event) {
      emit(state.copyWith(status: CodeScanStateStatus.dataLoaded, allCodeLines: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderLineWithCodeListSubscription?.cancel();
    await orderLineCodesSubscription?.cancel();
  }

  String? _parseBarcode(String barcode) {
    try {
      return parser.parse(barcode).getAIData('01');
    } on Exception catch(_) {
      return null;
    }
  }

  Future<void> _processDatacode(String barcode) async {
    String gtin = _parseBarcode(barcode)!;

    if (state.allCodeLines.any((e) => formatCode(e.code) == formatCode(barcode))) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Код уже отсканирован'));
      return;
    }

    if (state.codeLines.any((e) => e.orderLineStorageCodes.isNotEmpty)) {
      OrderLineStorageCode? storageCode = state.allStorageCodeLines.firstWhereOrNull(
        (e) => e.code == formatCode(barcode).split(kCryptoSeparator)[0]
      );
      OrderLineWithCode? codeLine = state.codeLines.firstWhereOrNull(
        (e) => e.orderLineStorageCodes.contains(storageCode)
      );

      if (codeLine == null) {
        emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Код не в заказе'));
        return;
      }

      await ordersRepository.addOrderLineCode(
        orderLine: codeLine.orderLine,
        code: barcode,
        amount: storageCode!.amount,
        isDataMatrix: true
      );
      emit(state.copyWith(
        status: CodeScanStateStatus.success,
        lastScannedOrderLine: codeLine.orderLine,
        message: 'Код успешно отсканирован'
      ));
    } else {
      List<OrderLineWithCode> codeLines = state.codeLines.where((e) => e.orderLine.gtin == gtin).toList();
      OrderLineWithCode? codeLine = codeLines.firstWhereOrNull((e) => e.orderLine.vol > e.orderLineCodes.length);

      if (codeLines.isEmpty) {
        emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Данный товар не в этом заказе'));
        return;
      }

      if (codeLine == null) {
        emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Уже отсканированы все коды для товара'));
        return;
      }

      if (!codeLine.orderLine.needMarking) {
        emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Нельзя сканировать ЧЗ для обычного товара'));
        return;
      }

      await ordersRepository.addOrderLineCode(
        orderLine: codeLine.orderLine,
        code: barcode,
        amount: 1,
        isDataMatrix: true
      );
      emit(state.copyWith(
        status: CodeScanStateStatus.success,
        lastScannedOrderLine: codeLine.orderLine,
        message: 'Код успешно отсканирован'
      ));
    }
  }

  Future<void> _processBarcode(String barcode) async {
    List<OrderLineWithCode> codeLines = state.codeLines.where(
      (e) => e.orderLine.barcodeRels.map((e) => e.barcode).contains(barcode)
    ).toList();
    OrderLineWithCode? codeLine = codeLines.firstWhereOrNull(
      (e) => e.orderLineCodes.isEmpty || e.orderLineCodes.firstWhereOrNull((el) => e.orderLine.vol > el.amount) != null
    );
    int? rel = codeLine?.orderLine.barcodeRels.firstWhere((e) => e.barcode == barcode).rel;
    double? vol = codeLine?.orderLine.vol;

    if (codeLines.isEmpty) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Данный товар не в этом заказе'));
      return;
    }

    if (codeLine == null) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Уже отсканированы все коды для товара'));
      return;
    }

    if (codeLine.orderLine.needMarking) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Нельзя сканировать штрихкод товара ЧЗ'));
      return;
    }

    int newAmount = (codeLine.orderLineCodes.firstOrNull?.amount ?? 0) + rel!;

    if (newAmount > vol!) {
      emit(state.copyWith(
        status: CodeScanStateStatus.failure,
        message: 'Отсканировано $newAmount шт., в заказе ${vol.toInt()} шт. - количество больше, чем в заказе')
      );
      return;
    }

    if (codeLine.orderLineCodes.isEmpty) {
      await ordersRepository.addOrderLineCode(
        orderLine: codeLine.orderLine,
        code: barcode,
        amount: newAmount,
        isDataMatrix: false
      );
    } else {
      await ordersRepository.updateOrderLineCode(
        orderLineCode: codeLine.orderLineCodes.first,
        amount: newAmount
      );
    }

    emit(state.copyWith(
      status: CodeScanStateStatus.success,
      lastScannedOrderLine: codeLine.orderLine,
      message: 'Код успешно отсканирован'
    ));
  }

  Future<void> readCode(String barcode) async {
    String? gtin = _parseBarcode(barcode);

    await (gtin != null ? _processDatacode(barcode) : _processBarcode(barcode));
  }

  Future<void> decreaseAmount(OrderLineWithCode codeLine) async {
    await updateAmount(codeLine, codeLine.orderLineCodes.first.amount - 1);
  }

  Future<void> increaseAmount(OrderLineWithCode codeLine) async {
    await updateAmount(codeLine, codeLine.orderLineCodes.first.amount + 1);
  }

  Future<void> updateAmount(OrderLineWithCode codeLine, int newAmount, [showMessage = false]) async {
    if (newAmount < 1 || newAmount > codeLine.orderLine.vol) {
      if (showMessage) emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Не корректное значение'));

      return;
    }

    await ordersRepository.updateOrderLineCode(orderLineCode: codeLine.orderLineCodes.first, amount: newAmount);
  }

  String formatCode(String code) {
    return code.replaceFirst(kCryptoSeparator, '');
  }
}
