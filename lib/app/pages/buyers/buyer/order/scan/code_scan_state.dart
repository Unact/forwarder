part of 'code_scan_page.dart';

enum CodeScanStateStatus {
  initial,
  dataLoaded,
  scanReadFinished,
  failure,
  success
}

class CodeScanState {
  CodeScanState({
    this.status = CodeScanStateStatus.initial,
    this.message = '',
    required this.order,
    this.codeLines = const [],
    this.allCodeLines = const [],
    this.lastScannedOrderLine
  });

  final CodeScanStateStatus status;
  final String message;
  final Order order;
  final List<OrderLineWithCode> codeLines;
  final List<OrderLineCode> allCodeLines;
  final OrderLine? lastScannedOrderLine;

  List<String> get allCodes => codeLines.map((e) => e.orderLineCodes.map((ei) => ei.code)).expand((e) => e).toList();

  CodeScanState copyWith({
    CodeScanStateStatus? status,
    String? message,
    Order? order,
    List<OrderLineWithCode>? codeLines,
    List<OrderLineCode>? allCodeLines,
    OrderLine? lastScannedOrderLine
  }) {
    return CodeScanState(
      status: status ?? this.status,
      message: message ?? this.message,
      order: order ?? this.order,
      codeLines: codeLines ?? this.codeLines,
      allCodeLines: allCodeLines ?? this.allCodeLines,
      lastScannedOrderLine: lastScannedOrderLine ?? this.lastScannedOrderLine
    );
  }
}
