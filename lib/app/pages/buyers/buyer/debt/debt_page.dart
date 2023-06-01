import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/pages/buyers/buyer/accept_payment/accept_payment_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/payments_repository.dart';
import '/app/utils/format.dart';
import '/app/utils/misc.dart';
import '/app/utils/parsing.dart';
import '/app/widgets/widgets.dart';

part 'debt_state.dart';
part 'debt_view_model.dart';

class DebtPage extends StatelessWidget {
  final Debt debt;

  DebtPage({
    required this.debt,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DebtViewModel>(
      create: (context) => DebtViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<PaymentsRepository>(context),
        debt: debt,
      ),
      child: _DebtView(),
    );
  }
}

class _DebtView extends StatefulWidget {
  @override
  _DebtViewState createState() => _DebtViewState();
}

class _DebtViewState extends State<_DebtView> {
  final TextStyle firstColumnTextStyle = const TextStyle(color: Colors.blue);
  final EdgeInsets firstColumnPadding = const EdgeInsets.only(top: 8.0, bottom: 4.0, right: 8.0);
  final EdgeInsets baseColumnPadding = const EdgeInsets.only(top: 8.0, bottom: 4.0);
  final TextStyle defaultTextStyle = const TextStyle(fontSize: 14.0, color: Colors.black);
  final TextEditingController _controller = TextEditingController();

  String? _paymentSumErrorText(String value) {
    double? parsedValue = Parsing.parseDouble(value);

    return value != '' && (parsedValue == null || parsedValue < 0 || parsedValue == 0) ? 'Некорректное значение' : null;
  }

  Future<void> showAcceptPaymentDialog() async {
    DebtViewModel vm = context.read<DebtViewModel>();
    String result = await showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AcceptPaymentPage(
          debts: [vm.state.debt],
          isCard: vm.state.isCard,
          isLink: false
        )
      ),
      barrierDismissible: false
    ) ?? 'Платеж отменен';

    vm.finishPayment(result);
  }

  Future<void> showConfirmationDialog(String message) async {
    DebtViewModel vm = context.read<DebtViewModel>();

    bool result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Предупреждение'),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(message)])),
          actions: <Widget>[
            TextButton(child: const Text(Strings.ok), onPressed: () => Navigator.of(context).pop(true)),
            TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(false))
          ],
        )
      )
    ) ?? false;

    vm.state.confirmationCallback(result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DebtViewModel, DebtState>(
      builder: (context, vm) {
        return Scaffold(
          persistentFooterButtons: _buildPayButtons(context),
          appBar: AppBar(
            title: const Text('Задолженность'),
          ),
          body: _buildBody(context)
        );
      },
      listener: (context, state) {
        switch (state.status) {
        case DebtStateStatus.needUserConfirmation:
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await showConfirmationDialog(state.message);
          });

          break;
        case DebtStateStatus.paymentStarted:
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await showAcceptPaymentDialog();
          });
          break;
        case DebtStateStatus.paymentFinished:
        case DebtStateStatus.paymentFailure:
          Misc.showMessage(context, state.message);
          break;
        default:
      }
      }
    );
  }

  Widget _buildBody(BuildContext context) {
    DebtViewModel vm = context.read<DebtViewModel>();
    DebtState state = vm.state;

    _controller.text = state.debt.paymentSum?.toString() ?? '';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Column(
            children: [
              InfoRow(trailingFlex: 2, title: const Text('Накладная'), trailing: Text(state.debt.fullname)),
              InfoRow(title: const Text('Сумма'), trailing: Text(Format.numberStr(state.debt.orderSum))),
              InfoRow(title: const Text('Долг'), trailing: Text(Format.numberStr(state.debt.debtSum))),
              InfoRow(title: const Text('Оплачено'), trailing: Text(Format.numberStr(state.debt.paidSum))),
              InfoRow(title: const Text('Чек'), trailing: Text(state.debt.isCheck ? 'Да' : 'Нет')),
              ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: const Text('Оплата', style: TextStyle(fontSize: 14.0)),
                trailing: !vm.state.isEditable ?
                  null :
                  GestureDetector(
                    child: SizedBox(
                      width: 104,
                      height: 48,
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        autofocus: true,
                        controller: _controller,
                        enabled: vm.state.isEditable,
                        maxLines: 1,
                        style: defaultTextStyle,
                        decoration: InputDecoration(
                          labelText: '',
                          border: const UnderlineInputBorder(),
                          contentPadding: const EdgeInsets.only(),
                          errorMaxLines: 2,
                          isDense: true,
                          errorText: _paymentSumErrorText(_controller.text),
                        ),
                        onChanged: (newValue) => vm.updatePaymentSum(Parsing.parseDouble(newValue))
                      )
                    ),
                    onHorizontalDragEnd: (_) {
                      _controller.text = state.debt.debtSum.toString();
                      vm.updatePaymentSum(state.debt.debtSum);
                      Misc.unfocus(context);
                    },
                  ),
              )
            ],
          )
        )
      ],
    );
  }

  List<Widget> _buildPayButtons(BuildContext context) {
    DebtViewModel vm = context.read<DebtViewModel>();

    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Colors.blue
        ),
        child: const Text('Наличные', style: TextStyle(color: Colors.white)),
        onPressed: vm.state.isEditable ? () => vm.tryStartPayment(false) : null,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Colors.blue
        ),
        child: const Text('Карта', style: TextStyle(color: Colors.white)),
        onPressed: vm.state.isEditable ? () => vm.tryStartPayment(true) : null,
      )
    ];
  }
}
