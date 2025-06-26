part of 'entities.dart';

class ApiBuyer extends Equatable {
  final int id;
  final String name;
  final String address;
  final DateTime? missedTs;
  final DateTime? arrivalTs;
  final DateTime? departureTs;

  const ApiBuyer({
    required this.id,
    required this.name,
    required this.address,
    required this.missedTs,
    this.arrivalTs,
    this.departureTs
  });

  factory ApiBuyer.fromJson(dynamic json) {
    return ApiBuyer(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      missedTs: Parsing.parseDate(json['missed_ts']),
      arrivalTs: Parsing.parseDate(json['arrival_ts']),
      departureTs: Parsing.parseDate(json['departure_ts'])
    );
  }

  Buyer toDatabaseEnt() {
    return Buyer(
      id: id,
      name: name,
      address: address,
      missedTs: missedTs,
      arrivalTs: arrivalTs,
      departureTs: departureTs
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    missedTs,
    arrivalTs,
    departureTs,
  ];
}
