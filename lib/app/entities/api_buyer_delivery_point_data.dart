part of 'entities.dart';

class ApiBuyerDeliveryPointData extends Equatable {
  final ApiBuyerDeliveryPoint? buyerDeliveryPoint;
  final List<ApiBuyerDeliveryPointPhoto> buyerDeliveryPointPhotos;

  const ApiBuyerDeliveryPointData({
    required this.buyerDeliveryPoint,
    required this.buyerDeliveryPointPhotos
  });

  factory ApiBuyerDeliveryPointData.fromJson(Map<String, dynamic> json) {
    ApiBuyerDeliveryPoint buyerDeliveryPoint = ApiBuyerDeliveryPoint.fromJson(json['buyer_delivery_point']);
    List<ApiBuyerDeliveryPointPhoto> buyerDeliveryPointPhotos = json['buyer_delivery_point_photos']
      .map<ApiBuyerDeliveryPointPhoto>((e) => ApiBuyerDeliveryPointPhoto.fromJson(e)).toList();

    return ApiBuyerDeliveryPointData(
      buyerDeliveryPoint: buyerDeliveryPoint,
      buyerDeliveryPointPhotos: buyerDeliveryPointPhotos
    );
  }

  @override
  List<Object?> get props => [
    buyerDeliveryPoint,
    buyerDeliveryPointPhotos
  ];
}
