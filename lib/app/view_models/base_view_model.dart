import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/app_state.dart';

class BaseViewModel extends ChangeNotifier {
  final BuildContext context;

  App app;
  AppState appState;
  bool disposed = false;

  BaseViewModel({@required this.context}) {
    app = Provider.of<App>(context, listen: false);
    appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  void dispose() {
    this.disposed = true;
    super.dispose();
  }
}
