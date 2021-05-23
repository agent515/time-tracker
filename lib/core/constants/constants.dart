import 'package:flutter/material.dart';

const Color kBlackDark = Color(0xff070417);
const Color kGrayColor = Color(0xff292639);
const Color kPurpleColor = Color(0xff7114CF);

enum ActivityType { personal, work }

const Map<String, ActivityType> stringToActivityType = {
  'work': ActivityType.work,
  'personal': ActivityType.personal
};

const Map<ActivityType, String> activityTypeToString = {
  ActivityType.work: 'work',
  ActivityType.personal: 'personal',
};

const Map<String, IconData> stringToIconData = {
  'work': Icons.work,
  'game': Icons.sports_esports,
  'sports': Icons.sports_cricket,
  'gym': Icons.fitness_center,
  'paint': Icons.palette,
};

enum TimerState {
  intitial,
  playing,
  paused,
  complete,
}
