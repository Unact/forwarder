import 'package:equatable/equatable.dart';

import 'package:forwarder/app/utils/nullify.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String? email;
  final String? salesmanName;
  final String? salesmanNum;
  final String? version;
  final bool closed;
  final double? total;

  static const int kGuestId = 1;
  static const String kGuestUsername = 'guest';

  bool get isLogged => id != kGuestId;

  const User({
    required this.id,
    required this.username,
    this.email,
    this.salesmanName,
    this.salesmanNum,
    this.version,
    this.closed = true,
    this.total
  });

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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      salesmanName: json['salesmanName'],
      salesmanNum: json['salesmanNum'],
      version: json['version'],
      closed: json['closed'],
      total: Nullify.parseDouble(json['total'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'salesmanName': salesmanName,
      'salesmanNum': salesmanNum,
      'version': version,
      'closed': closed,
      'total': total
    };
  }

  @override
  String toString() => 'User { id: $id }';
}
