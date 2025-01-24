import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:calendar_io/presentation/controllers/calendar_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/utils/colors_helper.dart';
import '../controllers/event_note_controller.dart';
import '../layouts/add_note_bottom_sheet.dart';
import '../widgets/event_card_widget.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(calendarPageController).loadEventNotes();
    });
  }

  final ValueNotifier<DateTime> currentDay = ValueNotifier(DateTime.now());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isBottomSheetOpen = false;
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(calendarPageController);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
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
                    ),
                    defaultDecoration: BoxDecoration(
                      color: ColorsHelper.appMainWhite,
                      borderRadius: BorderRadius.circular(10),
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
                  eventLoader: controller.setEventLoaders,
                );
              },
            ),
            const Spacer(),
            Expanded(
              flex: 10,
              child: ListView(
                children: const [
                  EventCardWidget(),
                  EventCardWidget(),
                  EventCardWidget(),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: StatefulBuilder(builder: (context, changeState) {
        return Visibility(
          visible: !isBottomSheetOpen,
          child: FloatingActionButton(
            backgroundColor: ColorsHelper.appMainBlue,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
            onPressed: () {
              _scaffoldKey.currentState
                  ?.showBottomSheet(
                    (ctx) => ProviderScope(
                        overrides: [eventNoteController],
                        child: const AddNoteBottomSheet()),
                    elevation: 50,
                    enableDrag: true,
                  )
                  .closed
                  .then((v) {
                changeState(() {
                  isBottomSheetOpen = false;
                });
              });

              changeState(
                () {
                  isBottomSheetOpen = true;
                },
              );
            },
          ),
        );
      }),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        notchSmoothness: NotchSmoothness.defaultEdge,
        notchMargin: 15,
        iconSize: 30,
        gapLocation: GapLocation.center,
        elevation: 40,
        activeColor: ColorsHelper.appMainBlue,
        inactiveColor: ColorsHelper.appGray,
        icons: const [
          Icons.calendar_today_rounded,
          Icons.person_outline,
        ],
        activeIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
