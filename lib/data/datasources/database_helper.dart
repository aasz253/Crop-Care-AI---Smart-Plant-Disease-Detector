import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/scan_result.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cropcare.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE scan_results (
        id TEXT PRIMARY KEY,
        imagePath TEXT NOT NULL,
        cropType TEXT NOT NULL,
        diseaseId TEXT NOT NULL,
        diseaseName TEXT NOT NULL,
        confidence REAL NOT NULL,
        treatment TEXT NOT NULL,
        cause TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        isOffline INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertScanResult(ScanResult result) async {
    final db = await database;
    return await db.insert(
      'scan_results',
      result.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ScanResult>> getAllScanResults() async {
    final db = await database;
    final maps = await db.query(
      'scan_results',
      orderBy: 'timestamp DESC',
    );

    return maps.map((map) => ScanResult.fromMap(map)).toList();
  }

  Future<ScanResult?> getScanResultById(String id) async {
    final db = await database;
    final maps = await db.query(
      'scan_results',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return ScanResult.fromMap(maps.first);
  }

  Future<int> deleteScanResult(String id) async {
    final db = await database;
    return await db.delete(
      'scan_results',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllScanResults() async {
    final db = await database;
    return await db.delete('scan_results');
  }

  Future<int> getScanCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM scan_results');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
