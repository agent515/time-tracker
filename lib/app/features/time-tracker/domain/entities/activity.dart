import 'package:equatable/equatable.dart';
import 'package:time_tracker_app/core/constants/constants.dart';

// ignore: must_be_immutable
class Activity extends Equatable {
  String? id;
  final String activityName;
  final ActivityType type;
  final Duration totalTime;
  Duration spentTime;
  final String icon;

  Activity({
    required this.icon,
    required this.activityName,
    required this.type,
    required this.totalTime,
    required this.spentTime,
  });

  Activity.withId({
    required this.id,
    required this.icon,
    required this.activityName,
    required this.type,
    required this.totalTime,
    required this.spentTime,
  });

  static int compareTo(Activity first, Activity second) {
    return first.spentTime.inSeconds < second.spentTime.inSeconds ? 1 : -1;
  }

  @override
  List<Object> get props => [icon, activityName, type, totalTime, spentTime];
}
