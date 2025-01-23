import 'package:calendar_io/data/data_sources/storage_data_source.dart';

import '../models/event_category_model.dart';

class CategoriesDataSource {
  final dataSource = StorageDataSource.i.categoriesStorage;

  Future<List<EventCategoryModel>> getCategories() async {
    try {
      var listOfData = dataSource.getValues<List<Map<String, dynamic>>>();
      return listOfData
          .map<EventCategoryModel>(EventCategoryModel.fromJson)
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCategory(EventCategoryModel? category) async {
    try {
      await dataSource.writeIfNull(category!.id!, category.toJson());
      await dataSource.save();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCategoryByID(String? id) async {
    try {
      if (dataSource.hasData(id!)) {
        await dataSource.remove(id);
        await dataSource.save();
      } else {
        throw 'Element is not found';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllCategories() async {
    try {
      await dataSource.erase();
      await dataSource.save();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCategory(EventCategoryModel? category) async {
    try {
      await dataSource.write(category!.id!, category.toJson());
      await dataSource.save();
    } catch (e) {
      rethrow;
    }
  }
}
