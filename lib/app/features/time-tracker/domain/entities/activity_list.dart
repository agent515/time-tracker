import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';

abstract class ActivityList extends Equatable {
  Future<UnmodifiableListView<Activity>> getList();

  void addActivity(Activity activity);

  void removeActivity(String id);

  void updateActivity(Activity activity);
}
