import 'package:calendar_io/app/locator.dart';
import 'package:calendar_io/core/usecases/usecase.dart';
import 'package:calendar_io/domain/entities/event_category.dart';
import 'package:calendar_io/domain/usecases/event_category_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/colors_helper.dart';

final eventNoteController =
    ChangeNotifierProvider((ref) => EventNoteController());

class EventNoteController extends ChangeNotifier {
  EventNoteController() {
    getCategories();
  }
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
// locators
  final GetEventCategoriesUseCase getEventCategoriesUseCase =
      locator.get<GetEventCategoriesUseCase>();
  final AddEventCategoryUseCase createEventNoteUseCase =
      locator.get<AddEventCategoryUseCase>();

  final UpdateEventCategoryUseCase updateEventNoteUseCase =
      locator.get<UpdateEventCategoryUseCase>();

  final DeleteEventCategoryUseCase deleteEventNoteUseCase =
      locator.get<DeleteEventCategoryUseCase>();

//
//  Variables
  bool isReminder = false;
  bool isAddCategory = false;
  List<EventCategory> _categories = [];
  List<EventCategory> _selectedCategories = [];
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
    createEventNoteUseCase(
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

//

// Functions
  void addSelectedCategory(EventCategory category) {
    _selectedCategories.add(category);
    print(_selectedCategories);
    notifyListeners();
  }

  void removeSelectedCategory(EventCategory category) {
    _selectedCategories.remove(category);
    print(_selectedCategories);
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
