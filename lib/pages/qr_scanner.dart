import 'dart:io';

import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:caffe_app_user/models/cart_model.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  Barcode? barcode;
  bool barcodeScanned = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
        ),
        body: QRView(
          key: qrKey,
          overlay: QrScannerOverlayShape(
              borderWidth: 10,
              borderRadius: 15,
              borderColor: subColor,
              cutOutSize: MediaQuery.of(context).size.width * 0.8),
          onQRViewCreated: onQRViewCreated,
        ));
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
        waitForQRCode();
      });
    });
  }

  void waitForQRCode() {
    if (barcodeScanned == false) {
      if (barcode == null) return;
      barcodeScanned = true;

      Barcode qrCode = barcode!;
      String value = qrCode.code!;
      value = value.replaceAll(' ', '').replaceAll("'", "").replaceAll("{", "").replaceAll("}", "");
      List<String> values = value.split(":");

      if (values[0] != "CaffeAppTable") {
        barcodeScanned = false;
        return;
      }
      controller?.pauseCamera();

      Cart().commitOrder(int.parse(values[1]));

      sleep(const Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context).translate("order_was_successfull_text")),
        backgroundColor: successColor,
      ));
      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
    }
  }
}
