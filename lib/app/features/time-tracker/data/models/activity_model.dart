import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:time_tracker_app/core/constants/constants.dart';
import 'package:time_tracker_app/core/utils/helpers.dart';

// ignore: must_be_immutable
class ActivityModel extends Activity {
  String? id;
  final String activityName;
  final ActivityType type;
  final Duration totalTime;
  Duration spentTime;
  final String icon;

  ActivityModel({
    required this.icon,
    required this.activityName,
    required this.type,
    required this.totalTime,
    required this.spentTime,
  }) : super(
          activityName: activityName,
          icon: icon,
          type: type,
          totalTime: totalTime,
          spentTime: spentTime,
        );

  ActivityModel.withId({
    required this.id,
    required this.icon,
    required this.activityName,
    required this.type,
    required this.totalTime,
    required this.spentTime,
  }) : super.withId(
          id: id,
          activityName: activityName,
          icon: icon,
          type: type,
          totalTime: totalTime,
          spentTime: spentTime,
        );

  ActivityModel copyWith(Activity activity) {
    return ActivityModel.withId(
      id: activity.id ?? id,
      icon: activity.icon,
      activityName: activity.activityName,
      type: activity.type,
      totalTime: activity.totalTime,
      spentTime: activity.spentTime,
    );
  }

  factory ActivityModel.fromJSON(Map<String, dynamic> jsonData) {
    ActivityType? t = stringToActivityType[jsonData['type']];
    Duration tt = Helpers.parseDuration(jsonData['totalTime']);
    Duration st = Helpers.parseDuration(jsonData['spentTime']);

    if (jsonData['id'] != null) {
      return ActivityModel.withId(
        id: jsonData['id'].toString(),
        icon: jsonData['icon'],
        activityName: jsonData['activityName'],
        type: t!,
        totalTime: tt,
        spentTime: st,
      );
    }
    return ActivityModel(
      icon: jsonData['icon'],
      activityName: jsonData['activityName'],
      type: t!,
      totalTime: tt,
      spentTime: st,
    );
  }

  Map<String, dynamic> toJSON() {
    if (id == null) {
      return {
        'id': id,
        'icon': icon,
        'activityName': activityName,
        'type': activityTypeToString[type],
        'totalTime': totalTime.toString(),
        'spentTime': spentTime.toString(),
      };
    }
    return {
      'icon': icon,
      'activityName': activityName,
      'type': activityTypeToString[type],
      'totalTime': totalTime.toString(),
      'spentTime': spentTime.toString(),
    };
  }
}
