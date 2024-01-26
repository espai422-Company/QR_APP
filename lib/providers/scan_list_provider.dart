import 'package:flutter/material.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/providers/db_provider.dart';

/// ChangeNotifier class for managing the state of the scan list.
class ScanListProvider extends ChangeNotifier {
  /// List to hold the scanned data.
  List<ScanModel> scans = [];

  /// The selected scan type (default is 'http').
  String selectedType = 'http';

  /// Create a new scan with the provided [value] and insert it into the database.
  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(valor: value);
    final id = await DBProvider.db.insertScan(newScan);
    newScan.id = id;

    if (selectedType == newScan.tipo) {
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  /// Load all scans from the database.
  loadScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  /// Load scans by the provided [type] from the database.
  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    this.scans = [...scans];
    selectedType = type;
    notifyListeners();
  }

  /// Delete all scans from the database.
  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  /// Delete a scan by its [id] from the database and reload scans of the selected type.
  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    loadScansByType(selectedType);
  }

  /// Get the total number of web and geo type scans from the database.
  Future<Map<String, int>> getTotals() async {
    return {
      'web': await DBProvider.db.getNumberWeb(),
      'geo': await DBProvider.db.getNumberGeo(),
    };
  }
}
