import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_list_provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/repositories/timer_repository_provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/widgets/timer_control_button.dart';
import 'package:time_tracker_app/core/constants/constants.dart';

class ActivityTimer extends StatefulWidget {
  const ActivityTimer({Key? key}) : super(key: key);

  @override
  _ActivityTimerState createState() => _ActivityTimerState();
}

class _ActivityTimerState extends State<ActivityTimer> {
  late TimerRepositoryProvider timerProviderL;
  late ActivityListProvider activityListProviderL;

  @override
  void dispose() {
    timerProviderL.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timerProviderL = Provider.of<TimerRepositoryProvider>(context);
    activityListProviderL = Provider.of<ActivityListProvider>(context);

    double percent = timerProviderL.spentTime.inSeconds /
        timerProviderL.activity.totalTime.inSeconds;
    Size size = MediaQuery.of(context).size;
    int hours = timerProviderL.spentTime.inHours;
    int minutes = timerProviderL.spentTime.inMinutes -
        60 * timerProviderL.spentTime.inHours;
    int seconds = timerProviderL.spentTime.inSeconds -
        60 * timerProviderL.spentTime.inMinutes;
    String hourString = hours.toString().padLeft(2, '0');
    String minuteString = minutes.toString().padLeft(2, '0');
    String secondString = seconds.toString().padLeft(2, '0');

    Widget _buildControls() {
      if (timerProviderL.timerState == TimerState.intitial) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerControlButton(
              icon: Icons.play_arrow,
              onPressed: () {
                timerProviderL.started();
                activityListProviderL.updateActivity(timerProviderL.activity);
              },
            ),
            Spacer(),
            TimerControlButton(
              icon: Icons.rotate_left_rounded,
              onPressed: () {
                timerProviderL.reset();
                activityListProviderL.updateActivity(timerProviderL.activity);
              },
            ),
          ],
        );
      } else if (timerProviderL.timerState == TimerState.playing) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerControlButton(
              icon: Icons.pause,
              onPressed: () {
                timerProviderL.paused();
                activityListProviderL.updateActivity(timerProviderL.activity);
              },
            ),
            Spacer(),
            TimerControlButton(
              icon: Icons.rotate_left_rounded,
              onPressed: () {
                timerProviderL.reset();
                activityListProviderL.updateActivity(timerProviderL.activity);
              },
            ),
          ],
        );
      } else if (timerProviderL.timerState == TimerState.paused) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerControlButton(
              icon: Icons.play_arrow,
              onPressed: () {
                timerProviderL.resumed();
                activityListProviderL.updateActivity(timerProviderL.activity);
              },
            ),
            Spacer(),
            TimerControlButton(
              icon: Icons.rotate_left_rounded,
              onPressed: () {
                timerProviderL.reset();
                activityListProviderL.updateActivity(timerProviderL.activity);
              },
            ),
          ],
        );
      } else if (timerProviderL.timerState == TimerState.complete) {
        activityListProviderL.updateActivity(timerProviderL.activity);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerControlButton(
              icon: Icons.rotate_left_rounded,
              onPressed: () {
                timerProviderL.reset();
                activityListProviderL.updateActivity(timerProviderL.activity);
              },
            ),
          ],
        );
      }

      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          timerProviderL.activity.activityName,
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircularPercentIndicator(
                    radius: size.width * 0.5,
                    percent: percent,
                    lineWidth: 15.0,
                    animation: true,
                    animateFromLastPercent: true,
                    progressColor: Theme.of(context).accentColor,
                    center: Text(
                      '$hourString:$minuteString:$secondString',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Container(
                    height: size.height * 0.3,
                    width: 170,
                    child: Center(
                      child: _buildControls(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
