import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
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
  bool scanPaused = false;
  final TextEditingController _controller = TextEditingController();
  final player = AudioPlayer();

  Future<String> showManualInput() async {
    String code = '';

    return await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                enableInteractiveSelection: false,
                onChanged: (newCode) => setState(() => code = newCode),
                decoration: const InputDecoration(labelText: 'Код'),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: code.isEmpty ? null : () async {
                Navigator.of(context).pop(code);
              },
              child: const Text('Подтвердить')
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('');
              },
              child: const Text('Отменить')
            )
          ]
        );
          });
      }
    ) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CodeScanViewModel, CodeScanState>(
      builder: (context, state) {
        CodeScanViewModel vm = context.read<CodeScanViewModel>();

        _controller.text = '';

        return ScanView(
          beep: false,
          onRead: (barcode) {
            setState(() => scanPaused = true);
            vm.readCode(barcode);
          },
          onError: (errorMessage) {
            showInfoDialog(context, 'Ошибка', errorMessage ?? Strings.genericErrorMsg);
          },
          paused: scanPaused,
          actions: [
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.text_fields),
              tooltip: 'Ручной поиск',
              onPressed: () async {
                setState(() => scanPaused = true);
                final result = await showManualInput();

                if (result.isEmpty) {
                  setState(() => scanPaused = false);
                } else {
                  await vm.readCode(result);
                }
              }
            )
          ],
          child: _lastLineInfoWidget(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case CodeScanStateStatus.success:
            player.play(AssetSource('beep_success.mp3'));
            if (state.lastScannedOrderLine == null) await showInfoDialog(context, 'Успех', state.message);

            setState(() => scanPaused = false);
            break;
          case CodeScanStateStatus.failure:
            player.play(AssetSource('beep_error.mp3'));
            showInfoDialog(context, 'Ошибка', state.message);

            setState(() => scanPaused = false);
            break;
          default:
            break;
        }
      }
    );
  }

  Future<void> showInfoDialog(BuildContext context, String title, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(child: ListBody(children: [Text(message)])),
          actions: [
            TextButton(child: const Text('Закрыть'), onPressed: () => Navigator.of(ctx).pop())
          ]
        );
      }
    );
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
