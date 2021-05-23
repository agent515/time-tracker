import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_model.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';

abstract class TimeTrackerRepository {
  Future<List<Activity>> getList();
  Future<void> addActivity(ActivityModel activity);
  Future<void> updateActivity(ActivityModel activity);
  Future<void> deleteActivity(String id);
  Future<Activity> getActivity(String id);
}
