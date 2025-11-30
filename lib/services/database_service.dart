import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/caffeine_entry.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('caffeine_tracker.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final String dbPath = join(appDocumentsDir.path, filePath);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE caffeine_entries (
        id TEXT PRIMARY KEY,
        drinkName TEXT NOT NULL,
        amount REAL NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  Future<void> createEntry(CaffeineEntry entry) async {
    final db = await database;
    await db.insert(
      'caffeine_entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CaffeineEntry>> readAllEntries() async {
    final db = await database;
    final result = await db.query(
      'caffeine_entries',
      orderBy: 'timestamp DESC',
    );

    return result.map((json) => CaffeineEntry.fromMap(json)).toList();
  }

  Future<List<CaffeineEntry>> readTodayEntries() async {
    final db = await database;
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final result = await db.query(
      'caffeine_entries',
      where: 'timestamp >= ?',
      whereArgs: [todayStart.toIso8601String()],
      orderBy: 'timestamp DESC',
    );

    return result.map((json) => CaffeineEntry.fromMap(json)).toList();
  }

  Future<int> deleteEntry(String id) async {
    final db = await database;
    return await db.delete(
      'caffeine_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
