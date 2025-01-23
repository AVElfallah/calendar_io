import 'package:get_storage/get_storage.dart';

class StorageDataSource {
  late final GetStorage notesStorage;

  late final GetStorage categoriesStorage;

  StorageDataSource._() {
    notesStorage = GetStorage('notes');
    categoriesStorage = GetStorage('categories');
  }
  static final StorageDataSource _i = StorageDataSource._();

  static StorageDataSource get i => _i;
}
