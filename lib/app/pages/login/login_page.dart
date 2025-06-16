import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
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
  late final ProgressDialog progressDialog = ProgressDialog(context: context);
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final TextEditingController urlController = TextEditingController(
    text: context.read<LoginViewModel>().state.url
  );

  @override
  void dispose() {
    progressDialog.close();
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
          if (state.status == LoginStateStatus.initial || state.status == LoginStateStatus.urlFieldActivated) {
            loginController.text = state.login;
            passwordController.text = state.password;
            urlController.text = state.url;
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
              progressDialog.close();
              break;
            case LoginStateStatus.success:
              progressDialog.close();
              break;
            case LoginStateStatus.inProgress:
              await progressDialog.open();
              break;
            default:
          }
        },
      )
    );
  }

  Widget loginField(BuildContext context) {
    final vm = context.read<LoginViewModel>();

    if (vm.state.optsEnabled) {
      return TextField(
        controller: loginController,
        keyboardType: TextInputType.url,
        decoration: const InputDecoration(labelText: 'Телефон или e-mail или login'),
      );
    }

    return TextField(
      controller: loginController,
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
      ],
    );
  }

  Widget passwordField(BuildContext context) {
    return TextField(
      controller: passwordController,
      keyboardType: TextInputType.number,
      obscureText: true,
      decoration: const InputDecoration(labelText: 'Пароль')
    );
  }

  Widget urlField(BuildContext context) {
    final vm = context.read<LoginViewModel>();

    if (vm.state.optsEnabled) {
      return TextField(
        controller: urlController,
        keyboardType: TextInputType.url,
        decoration: const InputDecoration(labelText: 'Url')
      );
    }

    return Container();
  }

  Widget _buildLoginForm(BuildContext context) {
    final vm = context.read<LoginViewModel>();

    return SizedBox(
      height: 320,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        children: <Widget>[
          loginField(context),
          passwordField(context),
          urlField(context),
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
                      vm.apiLogin(urlController.text, loginController.text, passwordController.text);
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      Misc.unfocus(context);
                      vm.getNewPassword(urlController.text, loginController.text);
                    },
                    child: const Text('Получить пароль', textAlign: TextAlign.center),
                  ),
                )
              ),
            ],
          ),
        ]
      )
    );
  }
}
