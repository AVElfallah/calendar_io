import 'package:intl/intl.dart';

class DateTimeHelper extends DateTime {
  DateTimeHelper(super.year,
      [super.month,
      super.day,
      super.hour,
      super.minute,
      super.second,
      super.millisecond,
      super.microsecond]);

  DateTimeHelper.now() : super.now();

  factory DateTimeHelper.fromDateTime(DateTime dateTime) {
    return DateTimeHelper(dateTime.year, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond);
  }

  static List<String> getWeekDays() {
    return [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];
  }

  String getDayName() {
    return DateFormat('EEEE').format(this);
  }

  String getDayNameShort() {
    return DateFormat('E').format(this);
  }

  String getDayNumber() {
    return DateFormat('d').format(this);
  }

  getMonthName() {
    return DateFormat('MMMM').format(this);
  }

  getYear() {
    return DateFormat('yyyy').format(this);
  }

  goToNextDay() {
    return add(const Duration(days: 1));
  }

  goToPreviousDay() {
    return subtract(const Duration(days: 1));
  }

  goToNextMonth() {
    return copyWith(month: month + 1);
  }

  goToPreviousMonth() {
    return copyWith(month: month - 1);
  }

  copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    bool? isUtc,
  }) {
    return DateTimeHelper(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
