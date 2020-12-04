import 'dart:io';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
        ''');
      },
    );
  }

  newScanRaw(ScanModel scan) async {
    final id = scan.id;
    final type = scan.type;
    final value = scan.value;

    final db = await database;
    final response = await db.rawInsert('''
      INSERT INTO Scans (id,type,value)
      VALUES($id, '$type', '$value')
    ''');
    return response;
  }

  Future<int> newScan(ScanModel scan) async {
    final db = await database;
    final response = await db.insert('Scans', scan.toJson());
    return response;
  }

  getScanByID(int id) async {
    final db = await database;
    final response = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return response.isNotEmpty ? ScanModel.fromJson(response.first) : null;
  }

  deleteScan(int id) async {
    final db = await database;
    final response = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return response;
  }

  deleteAllScan() async {
    final db = await database;
    final response = await db.delete('Scans');

    return response;
  }

  getScans() async {
    final db = await database;
    final response = await db.query('Scans');

    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final response =
        await db.query('Scans', where: 'type = ?', whereArgs: [type]);

    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final response = await db
        .update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return response;
  }
}
