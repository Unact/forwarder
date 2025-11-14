import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/buyers_repository.dart';
import '/app/repositories/users_repository.dart';

part 'person_state.dart';
part 'person_view_model.dart';

class PersonPage extends StatelessWidget {
  PersonPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonViewModel>(
      create: (context) => PersonViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<BuyersRepository>(context),
        RepositoryProvider.of<UsersRepository>(context),
      ),
      child: _PersonView(),
    );
  }
}

class _PersonView extends StatefulWidget {
  @override
  _PersonViewState createState() => _PersonViewState();
}

class _PersonViewState extends State<_PersonView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  Future<void> showConfirmationDialog(String message) async {
    PersonViewModel vm = context.read<PersonViewModel>();

    bool result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Подтверждение'),
        content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(message)])),
        actions: <Widget>[
          TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(false)),
          TextButton(child: const Text('Подтверждаю'), onPressed: () => Navigator.of(context).pop(true))
        ],
      )
    ) ?? false;

    vm.state.confirmationCallback(result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonViewModel, PersonState>(
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Пользователь'),
          ),
          body: _buildBody(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case PersonStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case PersonStateStatus.needUserConfirmation:
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await showConfirmationDialog(state.message);
            });
            break;
          case PersonStateStatus.failure:
            _progressDialog.close();
            Misc.showMessage(context, state.message);
            break;
          case PersonStateStatus.success:
            _progressDialog.close();
            break;
          case PersonStateStatus.loggedOut:
            _progressDialog.close();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            break;
          default:
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    PersonViewModel vm = context.read<PersonViewModel>();
    PersonState state = vm.state;

    return ListView(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      children: [
        InfoRow(title: const Text('Логин'), trailing: Text(state.username)),
        InfoRow(title: const Text('Экспедитор'), trailing: Text(state.salesmanName)),
        InfoRow(
          title: const Text('Данные загружены'),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                state.appInfo?.lastLoadTime != null ? Format.dateTimeStr(state.appInfo?.lastLoadTime!) : '',
              )),
              IconButton(onPressed: vm.tryGetData, icon: Icon(Icons.refresh), tooltip: 'Обновить данные'),
              IconButton(
                onPressed: (state.appInfo?.hasUnsynced ?? false) ? vm.syncData : null,
                icon: Icon(Icons.save),
                tooltip: 'Сохранить данные'
              ),
            ]
          )
        ),
        InfoRow(
          title: const Text('Версия'),
          trailing: FutureBuilder(
            future: Misc.fullVersion,
            builder: (context, snapshot) => Text(snapshot.data ?? ''),
          )
        ),
        Platform.isIOS ? Container() : FutureBuilder(
          future: vm.state.user?.newVersionAvailable,
          builder: (context, snapshot) {
            if (!(snapshot.data ?? false)) return Container();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      backgroundColor: Theme.of(context).colorScheme.primary
                    ),
                    onPressed: vm.launchAppUpdate,
                    child: const Text('Обновить приложение'),
                  )
                ],
              )
            );
          }
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                  backgroundColor: Theme.of(context).colorScheme.primary
                ),
                onPressed: vm.apiLogout,
                child: const Text('Выйти', style: TextStyle(color: Colors.white)),
              )
            ]
          )
        )
      ]
    );
  }
}
