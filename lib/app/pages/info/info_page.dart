import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/home/home_page.dart';
import '/app/pages/person/person_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/buyers_repository.dart';
import '/app/repositories/payments_repository.dart';
import '/app/repositories/users_repository.dart';

part 'info_state.dart';
part 'info_view_model.dart';

class InfoPage extends StatelessWidget {
  InfoPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InfoViewModel>(
      create: (context) => InfoViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<BuyersRepository>(context),
        RepositoryProvider.of<PaymentsRepository>(context),
        RepositoryProvider.of<UsersRepository>(context),
      ),
      child: _InfoView(),
    );
  }
}

class _InfoView extends StatefulWidget {
  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<_InfoView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  void _changePage(int index) {
    HomeViewModel homeVm = context.read<HomeViewModel>();

    homeVm.setCurrentIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoViewModel, InfoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(Strings.ruAppName),
            actions: <Widget>[
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.person),
                tooltip: 'Пользователь',
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PersonPage(),
                      fullscreenDialog: true
                    )
                  );
                }
              )
            ]
          ),
          body: ListView(
            padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildInfoCards(context)
              )
            ],
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case InfoStateStatus.reverseInProgress:
            _progressDialog.open();
            break;
          case InfoStateStatus.reverseFailure:
          case InfoStateStatus.reverseSuccess:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      },
    );
  }

  List<Widget> _buildInfoCards(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return <Widget>[
      Card(
        child: ListTile(
          onTap: () => _changePage(1),
          isThreeLine: true,
          title: const Text(Strings.buyersPageName),
          subtitle: _buildDebtsCard(context),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              backgroundColor: Theme.of(context).colorScheme.primary
            ),
            onPressed: vm.reverseDay,
            child: Text('${vm.state.closed ? 'Открыть' : 'Закрыть'} день')
          )
        ),
      ),
      Card(
        child: ListTile(
          onTap: () => _changePage(2),
          isThreeLine: true,
          title: const Text(Strings.paymentsPageName),
          subtitle: _buildPaymentsCard(context),
        ),
      ),
      _buildDeliveriesCard(context),
      _buildHistoryCard(context),
      _buildInfoCard(context),
    ];
  }

  Widget _buildHistoryCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return Card(
      child: ListTile(
        onTap: () => _changePage(3),
        isThreeLine: true,
        title: const Text(Strings.historyPageName),
        subtitle: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.grey),
            children: <TextSpan>[
              TextSpan(
                text: 'Остаток в кассе: ${Format.numberStr(vm.state.total)}\n',
                style: const TextStyle(fontSize: 12.0)
              )
            ]
          )
        )
      ),
    );
  }

  Widget _buildDeliveriesCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return Card(
      child: ListTile(
        isThreeLine: true,
        title: const Text('Маршруты'),
        subtitle: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.grey),
            children: vm.state.deliveries.map((e) =>
              TextSpan(
                text: 'Номер: ${e.ndoc} Выезд: ${e.ddateb != null ? Format.dateTimeStr(e.ddateb) : 'Не указан'}\n',
                style: const TextStyle(fontSize: 12.0)
              )
            ).toList()
          )
        )
      ),
    );
  }

  Widget _buildDebtsCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.grey),
        children: <TextSpan>[
          TextSpan(text: 'Адресов: ${vm.state.buyersCnt}\n', style: const TextStyle(fontSize: 12.0)),
          TextSpan(text: 'Заказов: ${vm.state.ordersCnt}\n', style: const TextStyle(fontSize: 12.0)),
          TextSpan(text: 'Инкассаций: ${vm.state.incCnt}\n', style: const TextStyle(fontSize: 12.0))
        ]
      )
    );
  }

  Widget _buildPaymentsCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.grey),
        children: <TextSpan>[
          TextSpan(
            text: 'Всего: ${Format.numberStr(vm.state.paymentsSum)}',
            style: const TextStyle(fontSize: 12.0)
          ),
          TextSpan(
            text: '\nНаличными: ${Format.numberStr(vm.state.cashPaymentsSum)}',
            style: const TextStyle(fontSize: 12.0)
          ),
          TextSpan(
            text: '\nККМ: ${Format.numberStr(vm.state.kkmSum)}',
            style: const TextStyle(fontSize: 12.0)
          )
        ]
      )
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return FutureBuilder(
      future: vm.state.user?.newVersionAvailable,
      builder: (context, snapshot) {
        if (!(snapshot.data ?? false)) return Container();

        return const Card(
          child: ListTile(
            isThreeLine: true,
            title: Text('Информация'),
            subtitle: Text('Доступна новая версия приложения'),
          )
        );
      }
    );
  }
}
