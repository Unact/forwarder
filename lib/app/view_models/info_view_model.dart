import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/app_state.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/utils/geo_loc.dart';
import 'package:forwarder/app/view_models/base_view_model.dart';
import 'package:forwarder/app/view_models/home_view_model.dart';

enum InfoState {
  Initial,
  InProgress,
  DataLoaded,
  Failure,
  ReverseStart,
  ReverseSuccess,
  ReverseFailure,
}

class InfoViewModel extends BaseViewModel {
  HomeViewModel _homeViewModel;
  InfoState _state = InfoState.Initial;
  String? _message;

  InfoViewModel({required BuildContext context}) :
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false),
    super(context: context);

  bool get needRefresh {
    if (_state == InfoState.InProgress)
      return false;

    if (appState.appData.lastSyncTime == null)
      return true;

    DateTime lastAttempt = appState.appData.lastSyncTime!;
    DateTime time = DateTime.now();

    return lastAttempt.year != time.year || lastAttempt.month != time.month || lastAttempt.day != time.day;
  }

  InfoState get state => _state;
  String? get message => _message;

  bool get newVersionAvailable => appState.newVersionAvailable;
  bool get closed => appState.user.closed;
  double get total => appState.user.total!;
  String get salesmanNum => appState.user.salesmanNum ?? 'Не удалось опредилить';
  int get buyersCnt => appState.buyers.length;
  int get ordersCnt => appState.orders.length;
  int get incCnt => appState.orders.where((order) => order.isInc).length +
    appState.buyers.where((buyer) => !appState.orders.any((order) => order.buyerId == buyer.id)).length;
  double get cardPaymentsSum => appState.cardPayments.fold(0, (sum, payment) => sum + payment.summ);
  double get cashPaymentsSum => appState.cashPayments.fold(0, (sum, payment) => sum + payment.summ);
  double get paymentsSum => cardPaymentsSum + cashPaymentsSum - cardPaymentsCancelSum;
  double get kkmSum => appState.cashPayments.where((payment) => payment.isKkmprinted)
    .fold(0, (sum, payment) => sum + payment.summ);
  double get cardPaymentsCancelSum => appState.cardPayments.where((payment) => payment.isCanceled)
    .fold(0, (sum, payment) => sum + payment.summ);


  Future<void> getData() async {
    _setState(InfoState.InProgress);

    Location? location = await GeoLoc.getCurrentLocation();

    if (location == null) {
      _setMessage('Для работы с приложением необходимо разрешить определение местоположения');
      _setState(InfoState.Failure);

      return;
    }

    try {
      await appState.getData();

      _setMessage('Данные успешно обновлены');
      _setState(InfoState.DataLoaded);
    } on AppError catch(e) {
      _setMessage(e.message);
      _setState(InfoState.Failure);
    }
  }

  Future<void> reverseDay() async {
    _setState(InfoState.ReverseStart);

    try {
      await appState.reverseDay();

      _setMessage('День успешно ${closed ? 'закрыт' : 'открыт'}');
      _setState(InfoState.ReverseSuccess);
    } on AppError catch(e) {
      _setMessage(e.message);
      _setState(InfoState.ReverseFailure);
    }
  }

  void changePage(int index) {
    _homeViewModel.setCurrentIndex(index);
  }

  void _setState(InfoState state) {
    _state = state;
    if (!disposed) notifyListeners();
  }

  void _setMessage(String message) {
    _message = message;
  }
}
