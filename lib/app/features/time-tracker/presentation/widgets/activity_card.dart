import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_list_provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:time_tracker_app/core/utils/string_extension.dart';
import 'package:time_tracker_app/core/constants/constants.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final ActivityListProvider state;
  final int index;
  const ActivityCard({
    Key? key,
    required this.activity,
    required this.state,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percent =
        activity.spentTime.inMilliseconds / activity.totalTime.inMilliseconds;

    return GestureDetector(
      child: Card(
        key: Key('${activity.id}}'),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              stringToIconData[activity.icon],
              size: 16.0,
              color: Colors.white,
            ),
          ),
          title: Text(
            activity.activityName,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            activityTypeToString[activity.type]!.capitalize(),
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.grey),
          ),
          trailing: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircularPercentIndicator(
                  radius: 25,
                  percent: percent,
                  animation: true,
                  progressColor: Theme.of(context).accentColor,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 16.0,
                    color: kGrayColor,
                  ),
                  onPressed: () {
                    state.removeActivity(activity.id!);
                  },
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/activity', arguments: activity);
      },
    );
  }
}
