import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String typeSelected = 'http';

  newScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;
    if (typeSelected == newScan.type) {
      this.scans.add(newScan);
      notifyListeners();
      return newScan;
    }
  }

  loadScans() async {
    final scans = await DBProvider.db.getScans();
    this.scans = [...scans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    typeSelected = type;
    final scansByType = await DBProvider.db.getScansByType(type);
    if (scansByType == null) {
      scans = [];
    } else {
      scans = [...scansByType];
    }

    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
