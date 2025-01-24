import 'package:calendar_io/data/data_sources/notes_data_source.dart';
import 'package:calendar_io/domain/repositories/event_category_repository.dart';
import 'package:get_it/get_it.dart';

import '../data/data_sources/categories_data_source.dart';
import '../data/repositories/event_category_repository.dart';
import '../data/repositories/event_note_repository.dart';
import '../domain/repositories/event_note_repository.dart';
import '../domain/usecases/event_category_use_case.dart';
import '../domain/usecases/event_note_use_case.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Repositories and Data Sources Locators [START]
  // register the repositories and data sources
  locator.registerLazySingleton<NotesDataSource>(() => NotesDataSource());
  locator.registerLazySingleton<CategoriesDataSource>(
      () => CategoriesDataSource());

  locator.registerLazySingleton<EventNoteRepository>(
      () => EventNoteRepositoryImpl(locator()));

  locator.registerLazySingleton<EventCategoryRepository>(
      () => EventCategoryRepositoryImpl(locator()));

  // Repositories and Data Sources Locators [END]

  // Event Notes Locators [START]
  locator.registerLazySingleton(() => GetEventsNotesUseCase(locator()));
  locator.registerLazySingleton(() => AddEventNoteUseCase(locator()));
  locator.registerLazySingleton(() => UpdateEventNoteUseCase(locator()));
  locator.registerLazySingleton(() => DeleteEventNoteUseCase(locator()));
  locator.registerLazySingleton(() => DeleteAllEventNotesUseCase(locator()));
  // Event Notes Locators [END]

  // Event Categories Locators [START]
  locator.registerLazySingleton(() => GetEventCategoriesUseCase(locator()));
  locator.registerLazySingleton(() => AddEventCategoryUseCase(locator()));
  locator.registerLazySingleton(() => UpdateEventCategoryUseCase(locator()));
  locator.registerLazySingleton(() => DeleteEventCategoryUseCase(locator()));
  locator
      .registerLazySingleton(() => DeleteAllEventCategoriesUseCase(locator()));

  locator.registerLazySingleton<GetEventCategoriesByIDsUseCase>(
      () => GetEventCategoriesByIDsUseCase(locator()));
  // Event Categories Locators [END]
}
