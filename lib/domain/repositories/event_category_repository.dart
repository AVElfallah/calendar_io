import 'package:calendar_io/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/event_category.dart';

abstract class EventCategoryRepository {
  Future<Either<Failures, List<EventCategory>>> getCategories();
  Future<Either<Failures, List<EventCategory>>> getCategoriesByListOfIDs(
      List<String?>? id);
  Future<Either<Failures, EventCategory>> addCategory(EventCategory? cat);
  Future<Either<Failures, bool>> deleteCategory(String? id);
  Future<Either<Failures, bool>> updateCategory(EventCategory? cat);
  Future<Either<Failures, bool>> deleteAllCategories();
}
