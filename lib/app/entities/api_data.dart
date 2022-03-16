import 'package:equatable/equatable.dart';

class ApiData extends Equatable {
  final String? refreshToken;
  final String? url;
  final String? accessToken;

  const ApiData({
    this.accessToken,
    this.refreshToken,
    this.url,
  });

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    url,
  ];

  factory ApiData.fromJson(dynamic json) {
    return ApiData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      url: json['url']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'url': url
    };
  }
}
