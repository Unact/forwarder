import 'package:flutter/material.dart';

import 'package:forwarder/app/view_models/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  int _currentIndex = 0;
  String message;
  bool _isLoading = false;

  HomeViewModel({@required BuildContext context}) : super(context: context);

  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;

  void setCurrentIndex(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }
}
