part of 'delivery_point_page.dart';

enum DeliveryPointStateStatus {
  initial,
  dataLoaded,
  updated,
  failure,
  inProgress,
  success,
  cameraOpened,
  galleryOpened
}

class DeliveryPointState {
  DeliveryPointState({
    this.status = DeliveryPointStateStatus.initial,
    required this.pointEx,
    this.message = ''
  });

  final DeliveryPointStateStatus status;
  final BuyerDeliveryPointEx pointEx;
  final String message;

  List<BuyerDeliveryPointPhoto> get photos => pointEx.photos.where((e) => !e.isDeleted).toList()
    ..sort((photo1, photo2) => photo2.timestamp.compareTo(photo1.timestamp));

  bool get needSync => pointEx.point.needSync || pointEx.photos.any((e) => e.needSync);

  DeliveryPointState copyWith({
    DeliveryPointStateStatus? status,
    BuyerDeliveryPointEx? pointEx,
    String? message
  }) {
    return DeliveryPointState(
      status: status ?? this.status,
      pointEx: pointEx ?? this.pointEx,
      message: message ?? this.message
    );
  }
}
