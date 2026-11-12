import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/tasks_repository.dart';

part 'task_scan_state.dart';
part 'task_scan_view_model.dart';

class TaskScanPage extends StatelessWidget {
  final Task task;

  TaskScanPage({
    required this.task,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskScanViewModel>(
      create: (context) => TaskScanViewModel(
        RepositoryProvider.of<TasksRepository>(context),
        task: task
      ),
      child: _TaskScanView(),
    );
  }
}

class _TaskScanView extends StatefulWidget {
  @override
  _TaskScanViewState createState() => _TaskScanViewState();
}

class _TaskScanViewState extends State<_TaskScanView> {
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
          }
        );
      }
    ) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskScanViewModel, TaskScanState>(
      builder: (context, state) {
        TaskScanViewModel vm = context.read<TaskScanViewModel>();

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
          child: _lastCodeInfoWidget(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case TaskScanStateStatus.success:
            player.play(AssetSource('beep_success.mp3'));
            await showInfoDialog(context, 'Успех', state.message);

            setState(() => scanPaused = false);
            break;
          case TaskScanStateStatus.failure:
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

  Widget _lastCodeInfoWidget(BuildContext context) {
    TaskScanViewModel vm = context.read<TaskScanViewModel>();

    if (vm.state.lastScannedTaskReturnedLine == null) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('Отсканируйте код', style: textStyle)
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(vm.state.lastScannedTaskReturnedLine!.name, textAlign: TextAlign.center, style: textStyle)
    );
  }
}
