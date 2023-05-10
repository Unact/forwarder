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

  Future<void> readCode(String? barcode) async {
    if (barcode == null) return;

    String? gtin = _parseBarcode(barcode);

    if (gtin == null) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Не удалось считать код'));
      return;
    }

    List<OrderLineWithCode> codeLines = state.codeLines.where((e) => e.orderLine.gtin == gtin).toList();

    if (codeLines.isEmpty) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Не найден товар с указанным кодом'));
      return;
    }

    if (state.allCodes.contains(barcode)) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Код уже отсканирован'));
      return;
    }

    OrderLineWithCode? codeLine = codeLines.firstWhereOrNull((e) => e.orderLine.vol != e.orderLineCodes.length);

    if (codeLine == null) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Уже отсканированы все коды для товара'));
      return;
    }

    await ordersRepository.addOrderLineCode(codeLine.orderLine, barcode);
    emit(state.copyWith(
      status: CodeScanStateStatus.success,
      lastScannedOrderLine: codeLine.orderLine,
      message: 'Код успешно отсканирован'
    ));
  }
}
