import 'dart:async';

import 'package:time_tracker_app/app/features/time-tracker/data/datasources/activity_datasource.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_model.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/repositories/time_tracker_repository.dart';

class TimeTrackerRepositoryImpl implements TimeTrackerRepository {
  TimeTrackerDataSource datasource = TimeTrackerDataSourceImpl.instance;

  @override
  Future<void> addActivity(ActivityModel activity) async {
    await datasource.addActivity(activity);
  }

  @override
  Future<void> deleteActivity(String id) async {
    await datasource.deleteActivity(id);
  }

  @override
  Future<Activity> getActivity(String id) async {
    return datasource.getActivity(id);
  }

  @override
  Future<List<Activity>> getList() async {
    return datasource.getListOfActivities();
  }

  @override
  Future<void> updateActivity(ActivityModel activity) async {
    await datasource.updateActivity(activity);
  }
}
