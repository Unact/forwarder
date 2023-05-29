part of 'code_scan_page.dart';

class CodeScanViewModel extends PageViewModel<CodeScanState, CodeScanStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final GS1BarcodeParser parser = GS1BarcodeParser.defaultParser();

  CodeScanViewModel(this.appRepository, this.ordersRepository, {required Order order}) :
    super(CodeScanState(order: order), [appRepository, ordersRepository]);

  @override
  CodeScanStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    List<OrderLineWithCode> codeLines = await ordersRepository.getOrderLinesByOrderId(state.order.id);

    emit(state.copyWith(
      status: CodeScanStateStatus.dataLoaded,
      codeLines: codeLines
    ));
  }

  String? _parseBarcode(String barcode) {
    try {
      return parser.parse(barcode).getAIData('01');
    } on Exception catch(_) {
      return null;
    }
  }

  Future<void> _processDatacode(List<OrderLineWithCode> codeLines, String barcode) async {
    if (state.allCodes.contains(barcode)) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Код уже отсканирован'));
      return;
    }

    OrderLineWithCode? codeLine = codeLines.firstWhereOrNull((e) => e.orderLine.vol > e.orderLineCodes.length);

    if (codeLine == null) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Уже отсканированы все коды для товара'));
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

  Future<void> _processBarcode(List<OrderLineWithCode> codeLines, String barcode) async {
    OrderLineWithCode? codeLine = codeLines.firstWhereOrNull(
      (e) => e.orderLineCodes.isEmpty || e.orderLineCodes.firstWhereOrNull((el) => e.orderLine.vol > el.amount) != null
    );

    if (codeLine == null) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Уже отсканированы все коды для товара'));
      return;
    }

    if (codeLine.orderLineCodes.isEmpty) {
      await ordersRepository.addOrderLineCode(
        orderLine: codeLine.orderLine,
        code: barcode,
        amount: 1,
        isDataMatrix: false
      );
    } else {
      await ordersRepository.updateOrderLineCode(
        orderLineCode: codeLine.orderLineCodes.first,
        amount: codeLine.orderLineCodes.first.amount + 1
      );
    }

    emit(state.copyWith(
      status: CodeScanStateStatus.success,
      lastScannedOrderLine: codeLine.orderLine,
      message: 'Код успешно отсканирован'
    ));
  }

  Future<void> readCode(String? barcode) async {
    if (barcode == null) return;

    String? gtin = _parseBarcode(barcode);
    List<OrderLineWithCode> gtinCodeLines = state.codeLines.where((e) => e.orderLine.gtin == gtin).toList();

    if (gtinCodeLines.isNotEmpty) {
      await _processDatacode(gtinCodeLines, barcode);
      return;
    }

    List<OrderLineWithCode> barcodeCodeLines = state.codeLines.where(
      (e) => e.orderLine.barcodes.contains(barcode)
    ).toList();

    if (barcodeCodeLines.isNotEmpty) {
      await _processBarcode(barcodeCodeLines, barcode);
      return;
    }

    emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Не найден товар с указанным кодом'));
    return;
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
}
