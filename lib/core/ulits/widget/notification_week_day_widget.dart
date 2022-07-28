import 'package:flutter/material.dart';

class NotificationWeekAndTime {
  final int dayOfWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfWeek,
    required this.timeOfDay,
  });
}

Future<NotificationWeekAndTime?> pickSchedule(
    {required BuildContext context}) async {
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();
  int? selectedDay;
}
