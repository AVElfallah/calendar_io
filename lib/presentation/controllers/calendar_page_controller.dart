import 'package:calendar_io/app/locator.dart';
import 'package:calendar_io/domain/usecases/event_note_use_case.dart';
import 'package:flutter/material.dart';

import '../../core/usecases/usecase.dart';
import '../../domain/entities/event_note.dart';

class CalendarPageController extends ChangeNotifier {
  final getEventNotesLocator = locator<GetEventsNotesUseCase>();
  List<EventNote> _eventNotes = [];

  List<EventNote> get eventNotes => _eventNotes;

  int get eventNotesCount => _eventNotes.length;

  void loadEventNotes({void Function()? onSuccess, void Function()? onFail}) {
    // call the use case to get the event notes
    // if the result is a success, assign the result to the _eventNotes
    // notify the listeners
    // if the result is a failure, call the onFail function
    getEventNotesLocator(NoParms()).then((result) {
      result.fold((l) {
        onFail?.call();
      }, (r) {
        _eventNotes = r;
        notifyListeners();
        onSuccess?.call();
      });
    });
  }
}
