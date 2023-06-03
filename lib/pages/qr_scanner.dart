import 'package:caffe_app_user/utility/app_localizations.dart';
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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(AppLocalizations.of(context).translate("scan_the_qr_code_text")),
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
            value = value.replaceAll(' ', '').replaceAll("'", "").replaceAll("{", "").replaceAll("}", "");
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context).translate("order_was_successfull_text")),
        backgroundColor: successColor,
      ));
      Navigator.of(context).pop();
      return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context).translate("order_error_text")),
        backgroundColor: dangerColor,
      ));
      return;
    }
  }
}
