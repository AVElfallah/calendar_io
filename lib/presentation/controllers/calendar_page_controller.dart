import 'package:calendar_io/app/locator.dart';
import 'package:calendar_io/domain/usecases/event_note_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/extensions/string_extensions.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/entities/event_note.dart';

final calendarPageController = ChangeNotifierProvider<CalendarPageController>(
    (ref) => CalendarPageController());

class CalendarPageController extends ChangeNotifier {
  CalendarPageController() {
    debugPrint('CalendarPageController created');
  }

  Map<String, List<EventNote>> _notes = {};

  Map<String, List<EventNote>> get notes => _notes;

  bool _isLoading=false;
  bool get isLoading => _isLoading;


  // get the use case
  final getEventNotesLocator = locator<GetEventsNotesUseCase>();



 Future<void> loadEventNotes({void Function()? onSuccess, void Function()? onFail}) async {
  _isLoading=true;
  notifyListeners();
    // call the use case to get the event notes
    // if the result is a success, assign the result to the _eventNotes
    // notify the listeners
    // if the result is a failure, call the onFail function
    debugPrint('loadEventNotes called');
    final backNotes=await getEventNotesLocator(NoParms());
 
  backNotes.fold((l) {
        debugPrint('loadEventNotes failed');
        onFail?.call();
        _notes={};
      }, (listFromRight) {
        
        debugPrint('loadEventNotes success');
        onSuccess?.call();
        _notes = {};
         // Check if the snapshot has data and is not empty
            if (listFromRight.isNotEmpty) {
              // Iterate through each event note in the snapshot data
              for (var note in listFromRight) {
                // Convert the date of the note to a string key
                String dateKey =
                    DateTimeConverter.fromDate(note.date)!.toString();

                // Check if the date key already exists in the notes map
                if (_notes.containsKey(dateKey)) {
                  // If the date key exists, add the note to the existing list
                  _notes[dateKey]?.add(note);
                } else {
                  // If the date key does not exist, create a new list with the note
                  _notes[dateKey] = [note];
                }
              }
            }
       
      });

    _isLoading=false;
    notifyListeners();
    

  }
}
