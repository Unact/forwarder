part of 'entities.dart';

class ApiBuyer extends Equatable {
  final int buyerId;
  final int deliveryId;
  final String deliveryNdoc;
  final String name;
  final String address;
  final int ord;
  final bool needInc;
  final DateTime? missedTs;
  final DateTime? arrivalTs;
  final DateTime? departureTs;

  const ApiBuyer({
    required this.buyerId,
    required this.deliveryId,
    required this.deliveryNdoc,
    required this.name,
    required this.address,
    required this.ord,
    required this.needInc,
    this.missedTs,
    this.arrivalTs,
    this.departureTs
  });

  factory ApiBuyer.fromJson(dynamic json) {
    return ApiBuyer(
      buyerId: json['buyer_id'],
      deliveryId: json['delivery_id'],
      deliveryNdoc: json['delivery_ndoc'],
      name: json['name'],
      address: json['address'],
      ord: json['ord'],
      needInc: json['need_inc'],
      missedTs: Parsing.parseDate(json['missed_ts']),
      arrivalTs: Parsing.parseDate(json['arrival_ts']),
      departureTs: Parsing.parseDate(json['departure_ts'])
    );
  }

  Buyer toDatabaseEnt() {
    return Buyer(
      buyerId: buyerId,
      deliveryId: deliveryId,
      deliveryNdoc: deliveryNdoc,
      name: name,
      address: address,
      ord: ord,
      needInc: needInc,
      missedTs: missedTs,
      arrivalTs: arrivalTs,
      departureTs: departureTs
    );
  }

  @override
  List<Object?> get props => [
    buyerId,
    deliveryId,
    deliveryNdoc,
    name,
    address,
    ord,
    needInc,
    missedTs,
    arrivalTs,
    departureTs,
  ];
}
