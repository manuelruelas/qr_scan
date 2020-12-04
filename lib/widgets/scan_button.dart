import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        final result = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666",
          "Cancelar",
          false,
          ScanMode.DEFAULT,
        );
        if (result != "-1") {
          final ScanModel scan =
              await Provider.of<ScanListProvider>(context, listen: false)
                  .newScan(result);
          launchURL(context, scan);
        }
      },
    );
  }
}
