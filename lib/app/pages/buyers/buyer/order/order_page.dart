import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/buyers/buyer/accept_payment/accept_payment_page.dart';
import '/app/pages/buyers/buyer/order/scan/code_scan_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/orders_repository.dart';
import '/app/repositories/payments_repository.dart';
import '/app/widgets/widgets.dart';

part 'order_state.dart';
part 'order_view_model.dart';

class OrderPage extends StatelessWidget {
  final Order order;

  OrderPage({
    required this.order,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderViewModel>(
      create: (context) => OrderViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<OrdersRepository>(context),
        RepositoryProvider.of<PaymentsRepository>(context),
        order: order,
      ),
      child: _OrderView(),
    );
  }
}

class _OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<_OrderView> {
  final TextStyle firstColumnTextStyle = const TextStyle(color: Colors.blue);
  final EdgeInsets firstColumnPadding = const EdgeInsets.only(top: 8.0, bottom: 4.0, right: 8.0);
  final EdgeInsets baseColumnPadding = const EdgeInsets.only(top: 8.0, bottom: 4.0);
  final TextStyle defaultTextStyle = const TextStyle(fontSize: 14.0, color: Colors.black);
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  Future<void> showConfirmationDialog(String message) async {
    OrderViewModel vm = context.read<OrderViewModel>();

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

  Future<void> showAcceptPaymentDialog() async {
    OrderViewModel vm = context.read<OrderViewModel>();

    String result = await showDialog(
      context: context,
      builder: (_) => AcceptPaymentPage(
        debts: [vm.state.debt!]
      ),
      barrierDismissible: false
    ) ?? 'Платеж отменен';

    vm.finishPayment(result);
  }

  Future<void> showScan() async {
    OrderViewModel vm = context.read<OrderViewModel>();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CodeScanPage(order: vm.state.order),
        fullscreenDialog: true
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderViewModel, OrderState>(
      builder: (context, state) {
        return Scaffold(
          persistentFooterButtons: [FooterButtonsRow(children: _buildFooterButtons(context))],
          appBar: AppBar(
            title: const Text('Заказ'),
          ),
          body: _buildBody(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case OrderStateStatus.inProgress:
            _progressDialog.open();
            break;
          case OrderStateStatus.needUserConfirmation:
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await showConfirmationDialog(state.message);
            });
            break;
          case OrderStateStatus.showScan:
            await showScan();
            break;
          case OrderStateStatus.failure:
          case OrderStateStatus.success:
            _progressDialog.close();
            Misc.showMessage(context, state.message);
            break;
          case OrderStateStatus.paymentStarted:
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await showAcceptPaymentDialog();
            });
            break;
          case OrderStateStatus.paymentFailure:
          case OrderStateStatus.paymentFinished:
            Misc.showMessage(context, state.message);
            break;
          default:
        }
      }
    );
  }

  Widget _buildBody(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();
    OrderState state = vm.state;
    List<Widget> children = [
      InfoRow(title: const Text('Номер'), trailing: Text(state.order.ndoc)),
      InfoRow(title: const Text('Комментарий'), trailing: ExpandingText(state.order.info)),
      InfoRow(title: const Text('Коробов'), trailing: Text(Format.numberStr(state.order.mc))),
      InfoRow(title: const Text('Товаров'), trailing: Text(state.order.goodsCnt.toString())),
      InfoRow(
        title: const Text('Доставлен'),
        trailing: Text(
          state.order.isDelivered ? Strings.yes : (state.order.isUndelivered ? Strings.no : Strings.inProcess)
        )
      ),
      InfoRow(title: const Text('Итого'), trailing: Text(Format.numberStr(state.totalSum)))
    ];

    if (vm.state.debt != null) {
      children.add(InfoRow(title: const Text('Оплачено'), trailing: Text(Format.numberStr(state.debt!.paidSum))));
    }

    if (!vm.state.order.isDelivered && vm.state.order.physical) {
      children.add(InfoRow(title: const Text('К оплате'), trailing: Text(Format.numberStr(state.scannedSum))));
    }

    if (vm.state.order.isDelivered && vm.state.needPayment) {
      children.add(InfoRow(title: const Text('К оплате'), trailing: Text(Format.numberStr(state.debt!.paymentSum))));
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Column(children: children)
        ),
        _buildOrderLinesTile(context)
      ],
    );
  }

  Widget _buildOrderLinesTile(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();
    bool scanHidden = vm.state.order.didDelivery || !vm.state.order.needScan;

    return ExpansionTile(
      title: const Text('Позиции', style: TextStyle(fontSize: 14)),
      initiallyExpanded: true,
      trailing: scanHidden ? null : IconButton(
        tooltip: "Отсканировать код маркировки или штрихкод",
        icon: const Icon(Icons.qr_code_scanner),
        onPressed: vm.tryShowScan
      ),
      children: vm.state.codeLines.map((e) => _buildOrderLineTile(context, e)).toList()
    );
  }

  Widget _buildPhysicalOrderLineTile(BuildContext context, OrderLineWithCode codeLine) {
    OrderViewModel vm = context.read<OrderViewModel>();
    int amount = codeLine.orderLineCodes.fold<int>(0, (v, el) => v + el.amount);

    return Dismissible(
      key: Key(codeLine.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.clearOrderLineCodes(codeLine),
      child: ListTile(
        dense: true,
        title: Text(codeLine.orderLine.name),
        subtitle: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "Стоимость: ${Format.numberStr(codeLine.orderLine.price)}\n",
                style: const TextStyle(color: Colors.grey, fontSize: 12.0)
              ),
              TextSpan(
                text: "Итого: ${Format.numberStr(codeLine.orderLine.price * codeLine.orderLine.vol)}\n",
                style: const TextStyle(color: Colors.grey, fontSize: 12.0)
              ),
              TextSpan(
                text: "К оплате: ${Format.numberStr(codeLine.orderLine.price * amount)}",
                style: const TextStyle(color: Colors.grey, fontSize: 12.0)
              ),
            ]
          )
        ),
        trailing: Text("$amount из ${codeLine.orderLine.vol.toInt()}")
      )
    );
  }

  Widget _buildOrderLineTile(BuildContext context, OrderLineWithCode codeLine) {
    OrderViewModel vm = context.read<OrderViewModel>();
    List<Widget> trailingWidgets = [];

    if (!vm.state.order.didDelivery && vm.state.order.needScan) {
      return _buildPhysicalOrderLineTile(context, codeLine);
    }

    if (vm.state.order.didDelivery) {
      trailingWidgets.add(Text("${codeLine.orderLine.deliveredVol.toInt()} из ${codeLine.orderLine.vol.toInt()}"));

      if (codeLine.orderLine.deliveredVol != codeLine.orderLine.vol) {
        trailingWidgets.add(const Text(
          "!",
          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14)
        ));
      }
    } else {
      trailingWidgets.add(Text("${codeLine.orderLine.vol.toInt()}"));
    }

    return ListTile(
      dense: true,
      title: Text(codeLine.orderLine.name),
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "Стоимость: ${Format.numberStr(codeLine.orderLine.price)}\n",
              style: const TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: "Итого: ${Format.numberStr(codeLine.orderLine.price * codeLine.orderLine.vol)}\n",
              style: const TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
          ]
        )
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: trailingWidgets)

    );
  }

  List<Widget> _buildFooterButtons(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();

    if (vm.state.order.isDelivered && vm.state.needPayment) return _buildPayButtons(context);
    if (!vm.state.order.didDelivery) return _buildDeliveryButtons(context);


    return [];
  }

  List<Widget> _buildDeliveryButtons(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();
    bool hasScanned = !vm.state.order.needScan ||
      (vm.state.order.needScan && vm.state.codeLines.any((e) => e.orderLineCodes.isNotEmpty));

    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Theme.of(context).colorScheme.primary
        ),
        onPressed: hasScanned && !vm.state.order.didDelivery ? () => vm.tryDeliverOrder(true) : null,
        child: const Text('Доставлен', style: TextStyle(color: Colors.white)),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Theme.of(context).colorScheme.primary
        ),
        onPressed: !vm.state.order.didDelivery ? () => vm.tryDeliverOrder(false) : null,
        child: const Text('Не доставлен', style: TextStyle(color: Colors.white)),
      )
    ];
  }

  List<Widget> _buildPayButtons(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();

    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Theme.of(context).colorScheme.primary
        ),
        child: const Text('Наличные', style: TextStyle(color: Colors.white)),
        onPressed: () => vm.tryStartPayment()
      ),
      vm.state.order.physical && !vm.state.order.paid ?
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: Theme.of(context).colorScheme.primary
          ),
          child: const Text('Отменить', style: TextStyle(color: Colors.white)),
          onPressed: () => vm.tryCancelOrderDelivery()
        ) :
        null
    ].nonNulls.toList();
  }
}
