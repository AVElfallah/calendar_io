import 'package:calendar_io/app/extensions/string_extensions.dart';
import 'package:calendar_io/app/locator.dart';
import 'package:calendar_io/core/usecases/usecase.dart';
import 'package:calendar_io/domain/entities/event_category.dart';
import 'package:calendar_io/domain/usecases/event_category_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/colors_helper.dart';
import '../../domain/entities/event_note.dart';
import '../../domain/usecases/event_note_use_case.dart';

final eventNoteController =
    ChangeNotifierProvider((ref) => EventNoteController());

class EventNoteController extends ChangeNotifier {
  EventNoteController() {
    getCategories();
  }

// keys
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
// Text Controllers
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventNoteController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventStartTimeController =
      TextEditingController();
  final TextEditingController eventEndTimeController = TextEditingController();
  final TextEditingController eventCategoryNameController =
      TextEditingController();
//
// validations
String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }
  String? validateNote(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a note';
    }
    return null;
  }
  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }

    return null;
  }
  String? validateStartTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a start time';
    }
    return null;
  }
  String? validateEndTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an end time';
    }

    return null;
  }


// locators
// Category locators
  final GetEventCategoriesUseCase getEventCategoriesUseCase =
      locator.get<GetEventCategoriesUseCase>();
  final AddEventCategoryUseCase createEventCategoryUseCase =
      locator.get<AddEventCategoryUseCase>();

  final UpdateEventCategoryUseCase updateEventCategoryUseCase =
      locator.get<UpdateEventCategoryUseCase>();

  final DeleteEventCategoryUseCase deleteEventCategoryUseCase =
      locator.get<DeleteEventCategoryUseCase>();
  // Note locators
  final AddEventNoteUseCase createEventNoteUseCase =
      locator.get<AddEventNoteUseCase>();
  final UpdateEventNoteUseCase updateEventNoteUseCase =
      locator.get<UpdateEventNoteUseCase>();
  final DeleteEventNoteUseCase deleteEventNoteUseCase =
      locator.get<DeleteEventNoteUseCase>();
  final DeleteAllEventNotesUseCase deleteAllEventNotesUseCase =
      locator.get<DeleteAllEventNotesUseCase>();

//
//  Variables
  bool isReminder = false;
  bool isAddCategory = false;
  List<EventCategory> _categories = [];
  final List<EventCategory> _selectedCategories = [];
  List<EventCategory> get categories => _categories;
  List<EventCategory> get selectedCategories => _selectedCategories;
  int get selectedCategory => _categories.length;
  Color categoryColor = ColorsHelper.appMainBlue;
//
// Use Cases

  Future<void> getCategories() async {
    getEventCategoriesUseCase(NoParms()).then(
      (result) => result.fold(
        (l) => l,
        (r) {
          _categories = r;
          notifyListeners();
        },
      ),
    );
  }

  Future<void> addCategory() async {
    if (eventCategoryNameController.text.isEmpty) return;
    var eventCategory = EventCategory(
      name: eventCategoryNameController.text,
      color: categoryColor,
    );
    createEventCategoryUseCase(
      eventCategory,
    ).then(
      (result) => result.fold(
        (l) => l,
        (r) {
          _categories.add(r);
          eventCategoryNameController.text = '';
          isAddCategory = false;

          notifyListeners();
        },
      ),
    );
  }

  Future<void> addEventNote( {Function? onSuccess ,Function? onFail}) async {
if(!formKey.currentState!.validate())return;
    var eventNote = EventNote(
      name: eventNameController.text,
      note: eventNoteController.text,
      date: eventDateController.text.toDate(),
      start: eventStartTimeController.text.toTime(),
      end: eventEndTimeController.text.toTime(),
      categories: selectedCategories,
    );
    createEventNoteUseCase(
      eventNote,
    ).then(
      (result) => result.fold(
        (l) {
          onFail?.call();
        },
        (r) {
onSuccess?.call();
        },
      ),
    );
  }

//

// Functions
  void setDate(DateTime date) {
    eventDateController.text = DateTimeConverter.fromDate(date)!;
    notifyListeners();
  }

  void setStartTime(TimeOfDay time) {
    eventStartTimeController.text = DateTimeConverter.fromTime(time)!;
    notifyListeners();
  }

  void setEndTime(TimeOfDay time) {
    eventEndTimeController.text = DateTimeConverter.fromTime(time)!;
    notifyListeners();
  }

  void addSelectedCategory(EventCategory category) {
    _selectedCategories.add(category);
    notifyListeners();
  }

  void removeSelectedCategory(EventCategory category) {
    _selectedCategories.remove(category);
    notifyListeners();
  }

  void toggleReminder(bool value) {
    isReminder = value;
    notifyListeners();
  }

  void changeCategoryColor(Color color) {
    categoryColor = Color(color.value);
    notifyListeners();
  }

  void toggleAddCategoryVisibility() {
    isAddCategory = !isAddCategory;
    notifyListeners();
  }

//

// Disposing
  @override
  void dispose() {
    eventNameController.dispose();
    eventNoteController.dispose();
    eventDateController.dispose();
    eventStartTimeController.dispose();
    eventEndTimeController.dispose();
    super.dispose();
  }
}
