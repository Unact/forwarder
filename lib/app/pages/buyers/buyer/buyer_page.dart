import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/pages/buyers/buyer/accept_payment/accept_payment_page.dart';
import '/app/pages/buyers/buyer/debt/debt_page.dart';
import '/app/pages/buyers/buyer/order/order_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/orders_repository.dart';
import '/app/repositories/payments_repository.dart';
import '/app/utils/format.dart';
import '/app/utils/misc.dart';
import '/app/utils/parsing.dart';
import '/app/widgets/widgets.dart';

part 'buyer_state.dart';
part 'buyer_view_model.dart';

class BuyerPage extends StatelessWidget {
  final Buyer buyer;
  final bool isInc;

  BuyerPage({
    required this.buyer,
    required this.isInc,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuyerViewModel>(
      create: (context) => BuyerViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<OrdersRepository>(context),
        RepositoryProvider.of<PaymentsRepository>(context),
        buyer: buyer,
        isInc: isInc
      ),
      child: _BuyerView(),
    );
  }
}

class _BuyerView extends StatefulWidget {
  @override
  _BuyerViewState createState() => _BuyerViewState();
}

class _BuyerViewState extends State<_BuyerView> {
  final Map<int, TextEditingController> _controllers = {};

  String? _paymentSumErrorText(String value) {
    double? parsedValue = Parsing.parseDouble(value);

    return value != '' && (parsedValue == null || parsedValue < 0 || parsedValue == 0) ? 'Некорректное значение' : null;
  }

  Future<void> showAcceptPaymentDialog() async {
    BuyerViewModel vm = context.read<BuyerViewModel>();
    String result = await showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AcceptPaymentPage(
          debts: vm.state.debtsToPay,
          isCard: vm.state.isCard,
          isLink: false
        )
      ),
      barrierDismissible: false
    ) ?? 'Платеж отменен';

    vm.finishPayment(result);
  }

  Future<void> showConfirmationDialog(String message) async {
    BuyerViewModel vm = context.read<BuyerViewModel>();
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
    return BlocConsumer<BuyerViewModel, BuyerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Точка'),
          ),
          persistentFooterButtons: _buildPayButtons(context),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            children: [
              _buildBuyerTile(context),
              _buildOrdersTile(context),
              _buildDebtsTile(context)
            ]
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
        case BuyerStateStatus.needUserConfirmation:
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await showConfirmationDialog(state.message);
          });
          break;
        case BuyerStateStatus.paymentStarted:
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await showAcceptPaymentDialog();
          });
          break;
        case BuyerStateStatus.paymentFinished:
          Misc.showMessage(context, state.message);
          break;
        default:
      }
      }
    );
  }

  List<Widget> _buildPayButtons(BuildContext context) {
    BuyerViewModel vm = context.read<BuyerViewModel>();

    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Colors.blue
        ),
        onPressed: !vm.state.isPayable ? null : () => vm.tryStartPayment(false),
        child: const Text('Наличные', style: TextStyle(color: Colors.white)),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Colors.blue
        ),
        onPressed: !vm.state.isPayable ? null : () => vm.tryStartPayment(true),
        child: const Text('Карта', style: TextStyle(color: Colors.white)),
      )
    ];
  }

  Widget _buildBuyerTile(BuildContext context) {
    BuyerViewModel vm = context.read<BuyerViewModel>();
    BuyerState state = vm.state;

    return Column(
      children: [
        InfoRow(title: const Text('Клиент', style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              InfoRow(title: const Text('Наименование'), trailing: Text(state.buyer.name), trailingFlex: 2),
              InfoRow(title: const Text('Адрес'), trailing: ExpandingText(state.buyer.address), trailingFlex: 2),
              InfoRow(title: const Text('Инкассация'), trailing: Text(state.isInc ? 'Да' : 'Нет')),
              InfoRow(title: const Text('Долг'), trailing: Text(Format.numberStr(state.debtsSum))),
              InfoRow(title: const Text('Чек'), trailing: Text(Format.numberStr(state.kkmSum))),
              InfoRow(title: const Text('Наличными'), trailing: Text(Format.numberStr(state.cashPaymentsSum))),
              InfoRow(title: const Text('Картой'), trailing: Text(Format.numberStr(state.cardPaymentsSum))),
            ],
          )
        )
      ],
    );
  }

  Widget _buildOrdersTile(BuildContext context) {
    BuyerViewModel vm = context.read<BuyerViewModel>();

    return Column(
      children: [
        InfoRow(title: const Text('Заказы', style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: vm.state.orders.map((e) => _buildOrderTile(context, e)).toList())
        )
      ],
    );
  }

  Widget _buildDebtsTile(BuildContext context) {
    BuyerViewModel vm = context.read<BuyerViewModel>();

    return Column(
      children: [
        InfoRow(title: const Text('Задолженности', style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: vm.state.debts.map((e) => _buildDebtTile(context, e)).toList())
        )
      ],
    );
  }

  Widget _buildOrderTile(BuildContext context, Order order) {
    String delivered = order.isDelivered ? Strings.yes : (order.isUndelivered ? Strings.no : Strings.inProcess);

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 8),
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '${order.ndoc}\n',
              style: const TextStyle(color: Colors.black, fontSize: 14.0)
            ),
            TextSpan(
              text: '${order.info}\n',
              style: const TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            TextSpan(
              text: 'Доставлен: $delivered\n',
              style: const TextStyle(color: Colors.blue, fontSize: 12.0),
            ),
          ]
        )
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => OrderPage(order: order),
          )
        );
      }
    );
  }

  Widget _buildDebtTile(BuildContext context, Debt debt) {
    BuyerViewModel vm = context.read<BuyerViewModel>();
    TextEditingController? controller = _controllers[debt.id];
    bool debtIsEditable = debt.debtSum > 0;

    if (controller == null) {
      controller = TextEditingController(text: debt.paymentSum?.toString());

      _controllers[debt.id] = controller;
    }

    if (debt.paymentSum == null) {
      controller.text = '';
    }

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 8),
      title: Text(debt.fullname),
      trailing: !debtIsEditable ?
        null :
        GestureDetector(
          child: SizedBox(
            width: 104,
            height: 48,
            child:
              TextFormField(
                textAlign: TextAlign.end,
                controller: controller,
                enabled: debtIsEditable,
                maxLines: 1,
                style: const TextStyle(fontSize: 14.0, color: Colors.black),
                decoration: InputDecoration(
                  errorMaxLines: 2,
                  isDense: true,
                  errorText: _paymentSumErrorText(controller.text),
                  border: debtIsEditable ? const UnderlineInputBorder() : InputBorder.none
                ),
                onChanged: (newValue) => vm.updateDebtPaymentSum(debt,  Parsing.parseDouble(newValue))
              )
          ),
          onHorizontalDragEnd: (_) {
            controller!.text = debt.debtSum.toString();
            vm.updateDebtPaymentSum(debt, debt.debtSum);
            Misc.unfocus(context);
          },
        ),
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Сумма: ${Format.numberStr(debt.orderSum)}\n',
              style: const TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: 'Долг: ${Format.numberStr(debt.debtSum)}\n',
              style: const TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: 'Оплачено: ${Format.numberStr(debt.paidSum)}\n',
              style: const TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: debt.isCheck ? 'Чек' : '',
              style: const TextStyle(color: Colors.red, fontSize: 12.0)
            )
          ]
        )
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => DebtPage(debt: debt))
        );
      },
    );
  }
}
