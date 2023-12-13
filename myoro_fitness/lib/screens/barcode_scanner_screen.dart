// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import "package:myoro_fitness/api.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/screens/food_information_screen.dart";
import "package:myoro_fitness/widgets/modals/basic_modal.dart";
import "package:qr_code_scanner/qr_code_scanner.dart";

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({ super.key });

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  late final QRViewController _controller;

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    _controller.scannedDataStream.listen((data) async {
      if(data.code == null) displayFailureModal();

      final List<Food> results = await API.getFoods(data.code!);

      if(results.isEmpty) {
        displayFailureModal();
      } else {
        _controller.pauseCamera();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => FoodInformationScreen(food: results[0])));
      }
    });
  }

  void displayFailureModal() {
    showDialog(
      context: context,
      builder: (context) => BasicModal(
        title: "Barcode Not Found",
        content: Text("Unrecognized barcode...", style: Theme.of(context).textTheme.bodyMedium),
        showYes: false,
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: GlobalKey(debugLabel: "QR"),
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250
        )
      )
    );
  }
}