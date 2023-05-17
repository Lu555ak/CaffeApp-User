import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  MobileScannerController scannerControler = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text("Scan the QR code!"),
        actions: [
          IconButton(
              onPressed: () => scannerControler.toggleTorch(),
              icon: ValueListenableBuilder(
                  valueListenable: scannerControler.torchState,
                  builder: (context, value, child) {
                    switch (value) {
                      case TorchState.off:
                        return const Icon(Icons.flash_off_rounded);

                      case TorchState.on:
                        return const Icon(
                          Icons.flash_on_rounded,
                          color: Color.fromARGB(255, 196, 180, 40),
                        );
                    }
                  })),
          IconButton(
              onPressed: () => scannerControler.switchCamera(),
              icon: ValueListenableBuilder(
                  valueListenable: scannerControler.cameraFacingState,
                  builder: (context, value, child) {
                    switch (value) {
                      case CameraFacing.front:
                        return const Icon(Icons.camera_front_rounded);

                      case CameraFacing.back:
                        return const Icon(Icons.photo_camera_back_rounded);
                    }
                  }))
        ],
      ),
      body: MobileScanner(
        onDetect: _foundQRCode,
        controller: scannerControler,
      ),
    );
  }

  void _foundQRCode(BarcodeCapture barcodes) {
    final String code = barcodes.raw;
    Navigator.pop(context);
  }
}
