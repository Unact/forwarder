import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/buyers/buyer/order/scan/code_scan_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/orders_repository.dart';
import '/app/utils/geo_loc.dart';
import '/app/utils/format.dart';
import '/app/utils/misc.dart';
import '/app/utils/permissions.dart';
import '/app/widgets/widgets.dart';

part 'order_state.dart';
part 'order_view_model.dart';

class OrderPage extends StatelessWidget {
  final Order order;

  OrderPage({
    required this.order,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderViewModel>(
      create: (context) => OrderViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<OrdersRepository>(context),
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


  Future<void> showConfirmationDialog(String message) async {
    OrderViewModel vm = context.read<OrderViewModel>();

    bool result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Подтверждение'),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(message)])),
          actions: <Widget>[
            TextButton(child: const Text('Подтверждаю'), onPressed: () => Navigator.of(context).pop(true)),
            TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(false))
          ],
        )
      )
    ) ?? false;

    vm.state.confirmationCallback(result);
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
          persistentFooterButtons: _buildPayButtons(context),
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
        default:
      }
      }
    );
  }

  Widget _buildBody(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();
    OrderState state = vm.state;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Column(
            children: [
              InfoRow(title: const Text('Номер'), trailing: Text(state.order.ndoc)),
              InfoRow(title: const Text('Комментарий'), trailing: ExpandingText(state.order.info)),
              InfoRow(title: const Text('Коробов'), trailing: Text(Format.numberStr(state.order.mc))),
              InfoRow(title: const Text('Товаров'), trailing: Text(state.order.goodsCnt.toString())),
              InfoRow(
                title: const Text('Доставлен'),
                trailing: Text(
                  state.order.isDelivered ? Strings.yes : (state.order.isUndelivered ? Strings.no : Strings.inProcess)
                )
              )
            ],
          )
        ),
        _buildOrderLinesTile(context),
        _buildMarkingOrderLinesTile(context)
      ],
    );
  }

  Widget _buildOrderLinesTile(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();

    return ExpansionTile(
      title: const Text('Позиции', style: TextStyle(fontSize: 14)),
      initiallyExpanded: false,
      children: vm.state.codeLines.map((e) => _buildOrderLineTile(context, e)).toList()
    );
  }

  Widget _buildOrderLineTile(BuildContext context, OrderLineWithCode codeLine) {
    return ListTile(
      dense: true,
      title: Text(codeLine.orderLine.name),
      trailing: Text(codeLine.orderLine.vol.toInt().toString()),
    );
  }

  Widget _buildMarkingOrderLinesTile(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();

    if (vm.state.order.didDelivery || !vm.state.order.physical || vm.state.markingCodeLines.isEmpty) return Container();

    return ExpansionTile(
      title: const Text('Маркировка', style: TextStyle(fontSize: 14)),
      initiallyExpanded: true,
      trailing: IconButton(
        tooltip: "Отсканировать код маркировки",
        icon: const Icon(Icons.qr_code_scanner),
        onPressed: vm.state.needScan ? vm.tryShowScan : null
      ),
      children: vm.state.markingCodeLines.map((e) => _buildMarkingOrderLineTile(context, e)).toList()
    );
  }

  Widget _buildMarkingOrderLineTile(BuildContext context, OrderLineWithCode codeLine) {
    OrderViewModel vm = context.read<OrderViewModel>();

    return Dismissible(
      key: Key(codeLine.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.clearOrderLineCodes(codeLine),
      child: ListTile(
        dense: true,
        title: Text(codeLine.orderLine.name),
        trailing: Text("${codeLine.orderLineCodes.length} из ${codeLine.orderLine.vol.toInt()}")
      )
    );
  }

  List<Widget> _buildPayButtons(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();

    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Colors.blue
        ),
        child: const Text('Доставлен', style: TextStyle(color: Colors.white)),
        onPressed: !vm.state.order.didDelivery ? () => vm.tryDeliverOrder(true) : null,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Colors.blue
        ),
        child: const Text('Не доставлен', style: TextStyle(color: Colors.white)),
        onPressed: !vm.state.order.didDelivery ? () => vm.tryDeliverOrder(false) : null,
      ),
    ];
  }
}
