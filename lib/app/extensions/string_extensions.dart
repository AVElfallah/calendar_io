import 'package:flutter/material.dart';

extension DateTimeConverter on String {
  static String? fromDate(DateTime? d) {
    // date format dd/mm/yyyy => 11/9/2001 like my BD
    return '${'${d!.day}'.padLeft(2, '0')}/${'${d.month}'.padLeft(2, '0')}/${d.year}';
  }

  DateTime? toDate() {
    //
    final ls = split('/');
    final year = int.parse(ls[2]);
    final month = int.parse(ls[1]);
    final day = int.parse(ls[0]);
    return DateTime(year, month, day);
  }

  static String? fromTime(TimeOfDay? time) {
    // time format HH:MM day||night
    var dayNightString = time!.period == DayPeriod.am ? 'AM' : 'PM';
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;

    return '${'$hour'.padLeft(2, '0')}${':' '${time.minute}'.padLeft(2, '0')} $dayNightString';
  }

  TimeOfDay? toTime() {
    final ls = split(':');
    final hour = int.parse(ls[0]) + (ls[1].split(' ')[1] == 'PM' ? 12 : 0);
    final minute = int.parse(ls[1].split(' ')[0]);

    return TimeOfDay(hour: hour, minute: minute);
  }
}

extension ColorStringExtension on String {
  static String fromColor(Color color) {
    return color.toString();
  }

  Color toColor() {
    return Color(int.parse(this, radix: 16));
  }
}
