import 'package:calendar_io/app/locator.dart';
import 'package:calendar_io/domain/usecases/event_note_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/usecases/usecase.dart';
import '../../domain/entities/event_note.dart';

final calendarPageController = ChangeNotifierProvider<CalendarPageController>(
    (ref) => CalendarPageController());

class CalendarPageController extends ChangeNotifier {
  CalendarPageController() {
    loadEventNotes();
    debugPrint('CalendarPageController created');
  }
  final getEventNotesLocator = locator<GetEventsNotesUseCase>();
  List<EventNote> _eventNotes = [];

  List<EventNote> get eventNotes => _eventNotes;

  int get eventNotesCount => _eventNotes.length;

  List<dynamic> setEventLoaders(DateTime day) {
    return _eventNotes.where((element) => element.date == day).toList();
  }

  void loadEventNotes({void Function()? onSuccess, void Function()? onFail}) {
    // call the use case to get the event notes
    // if the result is a success, assign the result to the _eventNotes
    // notify the listeners
    // if the result is a failure, call the onFail function
    debugPrint('loadEventNotes called');
    getEventNotesLocator(NoParms()).then((result) {
      result.fold((l) {
        debugPrint('loadEventNotes failed');
        onFail?.call();
      }, (r) {
        _eventNotes = r;
        notifyListeners();
        onSuccess?.call();
      });
    });
  }
}
