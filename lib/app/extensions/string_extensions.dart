import 'package:flutter/material.dart';

extension DateTimeConverter on String {
  static String? fromDate(DateTime? d) {
    // date format dd/mm/yyyy => 11/9/2001 like my BD
    return '${'${d?.day}'.padLeft(2, '0')}/${'${d?.month}'.padLeft(2, '0')}/${d?.year}';
  }

  /// Converts a string in "dd/mm/yyyy" format to a DateTime object.
  /// Returns the corresponding DateTime or null if the string is invalid.

  DateTime? toDate() {
    //
    List<String?> ls = split('/');
    final year = int.parse(ls[2]??'2001');
    final month = int.parse(ls[1]?? '11');
    final day = int.parse(ls[0]??'9');
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
