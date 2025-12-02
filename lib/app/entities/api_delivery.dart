part of 'entities.dart';

class ApiDelivery extends Equatable {
  final int id;
  final String ndoc;
  final DateTime? ddateb;

  const ApiDelivery({
    required this.id,
    required this.ndoc,
    required this.ddateb,
  });

  factory ApiDelivery.fromJson(dynamic json) {
    return ApiDelivery(
      id: json['id'],
      ndoc: json['ndoc'],
      ddateb: Parsing.parseDate(json['ddateb'])
    );
  }

  Delivery toDatabaseEnt() {
    return Delivery(
      id: id,
      ndoc: ndoc,
      ddateb: ddateb
    );
  }

  @override
  List<Object?> get props => [
    id,
    ndoc,
    ddateb
  ];
}
