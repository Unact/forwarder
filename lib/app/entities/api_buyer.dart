part of 'entities.dart';

class ApiBuyer extends Equatable {
  final int id;
  final String name;
  final String address;

  const ApiBuyer({
    required this.id,
    required this.name,
    required this.address
  });

  factory ApiBuyer.fromJson(dynamic json) {
    return ApiBuyer(
      id: json['id'],
      name: json['name'],
      address: json['address']
    );
  }

  Buyer toDatabaseEnt() {
    return Buyer(
      id: id,
      name: name,
      address: address
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    address
  ];
}
