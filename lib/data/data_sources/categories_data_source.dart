import 'package:calendar_io/data/data_sources/storage_data_source.dart';

import '../../core/utils/id_generator_helper.dart';
import '../models/event_category_model.dart';

class CategoriesDataSource {
  final dataSource = StorageDataSource.i.categoriesStorage;

  Future<List<EventCategoryModel>?> getCategories() async {
    try {
      var listOfData = dataSource.getValues();
      return listOfData
              ?.map<EventCategoryModel>((v) => EventCategoryModel.fromJson(v))
              .toList() ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventCategoryModel>?> getCategoriesByListOfIDs(
      List<String?>? ids) async {
    try {
      var listOfData = dataSource.getValues();
      return listOfData
              ?.map<EventCategoryModel>((v) => EventCategoryModel.fromJson(v))
              .where((element) => ids!.contains(element.categoryID))
              .toList() ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  Future<EventCategoryModel> addCategory(EventCategoryModel? category) async {
    final id = IdGeneratorHelper.generateAUniqID();
    final modelWithId = category?.copyWith(
      categoryID: id,
    );
    try {
      await dataSource.writeIfNull(modelWithId!.id!, modelWithId.toJson());
      await dataSource.save();
      return modelWithId;
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
