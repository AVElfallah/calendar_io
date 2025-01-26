import 'package:calendar_io/app/locator.dart' as apploc;
import 'package:calendar_io/core/usecases/usecase.dart';
import 'package:calendar_io/data/data_sources/notes_data_source.dart';
import 'package:calendar_io/data/models/event_category_model.dart';
import 'package:calendar_io/data/models/event_note_model.dart';
import 'package:calendar_io/domain/entities/event_category.dart';
import 'package:calendar_io/domain/entities/event_note.dart';
import 'package:calendar_io/domain/usecases/event_category_use_case.dart';
import 'package:calendar_io/domain/usecases/event_note_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');

  setUp(() {
    channel.setMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return '/fake/path';
      }
      return null;
    });
  });

  tearDown(() {
    channel.setMethodCallHandler(null);
  });
  group('Test Notes DataSource', () {
    EventNote matcher = EventNote(
      name: 'Test Event Note',
      note: 'Test Event Note Description',
      date: DateTime.now(),
      start: TimeOfDay.now(),
      end: TimeOfDay.now(),
      categories: const [],
    );

    test('Test NotesDataSource init ', () async {
      final tNotesDataSource = NotesDataSource();
      expect(tNotesDataSource.dataSource, isA<GetStorage>(),
          reason: 'NotesDataSource failed to get storage');
    });
    test('Test NotesDataSource addEventNote ', () async {
      EventNoteModel dtoMatcher = EventNoteModel.fromEventNote(matcher);
      final tNotesDataSource = NotesDataSource();
      final result = await tNotesDataSource.addNote(dtoMatcher);
      expect(result.eventName, matcher.name,
          reason: 'NotesDataSource failed to add event note');
    });

    test('Test NotesDataSource getEventNotes ', () async {
      final tNotesDataSource = NotesDataSource();
      final result = await tNotesDataSource.getNotes();
      expect(result, isA<List<EventNote>>(),
          reason: 'NotesDataSource failed to get event notes');
    });

    test('Test NotesDataSource deleteEventNote ', () async {
      final tNotesDataSource = NotesDataSource();
      final getNote = await tNotesDataSource.getNotes();
      await tNotesDataSource.deleteANoteByID(getNote!.first.id!);
      final result = getNote
        ..removeWhere((element) => element.id == getNote.first.id);

      final getNoteAfterDelete = await tNotesDataSource.getNotes();
      expect(getNoteAfterDelete, result,
          reason: 'NotesDataSource failed to delete event note');
    });

    test('Test NotesDataSource updateEventNote  ', () async {
      EventNoteModel dtoMatcher = EventNoteModel.fromEventNote(matcher);
      final tNotesDataSource = NotesDataSource();
      EventNoteModel getNote = await tNotesDataSource.addNote(dtoMatcher);
      getNote = getNote.copyWith(eventName: 'Updated Event Note');
      await tNotesDataSource.updateANote(getNote);
      final getNoteAfterUpdate = (await tNotesDataSource.getNotes())?.first;
      expect(getNoteAfterUpdate?.id, getNote.id,
          reason: 'NotesDataSource failed to update event note');
    });
  });

  group('Test Event Note Use Cases', () {
    late GetIt locator;
    late AddEventNoteUseCase addEventNoteUseCase;
    late GetEventsNotesUseCase getEventsNotesUseCase;
    late DeleteEventNoteUseCase deleteEventNoteUseCase;
    late UpdateEventNoteUseCase updateEventNoteUseCase;
    late DeleteAllEventNotesUseCase deleteAllEventNotesUseCase;

    setUpAll(() async {
      apploc.setupLocator();
      locator = apploc.locator;
      addEventNoteUseCase = locator<AddEventNoteUseCase>();
      getEventsNotesUseCase = locator<GetEventsNotesUseCase>();
      deleteEventNoteUseCase = locator<DeleteEventNoteUseCase>();
      updateEventNoteUseCase = locator<UpdateEventNoteUseCase>();
      deleteAllEventNotesUseCase = locator<DeleteAllEventNotesUseCase>();
    });

    tearDownAll(() async {
      await locator.reset();
      
    });

    test('Test AddEventNoteUseCase', () async {
      EventNote matcher = EventNote(
        name: 'Test Event Note',
        note: 'Test Event Note Description',
        date: DateTime.now(),
        start: TimeOfDay.now(),
        end: TimeOfDay.now(),
        categories: const [],
      );
      Object? noteToTest;
      final result = await addEventNoteUseCase(
        matcher,
      );
      result.fold(
        (l) => prints(l),
        (r) => noteToTest = r,
      );

      expect(noteToTest, isA<EventNote>(),
          reason: 'AddEventNoteUseCase failed to add event note');
    });

    test('Test GetEventsNotesUseCase', () async {
      Object? noteToTest;
      final result = await getEventsNotesUseCase(NoParms());
      result.fold(
        (l) => prints(l),
        (r) => noteToTest = r,
      );
      expect(noteToTest, isA<List<EventNote>>(),
          reason: 'GetEventsNotesUseCase failed to get event notes');
    });

    test('Test DeleteEventNoteUseCase', () async {
      late EventNote noteToTest;
      EventNote matcher = EventNote(
        name: 'Test Event Note',
        note: 'Test Event Note Description',
        date: DateTime.now(),
        start: TimeOfDay.now(),
        end: TimeOfDay.now(),
        categories: const [],
      );
      final result = await addEventNoteUseCase(
        matcher,
      );
      result.fold(
        (l) => prints(l),
        (r) {
          prints(r);
          noteToTest = r;
        },
      );
      Object? deleteResult;
      final dResult = await deleteEventNoteUseCase(noteToTest.id!);
      dResult.fold(
        (l) => prints(l),
        (r) => deleteResult = r,
      );
      expect(deleteResult, isA<bool>(),
          reason: 'DeleteEventNoteUseCase failed to delete event note');
    });

    test('Test UpdateEventNoteUseCase', () async {
      EventNote matcher = EventNote(
        name: 'Test Event Note',
        note: 'Test Event Note Description',
        date: DateTime.now(),
        start: TimeOfDay.now(),
        end: TimeOfDay.now(),
        categories: const [],
      );
      Object? addResult;
      (await addEventNoteUseCase(
        matcher,
      ))
          .fold((l) => prints(l), (r) => addResult = r);
      Object? updateResult;
      final result = await updateEventNoteUseCase(
          (EventNoteModel.fromEventNote(addResult as EventNote))
            ..copyWith(eventName: 'updated name'));
      result.fold(
        (l) => prints(l),
        (r) => updateResult = r,
      );
      expect(updateResult, true,
          reason: 'UpdateEventNoteUseCase failed to update event note');
    });

    test('Test DeleteAllEventNotesUseCase', () async {
      final result = await deleteAllEventNotesUseCase(NoParms());
      Object? deleteResult;
      result.fold(
        (l) => prints(l),
        (r) => deleteResult = r,
      );
      expect(deleteResult, true,
          reason:
              'DeleteAllEventNotesUseCase failed to delete all event notes');
    });
  });

  group('EventCategoryUseCase', () {
    late GetIt locator;
    late AddEventCategoryUseCase addEventCategoryUseCase;
    late GetEventCategoriesUseCase getEventCategoriesUseCase;
    late DeleteEventCategoryUseCase deleteEventCategoryUseCase;
    late UpdateEventCategoryUseCase updateEventCategoryUseCase;
    late DeleteAllEventCategoriesUseCase deleteAllEventCategoriesUseCase;

    setUpAll(() async {
      apploc.setupLocator();
      locator = apploc.locator;
      addEventCategoryUseCase = locator<AddEventCategoryUseCase>();
      getEventCategoriesUseCase = locator<GetEventCategoriesUseCase>();
      deleteEventCategoryUseCase = locator<DeleteEventCategoryUseCase>();
      updateEventCategoryUseCase = locator<UpdateEventCategoryUseCase>();
      deleteAllEventCategoriesUseCase =
          locator<DeleteAllEventCategoriesUseCase>();
    });

    test('Test AddEventCategoryUseCase', () async {
      // Create a test event category
      EventCategory matcher = const EventCategory(
        name: 'Test Event Category',
        color: Colors.red,
      );
      Object? categoryToTest;
      // Add the test event category
      final result = await addEventCategoryUseCase(
        matcher,
      );
      result.fold(
        (l) => prints(l),
        (r) => categoryToTest = r,
      );
      // Check if the event category was added
      expect(categoryToTest, isA<EventCategory>(),
          reason: 'AddEventCategoryUseCase failed to add event category');
    });

    test('Test GetEventCategoriesUseCase', () async {
      Object? categoryToTest;
      // Get all event categories
      final result = await getEventCategoriesUseCase(NoParms());
      result.fold(
        (l) => prints(l),
        (r) => categoryToTest = r,
      );
      // Check if the event categories were retrieved
      expect(categoryToTest, isA<List<EventCategory>>(),
          reason: 'GetEventCategoriesUseCase failed to get event categories');
    });
      test('Test DeleteEventCategoryUseCase', () async {
    late EventCategory categoryToTest;
    EventCategory matcher = const EventCategory(
      name: 'Test Event Category',
      color: Colors.red,
    );
    // Add a test event category
    final result = await addEventCategoryUseCase(
      matcher,
    );
    result.fold(
      (l) => prints(l),
      (r) {
        prints(r);
        categoryToTest = r;
      },
    );
    Object? deleteResult;
    // Delete the test event category
    final dResult = await deleteEventCategoryUseCase(categoryToTest.id!);
    dResult.fold(
      (l) => prints(l),
      (r) => deleteResult = r,
    );
    // Check if the event category was deleted
    expect(deleteResult, isA<bool>(),
        reason: 'DeleteEventCategoryUseCase failed to delete event category');
  });
  test('Test UpdateEventCategoryUseCase', () async {
    EventCategory matcher = const EventCategory(
      name: 'Test Event Category',
      color: Colors.red,
    );
    Object? addResult;
    // Add a test event category
    (await addEventCategoryUseCase(
      matcher,
    ))
        .fold((l) => prints(l), (r) => addResult = r);
    Object? updateResult;
    // Update the test event category
    final result = await updateEventCategoryUseCase(
        (EventCategoryModel.fromEventCategory(addResult as EventCategory))
          ..copyWith(categoryName: 'updated name'));
    result.fold(
      (l) => prints(l),
      (r) => updateResult = r,
    );
    // Check if the event category was updated
    expect(updateResult, true,
        reason: 'UpdateEventCategoryUseCase failed to update event category');
  });
  test('Test DeleteAllEventCategoriesUseCase', () async {
    // Delete all event categories
    final result = await deleteAllEventCategoriesUseCase(NoParms());
    Object? deleteResult;
    result.fold(
      (l) => prints(l),
      (r) => deleteResult = r,
    );
    // Check if all event categories were deleted
    expect(deleteResult, true,
        reason:
            'DeleteAllEventCategoriesUseCase failed to delete all event categories');
  });
  });

  
}
