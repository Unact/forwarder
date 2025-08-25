part of 'code_scan_page.dart';

enum CodeScanStateStatus {
  initial,
  dataLoaded,
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
    this.allStorageCodeLines = const [],
    this.allOrders = const [],
    this.lastScannedOrderLine
  });

  final CodeScanStateStatus status;
  final String message;
  final Order order;
  final List<OrderLineWithCode> codeLines;
  final List<OrderLineCode> allCodeLines;
  final List<OrderLineStorageCode> allStorageCodeLines;
  final List<Order> allOrders;
  final OrderLine? lastScannedOrderLine;

  List<String> get codes => codeLines.map((e) => e.orderLineCodes.map((ei) => ei.code)).expand((e) => e).toList();
  List<String> get storageCodes => codeLines
    .map((e) => e.orderLineStorageCodes.map((ei) => ei.code)).expand((e) => e).toList();
  List<OrderLineStorageCode> get storageCodeLines => codeLines
    .map((e) => e.orderLineStorageCodes.map((ei) => ei)).expand((e) => e).toList();

  CodeScanState copyWith({
    CodeScanStateStatus? status,
    String? message,
    Order? order,
    List<OrderLineWithCode>? codeLines,
    List<OrderLineCode>? allCodeLines,
    List<OrderLineStorageCode>? allStorageCodeLines,
    List<Order>? allOrders,
    ({ OrderLine? value })? lastScannedOrderLine
  }) {
    return CodeScanState(
      status: status ?? this.status,
      message: message ?? this.message,
      order: order ?? this.order,
      codeLines: codeLines ?? this.codeLines,
      allStorageCodeLines: allStorageCodeLines ?? this.allStorageCodeLines,
      allCodeLines: allCodeLines ?? this.allCodeLines,
      allOrders: allOrders ?? this.allOrders,
      lastScannedOrderLine: lastScannedOrderLine != null ? lastScannedOrderLine.value : this.lastScannedOrderLine
    );
  }
}
