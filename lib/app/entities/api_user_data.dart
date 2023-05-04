part of 'entities.dart';

class ApiUserData extends Equatable {
  final int id;
  final String username;
  final String email;
  final String salesmanName;
  final String salesmanNum;
  final String version;
  final bool closed;
  final double total;

  const ApiUserData({
    required this.id,
    required this.username,
    required this.email,
    required this.salesmanName,
    required this.salesmanNum,
    required this.version,
    required this.closed,
    required this.total
  });

  factory ApiUserData.fromJson(Map<String, dynamic> json) {
    return ApiUserData(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      salesmanName: json['salesman_name'],
      salesmanNum: json['salesman_num'],
      version: json['app']['version'],
      closed: json['closed'],
      total: Parsing.parseDouble(json['total'])!
    );
  }

  User toDatabaseEnt() {
    return User(
      id: id,
      username: username,
      email: email,
      salesmanName: salesmanName,
      salesmanNum: salesmanNum,
      version: version,
      closed: closed,
      total: total
    );
  }

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    salesmanName,
    salesmanNum,
    version,
    closed,
    total
  ];
}
