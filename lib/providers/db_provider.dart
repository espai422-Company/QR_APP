import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

/// Database provider class for managing SQLite database operations.
class DBProvider {
  /// Singleton instance of the database provider.
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  /// Getter for the database instance.
  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  /// Initialize the database.
  Future<Database> initDB() async {
    print('initDB');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ScansDB.db');

    print(path);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
    });
  }

  /// Insert a raw scan into the database.
  Future<int> insertRawScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db!.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
        VALUES(${scanModel.id}, '${scanModel.tipo}', '${scanModel.valor}')
    ''');

    return res;
  }

  /// Insert a scan using the provided [ScanModel] into the database.
  Future<int> insertScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db.insert('Scans', scanModel.toMap());
    print(res);
    return res;
  }

  /// Retrieve all scans from the database.
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromMap(s)).toList() : [];
  }

  /// Retrieve a scan by its [id] from the database.
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromMap(res.first) : null;
  }

  /// Retrieve scans by their [tipo] from the database.
  Future<List<ScanModel>> getScansByType(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    return res.isNotEmpty ? res.map((s) => ScanModel.fromMap(s)).toList() : [];
  }

  /// Update a scan in the database.
  Future<int> updateScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db.update('Scans', scanModel.toMap(),
        where: 'id = ?', whereArgs: [scanModel.id]);

    return res;
  }

  /// Delete a scan by its [id] from the database.
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  /// Delete all scans from the database.
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return res;
  }

  /// Get the number of records of web type from the database.
  Future<int> getNumberWeb() async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT COUNT(*) FROM Scans WHERE tipo = 'http'
    ''');

    return res.isNotEmpty ? res.first.values.first as int : 0;
  }

  /// Get the number of records of geo type from the database.
  Future<int> getNumberGeo() async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT COUNT(*) FROM Scans WHERE tipo = 'geo'
    ''');

    return res.isNotEmpty ? res.first.values.first as int : 0;
  }
}
