part of 'code_scan_page.dart';

class CodeScanViewModel extends PageViewModel<CodeScanState, CodeScanStateStatus> {
  static final String kCryptoSeparator = '\u001D';
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final GS1BarcodeParser parser = GS1BarcodeParser.defaultParser();

  StreamSubscription<List<OrderLineWithCode>>? orderLineWithCodeListSubscription;
  StreamSubscription<List<OrderLineCode>>? orderLineCodesSubscription;
  StreamSubscription<List<Order>>? ordersSubscription;

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
    ordersSubscription = ordersRepository.watchOrders().listen((event) {
      emit(state.copyWith(status: CodeScanStateStatus.dataLoaded, allOrders: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderLineWithCodeListSubscription?.cancel();
    await orderLineCodesSubscription?.cancel();
    await ordersSubscription?.cancel();
  }

  Future<void> readCode(String code) async {
    if (state.codeLines.any((e) => e.orderLine.barcodeRels.map((e) => e.barcode).contains(code))) {
      await _processBarcode(code);
      return;
    }

    if (state.allStorageCodeLines.isNotEmpty) {
      await _processStorageCode(code);
      return;
    }

    if (_parseDataMatrix(code)?.getAIData('01') != null) {
      await _processDataMatrixCode(code);
      return;
    }

    emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Код не опознан. $code'));
  }

  Future<void> _processDataMatrixCode(String code) async {
    String gtin = _parseDataMatrix(code)!.getAIData('01');

    List<OrderLineWithCode> codeLines = state.codeLines.where((e) => e.orderLine.gtin == gtin).toList();
    OrderLineWithCode? codeLine = codeLines.firstWhereOrNull((e) => e.orderLine.vol > e.orderLineCodes.length);
    OrderLineCode? scannedLine = state.allCodeLines.firstWhereOrNull((e) => e.code == code);

    if (scannedLine != null) {
      Order order = state.allOrders.firstWhere((e) => e.id == scannedLine.orderId);

      emit(state.copyWith(
        status: CodeScanStateStatus.failure,
        message: 'Код уже отсканирован в заказе ${order.ndoc}. $code'
      ));
      return;
    }

    if (codeLines.isEmpty) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Данный товар не в этом заказе. $code'));
      return;
    }

    if (codeLine == null) {
      emit(state.copyWith(
        status: CodeScanStateStatus.failure,
        message: 'Уже отсканированы все коды для товара. $code'
      ));
      return;
    }

    if (!codeLine.orderLine.needMarking) {
      emit(state.copyWith(
        status: CodeScanStateStatus.failure,
        message: 'Нельзя сканировать ЧЗ для обычного товара. $code'
      ));
      return;
    }

    await ordersRepository.addOrderLineCode(
      orderLine: codeLine.orderLine,
      code: code,
      groupCode: null,
      amount: 1,
      isDataMatrix: true
    );
    emit(state.copyWith(
      status: CodeScanStateStatus.success,
      lastScannedOrderLine: (value: codeLine.orderLine),
      message: 'Код успешно отсканирован'
    ));
  }

  Future<void> _processBarcode(String code) async {
    List<OrderLineWithCode> codeLines = state.codeLines.where(
      (e) => e.orderLine.barcodeRels.map((e) => e.barcode).contains(code)
    ).toList();
    OrderLineWithCode? codeLine = codeLines.firstWhereOrNull(
      (e) => e.orderLineCodes.isEmpty || e.orderLineCodes.firstWhereOrNull((el) => e.orderLine.vol > el.amount) != null
    );
    int? rel = codeLine?.orderLine.barcodeRels.firstWhere((e) => e.barcode == code).rel;
    double? vol = codeLine?.orderLine.vol;

    if (codeLines.isEmpty) {
      emit(state.copyWith(
        status: CodeScanStateStatus.failure,
        message: 'Данный товар не в этом заказе. $code'
      ));
      return;
    }

    if (codeLine == null) {
      emit(state.copyWith(
        status: CodeScanStateStatus.failure,
        message: 'Уже отсканированы все коды для товара. $code'
      ));
      return;
    }

    if (codeLine.orderLine.needMarking) {
      emit(state.copyWith(
        status: CodeScanStateStatus.failure,
        message: 'Нельзя сканировать штрихкод товара ЧЗ. $code'
      ));
      return;
    }

    int newAmount = (codeLine.orderLineCodes.firstOrNull?.amount ?? 0) + rel!;

    if (newAmount > vol!) {
      emit(state.copyWith(
        status: CodeScanStateStatus.failure,
        message: 'Отсканировано $newAmount шт., в заказе ${vol.toInt()} шт. - количество больше, чем в заказе. $code'
      ));
      return;
    }

    if (codeLine.orderLineCodes.isEmpty) {
      await ordersRepository.addOrderLineCode(
        orderLine: codeLine.orderLine,
        code: code,
        groupCode: null,
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
      lastScannedOrderLine: (value: codeLine.orderLine),
      message: 'Код успешно отсканирован'
    ));
  }

  Future<void> _processStorageCode(String code) async {
    OrderLineCode? scannedLine = state.allCodeLines.firstWhereOrNull((e) => e.code == code);

    if (scannedLine != null) {
      Order order = state.allOrders.firstWhere((e) => e.id == scannedLine.orderId);

      emit(state.copyWith(
        status: CodeScanStateStatus.failure,
        message: 'Код уже отсканирован в заказе ${order.ndoc}. $code'
      ));
      return;
    }

    if (state.allStorageCodeLines.any((e) => e.groupCode == code)) {
      if (state.codeLines.any((e) => e.orderLineCodes.any((ei) => ei.groupCode == code))) {
        emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Код агрегации уже отсканирован. $code'));
        return;
      }

      await Future.wait(state.allStorageCodeLines.where((e) => e.groupCode == code).map((e) async {
        if (state.allCodeLines.any((cl) => cl.code == e.code)) return;

        final orderLine = state.codeLines.firstWhere((cl) => cl.orderLineStorageCodes.contains(e)).orderLine;

        await ordersRepository.addOrderLineCode(
          orderLine: orderLine,
          code: e.code,
          groupCode: code,
          amount: e.amount,
          isDataMatrix: true
        );
      }));

      emit(state.copyWith(
        status: CodeScanStateStatus.success,
        lastScannedOrderLine: (value: null),
        message: 'Успешно отсканировано кодов: ${state.allStorageCodeLines.where((e) => e.groupCode == code).length}'
      ));
    } else {
      final storageCode = state.allStorageCodeLines.firstWhereOrNull(
        (e) => e.code.split(kCryptoSeparator)[0] == code.split(kCryptoSeparator)[0]
      );

      if (storageCode == null) {
        emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Код не в заказе. $code'));
        return;
      }

      final orderLine = state.codeLines.firstWhere((cl) => cl.orderLineStorageCodes.contains(storageCode)).orderLine;

      await ordersRepository.addOrderLineCode(
        orderLine: orderLine,
        code: code,
        groupCode: null,
        amount: storageCode.amount,
        isDataMatrix: true
      );
      emit(state.copyWith(
        status: CodeScanStateStatus.success,
        lastScannedOrderLine: (value: orderLine),
        message: 'Код успешно отсканирован'
      ));
    }
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

  GS1Barcode? _parseDataMatrix(String code) {
    try {
      return parser.parse(code, codeType: CodeType.DATAMATRIX);
    } on Exception catch(_) {
      return null;
    } on ArgumentError catch(_) {
      return null;
    }
  }
}
