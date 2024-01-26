import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/models/models.dart';
import 'package:qr_app/providers/providers.dart';
import 'package:qr_app/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);
        final ScanListProvider scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        // Avoiding the error when the user cancels the scan
        if (barcodeScanRes == '-1') {
          return;
        }

        ScanModel nouScan = ScanModel(valor: barcodeScanRes);
        scanListProvider.newScan(barcodeScanRes);

        lauchURL(context, nouScan);
      },
    );
  }
}
