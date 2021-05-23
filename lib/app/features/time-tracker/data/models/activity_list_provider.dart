import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_model.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/repositories/time_tracker_repository_impl.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity_list.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/repositories/time_tracker_repository.dart';

// ignore: must_be_immutable
class ActivityListProvider extends ChangeNotifier implements ActivityList {
  List<Activity> _list = <Activity>[];
  TimeTrackerRepository timeTrackerRepository = TimeTrackerRepositoryImpl();

  ActivityListProvider() {
    _updateList();
  }

  Future<void> _updateList() async {
    final List<Activity> list = await timeTrackerRepository.getList();

    this._list = list;
    _list.sort(Activity.compareTo);
  }

  @override
  Future<UnmodifiableListView<Activity>> getList() async {
    await _updateList();
    return UnmodifiableListView(_list);
  }

  @override
  Future<void> addActivity(Activity activity) async {
    await timeTrackerRepository.addActivity(activity as ActivityModel);
    await _updateList();
    _list.sort(Activity.compareTo);
    notifyListeners();
  }

  @override
  Future<void> removeActivity(String id) async {
    Activity? activity;
    for (Activity a in this._list) {
      if (a.id == id) {
        activity = a;
        break;
      }
    }
    if (activity != null) {
      await timeTrackerRepository.deleteActivity(id);
      await _updateList();
      _list.sort(Activity.compareTo);
      notifyListeners();
    }
  }

  @override
  Future<void> updateActivity(Activity updatedActivity) async {
    await timeTrackerRepository
        .updateActivity(updatedActivity as ActivityModel);
    await _updateList();
    _list.sort(Activity.compareTo);
    notifyListeners();
  }

  @override
  bool? get stringify => false;

  @override
  List<Object?> get props => [_list];
}
