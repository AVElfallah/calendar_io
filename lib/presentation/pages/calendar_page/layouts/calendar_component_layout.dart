import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../app/extensions/string_extensions.dart';
import '../../../../core/utils/colors_helper.dart';
import '../../../../domain/entities/event_note.dart';
import '../../../widgets/event_card_widget.dart';

class CalendarComponentLayout extends StatelessWidget {
  const CalendarComponentLayout({super.key, required this.notes});
  final Map<String, List<EventNote>> notes;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<DateTime> currentDay = ValueNotifier(DateTime.now());

    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: currentDay,
          builder: (context, value, child) {
            return TableCalendar(
              daysOfWeekHeight: 60,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextFormatter: (date, locale) =>
                    DateFormat.MMMM().format(date),
                titleTextStyle: Theme.of(context).textTheme.bodyMedium!,
                leftChevronIcon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: ColorsHelper.appGray,
                    ),
                    color: ColorsHelper.appMainWhite,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.arrow_back_ios),
                ),
                rightChevronIcon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: ColorsHelper.appGray,
                    ),
                    color: ColorsHelper.appMainWhite,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
                leftChevronMargin: const EdgeInsets.only(left: 1),
                rightChevronMargin: const EdgeInsets.only(right: 1),
              ),
              calendarStyle: CalendarStyle(
                canMarkersOverflow: true,
                markersMaxCount: 3,
                markerMargin: const EdgeInsets.only(
                  top: 1,
                  left: 2,
                ),
                markerDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: ColorsHelper.appFullOpGreen,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                weekendTextStyle: Theme.of(context).textTheme.bodyMedium!,
                todayDecoration: BoxDecoration(
                  color: ColorsHelper.appMainBlue,
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                defaultDecoration: BoxDecoration(
                  color: ColorsHelper.appMainWhite,
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2222, 3, 14),
              focusedDay: value,
              currentDay: value,
              rowHeight: 54,
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                currentDay.value = selectedDay;
              },
              loadEventsForDisabledDays: true,
              eventLoader: (c) {
                return notes[DateTimeConverter.fromDate(c)] ?? [];
              },
            );
          },
        ),
        const Spacer(),
        ValueListenableBuilder(
          valueListenable: currentDay,
          builder: (context, value, child) => Expanded(
            flex: 10,
            child: ListView(
              children: [
                for (var item in notes[DateTimeConverter.fromDate(value)] ?? [])
                  EventCardWidget(note: item),
              ],
            ),
          ),
        )
      ],
    );
  }
}
