import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/payments_repository.dart';
import '/app/services/iboxpro.dart';
import '/app/utils/permissions.dart';

part 'cancel_payment_state.dart';
part 'cancel_payment_view_model.dart';

class CancelPaymentPage extends StatelessWidget {
  final CardPayment cardPayment;

  CancelPaymentPage({
    required this.cardPayment,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CancelPaymentViewModel>(
      create: (context) => CancelPaymentViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<PaymentsRepository>(context),
        cardPayment: cardPayment,
      ),
      child: _CancelPaymentView(),
    );
  }
}

class _CancelPaymentView extends StatefulWidget {
  @override
  _CancelPaymentViewState createState() => _CancelPaymentViewState();
}

class _CancelPaymentViewState extends State<_CancelPaymentView> {
  final GlobalKey<SignatureState> _sign = GlobalKey<SignatureState>();

  Future<Uint8List> getSignatureData() async {
    SignatureState? sign = _sign.currentState;
    ByteData? data = (await (await sign!.getData()).toByteData(format: ImageByteFormat.png));

    return data!.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CancelPaymentViewModel, CancelPaymentState>(
      builder: (context, state) {
        return Material(
          type: MaterialType.transparency,
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildProgressPart(context)..addAll(_buildInfoPart(context))
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case CancelPaymentStateStatus.finished:
          case CancelPaymentStateStatus.failure:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context, state.message);
            });
            break;
          default:
        }
      }
    );
  }

  List<Widget> _buildProgressPart(BuildContext context) {
    CancelPaymentViewModel vm = context.read<CancelPaymentViewModel>();

    return [
      const CircularProgressIndicator(
        backgroundColor: Colors.white70,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
      Container(height: 40),
      Text(vm.state.message, style: const TextStyle(fontSize: 18, color: Colors.white70), textAlign: TextAlign.center),
      Container(height: 40),
      SizedBox(
        height: 32,
        child: vm.state.isCancelable ? ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: Colors.white
          ),
          onPressed: vm.cancelPayment,
          child: const Text('Отмена', style: TextStyle(color: Colors.black))
        ) : Container()
      ),
      Container(height: 40)
    ];
  }

  List<Widget> _buildInfoPart(BuildContext context) {
    CancelPaymentViewModel vm = context.read<CancelPaymentViewModel>();

    if (!vm.state.isRequiredSignature) return [Container(height: 272)];

    return [
      Container(
        height: 200,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
          border: Border.all(color: Colors.grey),
          color: Colors.white
        ),
        child: Signature(key: _sign, strokeWidth: 5)
      ),
      Container(height: 40),
      SizedBox(
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                backgroundColor: Colors.white
              ),
              child: const Text('Очистить', style: TextStyle(color: Colors.black)),
              onPressed: () => _sign.currentState!.clear()
            ),
            Container(width: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                backgroundColor: Colors.white
              ),
              child: const Text('Подтвердить', style: TextStyle(color: Colors.black)),
              onPressed: () async => vm.adjustReversePayment(await getSignatureData())
            )
          ]
        )
      )
    ];
  }
}
