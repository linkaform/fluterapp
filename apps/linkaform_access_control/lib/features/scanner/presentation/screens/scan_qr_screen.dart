import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/features/scanner/presentation/screens/scan_result_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  static const String path = '/scan-qr';
  static const String name = 'scanQr';

  const ScanQrScreen({super.key});

  @override
  ConsumerState createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Expanded(
            //   flex: 5,
            //   child: QRView(
            //     key: qrKey,
            //     onQRViewCreated: _onQRViewCreated,
            //   ),
            // ),
            OutlinedButton(
              onPressed: () => context.push(
                ScanResultScreen.path,
              ),
              child: Text('Go to Scan Result'),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text('Escanear QR',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        print(scanData.code);
        controller.dispose();
        context.goNamed(
          ScanResultScreen.path,
          pathParameters: {'code': scanData.code},
        );
      }
    });
  }
}
