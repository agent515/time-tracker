import 'dart:io';
import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_model.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

abstract class TimeTrackerDataSource {
  Future<void> addActivity(ActivityModel activity);
  Future<void> deleteActivity(String id);
  Future<void> updateActivity(ActivityModel activity);
  Future<List<Activity>> getListOfActivities();
  Future<Activity> getActivity(String id);
}

class TimeTrackerDataSourceImpl implements TimeTrackerDataSource {
  static TimeTrackerDataSourceImpl instance =
      TimeTrackerDataSourceImpl._instance();
  static Database? _db;

  String tableName = 'activity_table';
  String colId = 'id';
  String colName = 'activityName';
  String colType = 'type';
  String colIcon = 'icon';
  String colTT = 'totalTime';
  String colST = 'spentTime';

  TimeTrackerDataSourceImpl._instance();

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db!;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final path = dir.path + 'activity_list.db';

    final activityListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return activityListDb;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colType TEXT, $colIcon TEXT, $colTT TEXT, $colST TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    return db.query(tableName);
  }

  @override
  Future<List<Activity>> getListOfActivities() async {
    final mapList = await getTaskMapList();
    final List<Activity> activityList = <Activity>[];
    mapList.forEach((element) {
      print(element);
      activityList.add(ActivityModel.fromJSON(element));
    });
    return activityList;
  }

  @override
  Future<void> addActivity(ActivityModel activity) async {
    Database db = await this.db;
    db.insert(tableName, activity.toJSON());
  }

  @override
  Future<void> deleteActivity(String id) async {
    Database db = await this.db;
    db.delete(tableName, where: '$colId = ?', whereArgs: [int.parse(id)]);
  }

  @override
  Future<Activity> getActivity(String id) async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db
        .query(tableName, where: '$colId = ?', whereArgs: [int.parse(id)]);
    return ActivityModel.fromJSON(result[0]);
  }

  @override
  Future<void> updateActivity(ActivityModel activity) async {
    Database db = await this.db;
    db.update(tableName, activity.toJSON(),
        where: '$colId = ?', whereArgs: [int.parse(activity.id!)]);
  }
}
