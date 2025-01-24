import 'package:calendar_io/core/errors/failures.dart';
import 'package:calendar_io/data/data_sources/categories_data_source.dart';
import 'package:calendar_io/domain/entities/event_category.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/event_category_repository.dart';
import '../models/event_category_model.dart';

class EventCategoryRepositoryImpl implements EventCategoryRepository {
  final CategoriesDataSource dataSource;

  EventCategoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failures, EventCategory>> addCategory(
      EventCategory? cat) async {
    try {
      final EventCategoryModel model =
          EventCategoryModel.fromEventCategory(cat!);
      final backEventAfterAdd = await dataSource.addCategory(model);
      return right(backEventAfterAdd.toEventCategory());
    } on StorageFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failures, bool>> deleteAllCategories() async {
    try {
      await dataSource.deleteAllCategories();
      return right(true);
    } on StorageFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failures, bool>> deleteCategory(String? id) async {
    try {
      await dataSource.deleteCategoryByID(id);
      return right(true);
    } on StorageFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failures, List<EventCategory>>> getCategories() async {
    try {
      final categories = await dataSource.getCategories();
      return right(categories?.map((e) => e.toEventCategory()).toList() ?? []);
    } on StorageFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failures, bool>> updateCategory(EventCategory? cat) async {
    try {
      final EventCategoryModel model =
          EventCategoryModel.fromEventCategory(cat!);
      await dataSource.updateCategory(model);
      return right(true);
    } on StorageFailure catch (e) {
      return left(e);
    }
  }
}
