import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ScanListProvider>(context, listen: false)
        .loadScansByType('http');
    return ScanTiles(
      type: 'http',
    );
  }
}
