import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/users_repository.dart';

part 'login_state.dart';
part 'login_view_model.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key
  });

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
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

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
                child: FutureBuilder(
                  future: Misc.fullVersion,
                  builder: (context, snapshot) => Text('Версия ${snapshot.data ?? ''}'),
                )
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

  Widget _loginField(BuildContext context) {
    LoginViewModel vm = context.read<LoginViewModel>();

    if (vm.state.optsEnabled) {
      return TextField(
        controller: _loginController,
        keyboardType: TextInputType.url,
        decoration: const InputDecoration(labelText: 'Телефон или e-mail или login')
      );
    }

    return TextField(
      controller: _loginController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Телефон',
        hintText: '+7 (###) ###-##-##'
      ),
      inputFormatters: [
        MaskTextInputFormatter(
          mask: '+7 (###) ###-##-##',
          filter: { "#": RegExp(r'[0-9]') },
          type: MaskAutoCompletionType.lazy
        )
      ]
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      keyboardType: TextInputType.number,
      obscureText: true,
      decoration: const InputDecoration(labelText: 'Пароль')
    );
  }

  Widget _urlField(BuildContext context) {
    LoginViewModel vm = context.read<LoginViewModel>();

    if (vm.state.optsEnabled) {
      return TextField(
        controller: _urlController,
        keyboardType: TextInputType.url,
        decoration: const InputDecoration(labelText: 'Url')
      );
    }

    return Container();
  }

  Widget _buildLoginForm(BuildContext context) {
    LoginViewModel vm = context.read<LoginViewModel>();

    return SizedBox(
      height: 320,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        children: <Widget>[
          _loginField(context),
          _passwordField(context),
          _urlField(context),
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
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
                      backgroundColor: Theme.of(context).colorScheme.primary
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
