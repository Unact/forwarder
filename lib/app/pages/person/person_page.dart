import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/users_repository.dart';
import '/app/utils/format.dart';
import '/app/utils/misc.dart';
import '/app/widgets/widgets.dart';

part 'person_state.dart';
part 'person_view_model.dart';

class PersonPage extends StatelessWidget {
  PersonPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonViewModel>(
      create: (context) => PersonViewModel(
        RepositoryProvider.of<AppRepository>(context),
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
          case PersonStateStatus.failure:
            Misc.showMessage(context, state.message);
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
        InfoRow(title: const Text('Обновление БД'), trailing: Text(state.lastSyncTime)),
        InfoRow(title: const Text('Версия'), trailing: Text(state.fullVersion)),
        !state.newVersionAvailable ? Container() : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                  backgroundColor: Colors.blueAccent
                ),
                child: const Text('Обновить приложение'),
                onPressed: vm.apiLogout,
              )
            ],
          )
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
                  backgroundColor: Colors.red
                ),
                child: const Text('Выйти', style: TextStyle(color: Colors.white)),
                onPressed: vm.apiLogout,
              )
            ]
          )
        )
      ]
    );
  }
}
