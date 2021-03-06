import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/view_models/person_view_model.dart';
import 'package:forwarder/app/widgets/widgets.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key key}) : super(key: key);

  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PersonViewModel _personViewModel;
  Completer<void> _dialogCompleter = Completer();

  @override
  void initState() {
    super.initState();

    _personViewModel = context.read<PersonViewModel>();
    _personViewModel.addListener(this.vmListener);
  }

  @override
  void dispose() {
    _personViewModel.removeListener(this.vmListener);
    super.dispose();
  }

  Future<void> openDialog() async {
    showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Center(child: CircularProgressIndicator())
      ),
      barrierDismissible: false
    );
    await _dialogCompleter.future;
    Navigator.of(context).pop();
  }

  void closeDialog() {
    _dialogCompleter.complete();
    _dialogCompleter = Completer();
  }

  Future<void> vmListener() async {
    switch (_personViewModel.state) {
      case PersonState.InProgress:
        openDialog();
        break;
      case PersonState.Failure:
        _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(_personViewModel.message)));
        closeDialog();
        break;
      case PersonState.LoggedOut:
        closeDialog();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Пользователь')
      ),
      body: Consumer<PersonViewModel>(
        builder: (context, vm, _) {
          return _buildBody(context);
        }
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    PersonViewModel vm = Provider.of<PersonViewModel>(context);

    return ListView(
      padding: EdgeInsets.only(top: 24, bottom: 24),
      children: [
        InfoRow(title: Text('Логин'), trailing: Text(vm.username)),
        InfoRow(title: Text('Экспедитор'), trailing: Text(vm.salesmanName)),
        InfoRow(title: Text('Обновление БД'), trailing: Text(vm.lastSyncTime)),
        InfoRow(title: Text('Версия'), trailing: Text(vm.fullVersion)),
        !vm.newVersionAvailable ? Container() : Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                child: Text('Обновить приложение'),
                onPressed: vm.launchAppUpdate,
                color: Colors.blueAccent,
                textColor: Colors.white,
              )
            ],
          )
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                onPressed: vm.apiLogout,
                child: Text('Выйти', style: TextStyle(color: Colors.white)),
              ),
            ]
          )
        )
      ]
    );
  }
}
