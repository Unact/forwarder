import 'package:equatable/equatable.dart';

class Buyer extends Equatable {
  final int id;
  final String name;
  final String address;

  const Buyer({this.id, this.name, this.address});

  @override
  List<Object> get props => [id, name, address];

  static Buyer fromJson(dynamic json) {
    return Buyer(
      id: json['id'],
      name: json['name'],
      address: json['address']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'address': address
    };
  }

  @override
  String toString() => 'Buyer { id: $id, name: $name }';
}
