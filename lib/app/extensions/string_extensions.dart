import 'package:flutter/material.dart';

extension DateTimeConverter on String {
  static String? fromDate(DateTime? d) {
    // date format dd/mm/yyyy => 11/9/2001 like my BD
    return '${d!.day}/${d.month}/${d.year}';
  }

  DateTime? toDate() {
    //
    final ls = split('/');
    final year = int.parse(ls[2]);
    final month = int.parse(ls[1]);
    final day = int.parse(ls[0]);
    return DateTime(year, month, day);
  }

  static String? fromTime(DateTime? time) {
    // time format HH:MM day||night
    var dayNightString = (time!.hour >= 12) ? 'AM' : 'PM';
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;

    return '$hour:${time.minute} $dayNightString';
  }

  DateTime? toTime() {
    final ls = split(':');
    final hour = int.parse(ls[0]);
    final minute = int.parse(ls[1]);
    return DateTime(
        0001, //year
        1, // month
        1, // day
        hour,
        minute);
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
