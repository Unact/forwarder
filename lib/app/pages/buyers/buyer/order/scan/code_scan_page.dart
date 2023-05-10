import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';

import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/orders_repository.dart';
import '/app/utils/misc.dart';
import '/app/widgets/widgets.dart';

part 'code_scan_state.dart';
part 'code_scan_view_model.dart';

class CodeScanPage extends StatelessWidget {
  final Order order;

  CodeScanPage({
    required this.order,
    Key? key
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CodeScanViewModel, CodeScanState>(
      builder: (context, state) {
        CodeScanViewModel vm = context.read<CodeScanViewModel>();

        return ScanView(
          child: _lastLineInfoWidget(context),
          onRead: vm.readCode
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case CodeScanStateStatus.success:
          case CodeScanStateStatus.failure:
            Misc.showMessage(context, state.message);
            break;
          default:
            break;
        }
      }
    );
  }

  Widget _lastLineInfoWidget(BuildContext context) {
    CodeScanViewModel vm = context.read<CodeScanViewModel>();

    if (vm.state.lastScannedOrderLine == null) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('Отсканируйте код маркировки', style: textStyle)
      );
    }

    OrderLine lastScannedCodeLine = vm.state.lastScannedOrderLine!;
    OrderLineWithCode codeLine = vm.state.codeLines.firstWhere((e) => e.orderLine == lastScannedCodeLine);

    return Column(
      children: [
        Row(
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
            "${codeLine.orderLineCodes.length} из ${lastScannedCodeLine.vol.toInt()}",
            style: textStyle
          )
        )
      ],
    );
  }
}
