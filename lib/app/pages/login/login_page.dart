import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/users_repository.dart';
import '/app/utils/misc.dart';
import '/app/widgets/widgets.dart';

part 'login_state.dart';
part 'login_view_model.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: (context) => LoginViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<UsersRepository>(context),
      ),
      child: _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Войти в приложение'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginViewModel, LoginState>(
        builder: (context, state) {
          if (state.status.isInitial || state.status.isUrlFieldActivated) {
            _loginController.text = state.login;
            _passwordController.text = state.password;
            _urlController.text = state.url;
          }

          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildLoginForm(context),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Text('Версия ${state.fullVersion}')
              )
            ]
          );
        },
        listener: (context, state) async {
          switch (state.status) {
            case LoginStateStatus.passwordSent:
            case LoginStateStatus.failure:
              Misc.showMessage(context, state.message);
              _progressDialog.close();
              break;
            case LoginStateStatus.loggedIn:
              _progressDialog.close();
              break;
            case LoginStateStatus.inProgress:
              await _progressDialog.open();
              break;
            default:
          }
        },
      )
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    LoginViewModel vm = context.read<LoginViewModel>();

    return SizedBox(
      height: 320,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        children: <Widget>[
          TextField(
            controller: _loginController,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: 'Телефон или e-mail или login',
            ),
          ),
          TextField(
            controller: _passwordController,
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Пароль'
            ),
          ),
          vm.state.showUrl ? TextField(
            controller: _urlController,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: 'Url'
            ),
          ) : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Misc.unfocus(context);
                      vm.apiLogin(_urlController.text, _loginController.text, _passwordController.text);
                    },
                    child: const Text('Войти'),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Misc.unfocus(context);
                      vm.getNewPassword(_urlController.text, _loginController.text);
                    },
                    child: const Text('Получить пароль', textAlign: TextAlign.center,),
                  ),
                )
              ),
            ],
          ),
        ],
      )
    );
  }
}