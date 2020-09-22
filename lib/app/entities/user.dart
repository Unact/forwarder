import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String salesmanName;
  final String version;
  final bool closed;

  static const int kGuestId = 1;
  static const String kGuestUsername = 'guest';

  bool get isLogged => id != null && id != kGuestId;

  const User({this.id, this.username, this.email, this.salesmanName, this.version, this.closed});

  @override
  List<Object> get props => [id, email, salesmanName];

  static User fromJson(dynamic json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      salesmanName: json['salesmanName'],
      version: json['version'],
      closed: json['closed']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'username': username,
      'email': email,
      'salesmanName': salesmanName,
      'version': version,
      'closed': closed
    };
  }

  @override
  String toString() => 'User { id: $id }';
}
