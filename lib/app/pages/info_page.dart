import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/pages/person_page.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/view_models/info_view_model.dart';
import 'package:forwarder/app/view_models/person_view_model.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  InfoViewModel _infoViewModel;
  Completer<void> _refresherCompleter = Completer();
  Completer<void> _dialogCompleter = Completer();


  @override
  void initState() {
    super.initState();

    _infoViewModel = context.read<InfoViewModel>();
    _infoViewModel.addListener(this.vmListener);

    if (_infoViewModel.needRefresh) openRefresher();
  }

  @override
  void dispose() {
    _infoViewModel.removeListener(this.vmListener);
    super.dispose();
  }

  Future<void> openRefresher() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  void closeRefresher() {
    _refresherCompleter.complete();
    _refresherCompleter = Completer();
  }

  Future<void> openDialog() async {
    showDialog(
      context: context,
      builder: (_) => Center(child: CircularProgressIndicator()),
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
    switch (_infoViewModel.state) {
      case InfoState.ReverseStart:
        openDialog();

        break;
      case InfoState.ReverseFailure:
      case InfoState.ReverseSuccess:
        closeDialog();
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_infoViewModel.message)));

        break;
      case InfoState.Failure:
      case InfoState.DataLoaded:
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_infoViewModel.message)));
        closeRefresher();

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(Strings.ruAppName),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.person),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ChangeNotifierProvider<PersonViewModel>(
                    create: (context) => PersonViewModel(context: context),
                    child: PersonPage(),
                  ),
                  fullscreenDialog: true
                )
              );
            }
          )
        ]
      ),
      body: Consumer<InfoViewModel>(builder: (context, vm, _) {
        return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            vm.getData();
            return _refresherCompleter.future;
          },
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildInfoCards(context)
              )
            ],
          )
        );
      })
    );
  }

  List<Widget> _buildInfoCards(BuildContext context) {
    InfoViewModel vm = Provider.of<InfoViewModel>(context);

    return <Widget>[
      Card(
        child: ListTile(
          onTap: () => vm.changePage(1),
          isThreeLine: true,
          title: Text(Strings.buyersPageName),
          subtitle: _buildDebtsCard(context),
          trailing: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Text('${vm.closed ? 'Открыть' : 'Закрыть'} день'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: vm.reverseDay
          ),
        ),
      ),
      Card(
        child: ListTile(
          onTap: () => vm.changePage(2),
          isThreeLine: true,
          title: Text(Strings.paymentsPageName),
          subtitle: _buildPaymentsCard(context),
        ),
      ),
      _buildInfoCard(context),
    ];
  }

  Widget _buildDebtsCard(BuildContext context) {
    InfoViewModel vm = Provider.of<InfoViewModel>(context);

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.grey),
        children: <TextSpan>[
          TextSpan(text: 'Адресов: ${vm.buyersCnt}\n', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: 'Заказов: ${vm.ordersCnt}\n', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: 'Инкассаций: ${vm.incCnt}\n', style: TextStyle(fontSize: 12.0))
        ]
      )
    );
  }

  Widget _buildPaymentsCard(BuildContext context) {
    InfoViewModel vm = Provider.of<InfoViewModel>(context);

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.grey),
        children: <TextSpan>[
          TextSpan(text: 'Всего: ${Format.numberStr(vm.paymentsSum)}', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: '\nНаличными: ${Format.numberStr(vm.cashPaymentsSum)}', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: '\nККМ: ${Format.numberStr(vm.kkmSum)}', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: '\nКартой: ${Format.numberStr(vm.cardPaymentsSum)}', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: '\nОтменено: ${Format.numberStr(vm.cardPaymentsCancelSum)}', style: TextStyle(fontSize: 12.0)),
        ]
      )
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    InfoViewModel vm = Provider.of<InfoViewModel>(context);

    if (vm.newVersionAvailable) {
      return Card(
        child: ListTile(
          isThreeLine: true,
          title: Text('Информация'),
          subtitle: Text('Доступна новая версия приложения'),
        )
      );
    } else {
      return Container();
    }
  }
}
