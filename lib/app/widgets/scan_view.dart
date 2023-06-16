import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:soundpool/soundpool.dart';
import 'package:vibration/vibration.dart';

class ScanView extends StatefulWidget {
  final Widget child;
  final Function(String) onRead;

  ScanView({
    required this.child,
    required this.onRead,
    Key? key
  }) : super(key: key);

  @override
  ScanViewState createState() => ScanViewState();
}

class ScanViewState extends State<ScanView> {
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;
  StreamSubscription? _subscription;
  bool _paused = false;
  static final Soundpool _kPool = Soundpool.fromOptions(options: const SoundpoolOptions());
  static final Future<int> _kBeepId = rootBundle.load('assets/beep.mp3').then((soundData) => _kPool.load(soundData));

  static Future<void> _beep() async {
    await _kPool.play(await _kBeepId);
  }

  static Future<void> _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) Vibration.vibrate();
  }

  @override
  void reassemble() {
    super.reassemble();

    if (_controller == null) return;

    if (Platform.isAndroid) {
      _controller!.pauseCamera();
    }

    _controller!.resumeCamera();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget?>[
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.flash_on),
            onPressed: () async {
              try { _controller!.toggleFlash(); } on CameraException catch(_) {}
            }
          ),
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.switch_camera),
            onPressed: () async {
              try { _controller!.flipCamera(); } on CameraException catch(_) {}
            }
          )
        ].whereType<Widget>().toList()
      ),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Center(
            child: QRView(
              key: _qrKey,
              formatsAllowed: const [
                BarcodeFormat.ean13,
                BarcodeFormat.dataMatrix
              ],
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutWidth: 300,
                  cutOutHeight: 200
                ),
              onPermissionSet: (QRViewController controller, bool permission) {
                DateTime? lastScan;

                // https://github.com/juliuscanute/qr_code_scanner/issues/560
                _controller!.resumeCamera();

                _subscription = _controller!.scannedDataStream.listen((scanData) async {
                  final currentScan = DateTime.now();

                  if (_paused) return;

                  if (lastScan == null || currentScan.difference(lastScan!) > const Duration(milliseconds: 500)) {
                    lastScan = currentScan;

                    setState(() => _paused = true);
                    _beep();
                    _vibrate();
                    await widget.onRead(scanData.code ?? '');
                    setState(() => _paused = false);
                  }
                });
              },
              onQRViewCreated: (QRViewController controller) {
                _controller = controller;
              },
            )
          ),
          Container(
            padding: const EdgeInsets.only(top: 32),
            child: Align(
              alignment: Alignment.topCenter,
              child: widget.child
            )
          )
        ]
      )
    );
  }
}
