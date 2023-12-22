import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/screens/barcode_scanner_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  testWidgets("BarcodeScannerScreen Widget Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        title: "BarcodeScannerScreen Widget Test",
        home: Scaffold(
          body: BarcodeScannerScreen()
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.byType(QRView), findsOneWidget);
  });
}