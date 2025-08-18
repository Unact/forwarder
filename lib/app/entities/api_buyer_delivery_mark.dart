part of 'entities.dart';

class ApiBuyerDeliveryMark extends Equatable {
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double heading;
  final double speed;
  final int buyerId;
  final int deliveryId;
  final DateTime pointTs;
  final String type;
  final int id;

  const ApiBuyerDeliveryMark({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.buyerId,
    required this.deliveryId,
    required this.pointTs,
    required this.type,
    required this.id,
  });

  factory ApiBuyerDeliveryMark.fromJson(dynamic json) {
    return ApiBuyerDeliveryMark(
      buyerId: json['buyer_id'],
      deliveryId: json['delivery_id'],
      latitude: Parsing.parseDouble(json['latitude'])!,
      longitude: Parsing.parseDouble(json['longitude'])!,
      accuracy: Parsing.parseDouble(json['accuracy'])!,
      altitude: Parsing.parseDouble(json['altitude'])!,
      heading: Parsing.parseDouble(json['heading'])!,
      speed: Parsing.parseDouble(json['speed'])!,
      pointTs: Parsing.parseDate(json['point_ts'])!,
      type: json['type'],
      id: json['id']
    );
  }

  BuyerDeliveryMark toDatabaseEnt() {
    return BuyerDeliveryMark(
      buyerId: buyerId,
      deliveryId: deliveryId,
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      altitude: altitude,
      heading: heading,
      speed: speed,
      pointTs: pointTs,
      type: BuyerDeliveryMarkType.values.firstWhere((e) => e.name == type),
      id: id,
    );
  }

  @override
  List<Object> get props => [
    latitude,
    longitude,
    accuracy,
    altitude,
    heading,
    speed,
    buyerId,
    deliveryId,
    pointTs,
    type,
    id
  ];
}
