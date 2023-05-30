import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:caffe_app_user/models/cart_model.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  MobileScannerController scannerControler = MobileScannerController();
  bool barcodeScanned = false;

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
        onDetect: (capture) {
          List<Barcode> barcodes = capture.barcodes;
          var value = barcodes[0].rawValue;

          if (value != null) {
            value = value
                .replaceAll(' ', '')
                .replaceAll("'", "")
                .replaceAll("{", "")
                .replaceAll("}", "");
          }

          _makeOrder(value ?? "empty");
          scannerControler.stop();
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              Navigator.pop(context);
            });
          });
        },
        controller: scannerControler,
      ),
    );
  }

  _makeOrder(String data) {
    if (data == "empty") return;

    var dataMap = data.split(":");

    if (dataMap[0] != "CaffeAppTable") return;

    try {
      Cart().commitOrder(int.parse(dataMap[1]));
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Order was successfull!"),
        backgroundColor: successColor,
      ));
      int count = 0;
      Navigator.popUntil(context, (route) {
        return count++ == 1;
      });
      return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error, there was an issue with sending your order!"),
        backgroundColor: dangerColor,
      ));
      return;
    }
  }
}
