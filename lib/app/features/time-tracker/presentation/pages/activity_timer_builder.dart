import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/repositories/timer_repository_provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/pages/activity_timer.dart';

class ActivityTimerBuilder extends StatelessWidget {
  final Activity activity;

  const ActivityTimerBuilder({Key? key, required this.activity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerRepositoryProvider(activity: activity),
      builder: (context, child) {
        return ActivityTimer();
      },
    );
  }
}
