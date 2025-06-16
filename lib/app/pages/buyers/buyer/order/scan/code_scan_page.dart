import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/orders_repository.dart';

part 'code_scan_state.dart';
part 'code_scan_view_model.dart';

class CodeScanPage extends StatelessWidget {
  final Order order;

  CodeScanPage({
    required this.order,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CodeScanViewModel>(
      create: (context) => CodeScanViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<OrdersRepository>(context),
        order: order
      ),
      child: _CodeScanView(),
    );
  }
}

class _CodeScanView extends StatefulWidget {
  @override
  _CodeScanViewState createState() => _CodeScanViewState();
}

class _CodeScanViewState extends State<_CodeScanView> {
  final TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 20);
  bool errorDialogOpen = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CodeScanViewModel, CodeScanState>(
      builder: (context, state) {
        CodeScanViewModel vm = context.read<CodeScanViewModel>();

        _controller.text = '';

        return ScanView(
          onRead: vm.readCode,
          child: _lastLineInfoWidget(context)
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case CodeScanStateStatus.failure:
            showErrorDialog(context, state.message);
            break;
          default:
            break;
        }
      }
    );
  }

  Future<void> showErrorDialog(BuildContext context, String message) async {
    if (errorDialogOpen) return;

    setState(() => errorDialogOpen = true);
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Ошибка'),
          content: SingleChildScrollView(child: ListBody(children: [Text(message)])),
          actions: [
            TextButton(child: const Text('Закрыть'), onPressed: () => Navigator.of(ctx).pop())
          ]
        );
      }
    );
    setState(() => errorDialogOpen = false);
  }

  Widget _lastLineInfoWidget(BuildContext context) {
    CodeScanViewModel vm = context.read<CodeScanViewModel>();

    if (vm.state.lastScannedOrderLine == null) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('Отсканируйте код', style: textStyle)
      );
    }

    OrderLine lastScannedCodeLine = vm.state.lastScannedOrderLine!;
    OrderLineWithCode codeLine = vm.state.codeLines.firstWhere((e) => e.orderLine.subid == lastScannedCodeLine.subid);
    int amount = codeLine.orderLineCodes.fold<int>(0, (v, el) => v + el.amount);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: Text(lastScannedCodeLine.name, textAlign: TextAlign.center, style: textStyle)
              )
            )
          ]
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            "$amount из ${lastScannedCodeLine.vol.toInt()}",
            style: textStyle
          )
        ),
        const SizedBox(height: 30),
        _lastLineEditWidget(context)
      ]
    );
  }

  Widget _lastLineEditWidget(BuildContext context) {
    CodeScanViewModel vm = context.read<CodeScanViewModel>();
    OrderLine lastScannedCodeLine = vm.state.lastScannedOrderLine!;
    OrderLineWithCode codeLine = vm.state.codeLines.firstWhere((e) => e.orderLine.subid == lastScannedCodeLine.subid);

    if (lastScannedCodeLine.needMarking) return Container();

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => vm.decreaseAmount(codeLine),
            icon: const Icon(Icons.remove, color: Colors.white)
          ),
          SizedBox(
            width: 60,
            height: 30,
            child: TextField(
              style: textStyle,
              controller: _controller,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              onSubmitted: (value) => vm.updateAmount(codeLine, int.tryParse(value) ?? 0, true),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                fillColor: Colors.transparent,
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.white)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.white)),
              ),
            ),
          ),
          IconButton(
            onPressed: () => vm.increaseAmount(codeLine),
            icon: const Icon(Icons.add, color: Colors.white)
          )
        ]
      )
    );
  }
}
