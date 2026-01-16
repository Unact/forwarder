part of 'entities.dart';

class ApiBuyer extends Equatable {
  final int buyerId;
  final int deliveryId;
  final String name;
  final String address;
  final int ord;
  final bool needInc;
  final double? latitude;
  final double? longitude;
  final String? groupName;
  final String? groupPhone;

  const ApiBuyer({
    required this.buyerId,
    required this.deliveryId,
    required this.name,
    required this.address,
    required this.ord,
    required this.needInc,
    required this.latitude,
    required this.longitude,
    required this.groupName,
    required this.groupPhone
  });

  factory ApiBuyer.fromJson(dynamic json) {
    return ApiBuyer(
      buyerId: json['buyer_id'],
      deliveryId: json['delivery_id'],
      name: json['name'],
      address: json['address'],
      ord: json['ord'],
      needInc: json['need_inc'],
      latitude: Parsing.parseDouble(json['latitude']),
      longitude: Parsing.parseDouble(json['longitude']),
      groupName: json['group_name'],
      groupPhone: json['group_phone'],
    );
  }

  Buyer toDatabaseEnt() {
    return Buyer(
      buyerId: buyerId,
      deliveryId: deliveryId,
      name: name,
      address: address,
      ord: ord,
      needInc: needInc,
      latitude: latitude,
      longitude: longitude,
      groupName: groupName,
      groupPhone: groupPhone
    );
  }

  @override
  List<Object?> get props => [
    buyerId,
    deliveryId,
    name,
    address,
    ord,
    needInc,
    latitude,
    longitude,
    groupName,
    groupPhone
  ];
}
