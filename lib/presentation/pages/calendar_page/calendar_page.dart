import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:calendar_io/presentation/controllers/calendar_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/colors_helper.dart';
import '../../controllers/event_note_controller.dart';
import 'layouts/add_note_bottom_sheet.dart';
import 'layouts/calendar_component_layout.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  @override
  void initState() {
    super.initState();
    final controller = ref.read(calendarPageController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // load the event notes on the page fully loaded for the first time
      controller.loadEventNotes();
    });
  }

  final ValueNotifier<DateTime> currentDay = ValueNotifier(DateTime.now());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey futureBuilderKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    
    final wController=ref.watch(calendarPageController);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Skeletonizer(
                enabled: wController.isLoading,
                child: CalendarComponentLayout(
                  notes: wController.notes,
                )
            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: StatefulBuilder(builder: (context, changeState) {
        return FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white, size: 30),
          onPressed: () {
            // Show a bottom sheet using the current scaffold state
            showModalBottomSheet(
              context: context,
              
              // The content of the bottom sheet is wrapped in a ProviderScope
            builder:   (ctx) => ProviderScope(
                // Override the eventNoteController provider
                overrides: [eventNoteController],
                // The actual widget to display in the bottom sheet
                child: const AddNoteBottomSheet(),
              ),
              // Set the elevation of the bottom sheet
              elevation: 50,
              // Allow the bottom sheet to be draggable
              enableDrag: true,
            ).then((value) {
              // Refresh the future builder to reload the event notes
              ref.read(calendarPageController).loadEventNotes();
           
            });

            
        

        // Change the state to indicate that the bottom sheet is open
           
          },
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
