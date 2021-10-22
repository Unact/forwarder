import 'package:flutter/material.dart';
import 'package:forwarder/app/constants/strings.dart';

import 'package:forwarder/app/app_state.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/utils/geo_loc.dart';
import 'package:forwarder/app/view_models/base_view_model.dart';

enum OrderState {
  Initial,
  NeedUserConfirmation,
  InProgress,
  DeliveryStarted,
  DeliveryFinished,
  DeliveryFailure
}

class OrderViewModel extends BaseViewModel {
  Order order;
  OrderState _state = OrderState.Initial;
  String? _message;
  Function? _confirmationCallback;
  bool? _delivered;

  OrderViewModel({required BuildContext context, required this.order}) : super(context: context);

  OrderState get state => _state;
  String? get message => _message;
  Function? get confirmationCallback => _confirmationCallback;

  bool get isEditable => !order.didDelivery;

  void tryDeliverOrder(bool delivered) {
    _delivered = delivered;
    _message = delivered ? 'Передан заказ?' : 'Не передан заказ?';
    _confirmationCallback = deliverOrder;
    _setState(OrderState.NeedUserConfirmation);
  }

  Future<void> deliverOrder(bool confirmed) async {
    if (!confirmed) return;

    _setState(OrderState.InProgress);

    try {
      Location? location = await GeoLoc.getCurrentLocation();

      if (location == null) {
        _setMessage(Strings.locationNotFound);
        _setState(OrderState.DeliveryFailure);
        return;
      }

      order = await appState.deliveryOrder(order, _delivered!, location);

      _setMessage('Информация о доставке сохранена');
      _setState(OrderState.DeliveryFinished);
    } on AppError catch(e) {
      _setMessage(e.message);
      _setState(OrderState.DeliveryFailure);
    }
  }

  void _setState(OrderState state) {
    _state = state;
    if (!disposed) notifyListeners();
  }

  void _setMessage(String message) {
    _message = message;
  }
}
