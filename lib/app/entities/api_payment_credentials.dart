part of 'entities.dart';

class ApiPaymentCredentials extends Equatable {
  final String iboxLogin;
  final String iboxPassword;

  const ApiPaymentCredentials({
    required this.iboxLogin,
    required this.iboxPassword,
  });

  factory ApiPaymentCredentials.fromJson(dynamic json) {
    return ApiPaymentCredentials(
      iboxLogin: json['ibox_login'],
      iboxPassword: json['ibox_password']
    );
  }

  @override
  List<Object?> get props => [
    iboxLogin,
    iboxPassword
  ];
}
