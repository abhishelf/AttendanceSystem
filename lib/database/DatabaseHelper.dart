import 'dart:async';
import 'dart:io';

import 'package:attendancesystem/model/ClassTiming.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initalizeDatabase();
    }
    return _database;
  }

  Future<Database> initalizeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + DB_NAME;

    var attendanceDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return attendanceDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $TABLE_NAME($COL_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COL_PAPER TEXT, $COL_DAY TEXT, $COL_START_TIME TEXT, $COL_END_TIME TEXT, $COL_LAT TEXT, $COL_LON TEXT)');
  }

  Future<void> insertTiming(List<ClassTiming> timing) async {
    Database db = await this.database;
    Batch batch = db.batch();
    for (int i = 0; i < timing.length; i++) {
      batch.insert(TABLE_NAME, timing[i].toMap());
    }

    await batch.commit(noResult: true);
  }

  Future<int> deleteTiming() async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $TABLE_NAME');
    return result;
  }

  Future<List<Map<String, dynamic>>> getTimingMapList(
      String day, String time) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'Select * from $TABLE_NAME Where $COL_DAY = ? And $COL_START_TIME < ? And $COL_END_TIME > ?', [day,time,time]);
    return result;
  }

  Future<ClassTiming> getTiming(String day, String time) async {
    var timing = await getTimingMapList(day, time);
    if(timing == null) return null;

    List<ClassTiming> cartList = List<ClassTiming>();
    for (int i = 0; i < timing.length; i++) {
      cartList.add(ClassTiming.fromMap(timing[i]));
    }

    if (timing.length == 0) return null;
    return cartList[0];
  }
}
