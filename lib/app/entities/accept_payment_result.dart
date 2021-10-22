import 'package:equatable/equatable.dart';

class AcceptPaymentResult extends Equatable {
  final bool success;
  final String message;

  const AcceptPaymentResult({
    required this.success,
    required this.message,
  });

  @override
  List<Object> get props => [
    success,
    message,
  ];
}
