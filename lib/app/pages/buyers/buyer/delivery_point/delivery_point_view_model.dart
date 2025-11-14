part of 'delivery_point_page.dart';

class DeliveryPointViewModel extends PageViewModel<DeliveryPointState, DeliveryPointStateStatus> {
  final AppRepository appRepository;
  final BuyersRepository buyersRepository;

  StreamSubscription<BuyerDeliveryPointEx>? pointExSubscription;

  DeliveryPointViewModel(
    this.appRepository,
    this.buyersRepository,
    {
      required BuyerDeliveryPointEx pointEx
    }
  ) : super(DeliveryPointState(pointEx: pointEx));

  @override
  DeliveryPointStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    pointExSubscription = buyersRepository.watchBuyerDeliveryPointById(state.pointEx.point.id).listen((event) {
      emit(state.copyWith(status: DeliveryPointStateStatus.dataLoaded, pointEx: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();
    await pointExSubscription?.cancel();
  }

  Future<void> updatePhone(String phone) async {
    await buyersRepository.updateBuyerDeliveryPoint(
      state.pointEx.point,
      phone: (value: phone)
    );
    emit(state.copyWith(status: DeliveryPointStateStatus.updated));
  }

  Future<void> updateInfo(String info) async {
    await buyersRepository.updateBuyerDeliveryPoint(
      state.pointEx.point,
      info: (value: info)
    );
    emit(state.copyWith(status: DeliveryPointStateStatus.updated));
  }

  Future<void> tryTakePhoto() async {
    if (!await Permissions.hasCameraPermissions()) {
      emit(state.copyWith(message: 'Не разрешено использование камеры', status: DeliveryPointStateStatus.failure));
      return;
    }

    emit(state.copyWith(status: DeliveryPointStateStatus.cameraOpened));
  }

  Future<void> tryPickPhoto() async {
    if (!await Permissions.hasPhotosPermissions()) {
      emit(state.copyWith(message: 'Не разрешено использование галереи', status: DeliveryPointStateStatus.failure));
      return;
    }

    emit(state.copyWith(status: DeliveryPointStateStatus.galleryOpened));
  }

  Future<void> addPhoto(XFile file) async {
    await buyersRepository.addBuyerDeliveryPointPhoto(state.pointEx.point, file: file);
    emit(state.copyWith(status: DeliveryPointStateStatus.updated));
  }

  Future<void> deletePointPhoto(BuyerDeliveryPointPhoto pointPhoto) async {
    await buyersRepository.deleteBuyerDeliveryPointPhoto(pointPhoto);
  }

  Future<void> save() async {
    emit(state.copyWith(status: DeliveryPointStateStatus.inProgress));

    try {
      final updatedPoint = await buyersRepository.save(state.pointEx);

      if (updatedPoint != null) {
        await pointExSubscription?.cancel();
        pointExSubscription = buyersRepository.watchBuyerDeliveryPointById(updatedPoint.point.id).listen((event) {
          emit(state.copyWith(status: DeliveryPointStateStatus.dataLoaded, pointEx: event));
        });
      }

      emit(state.copyWith(
        status: DeliveryPointStateStatus.success,
        message: 'Информация сохранена',
        pointEx: updatedPoint
      ));
    } on AppError catch(e) {
      emit(state.copyWith(status: DeliveryPointStateStatus.failure, message: e.message));
    }
  }
}
