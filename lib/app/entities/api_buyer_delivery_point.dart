part of 'entities.dart';

class ApiBuyerDeliveryPoint extends Equatable {
  final int id;
  final int buyerId;
  final String? phone;
  final String? info;
  final DateTime ts;

  const ApiBuyerDeliveryPoint({
    required this.id,
    required this.buyerId,
    required this.phone,
    required this.info,
    required this.ts
  });

  factory ApiBuyerDeliveryPoint.fromJson(dynamic json) {
    return ApiBuyerDeliveryPoint(
      id: json['id'],
      buyerId: json['buyer_id'],
      phone: json['phone'],
      info: json['info'],
      ts: Parsing.parseDate(json['ts'])!
    );
  }

  BuyerDeliveryPoint toDatabaseEnt(DateTime lastLoadTime) {
    return BuyerDeliveryPoint(
      id: id,
      buyerId: buyerId,
      phone: phone,
      info: info,
      isNew: false,
      isDeleted: false,
      timestamp: ts,
      lastSyncTime: lastLoadTime,
      needSync: false
    );
  }

  @override
  List<Object?> get props => [
    id,
    buyerId,
    phone,
    info,
    ts
  ];
}
