part of 'entities.dart';

class ApiBuyerDeliveryPointPhoto extends Equatable {
  final int id;
  final int buyerDeliveryPointId;
  final String url;
  final String key;
  final DateTime ts;

  const ApiBuyerDeliveryPointPhoto({
    required this.id,
    required this.buyerDeliveryPointId,
    required this.url,
    required this.key,
    required this.ts
  });

  factory ApiBuyerDeliveryPointPhoto.fromJson(dynamic json) {
    return ApiBuyerDeliveryPointPhoto(
      id: json['id'],
      buyerDeliveryPointId: json['buyer_delivery_point_id'],
      url: json['url'],
      key: json['key'],
      ts: Parsing.parseDate(json['ts'])!
    );
  }

  BuyerDeliveryPointPhoto toDatabaseEnt(DateTime lastLoadTime) {
    return BuyerDeliveryPointPhoto(
      id: id,
      buyerDeliveryPointId: buyerDeliveryPointId,
      url: url,
      key: key,
      isNew: false,
      isDeleted: false,
      timestamp: ts,
      lastSyncTime: lastLoadTime,
      needSync: false
    );
  }

  @override
  List<Object> get props => [
    id,
    buyerDeliveryPointId,
    url,
    key,
    ts
  ];
}
