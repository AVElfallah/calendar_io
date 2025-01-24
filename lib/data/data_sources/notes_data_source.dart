import 'package:calendar_io/core/utils/id_generator_helper.dart';
import 'package:calendar_io/data/data_sources/storage_data_source.dart';
import 'package:calendar_io/data/models/event_note_model.dart';

class NotesDataSource {
  final dataSource = StorageDataSource.i.notesStorage;

  Future<List<EventNoteModel>?> getNotes() async {
    try {
      List listOfData = dataSource.getValues().toList();
      final backList = listOfData.map((v) {
            print('is data');
            print(v);
            print('is data');
            return EventNoteModel.fromJson(v);
          }).toList() ??
          [];
      return backList;
    } catch (e) {
      rethrow;
    }
  }

  Future<EventNoteModel> addNote(EventNoteModel model) async {
    final id = IdGeneratorHelper.generateAUniqID();
    final modelWithId = model.copyWith(eventID: id);
    try {
      await dataSource.writeIfNull(id, modelWithId.toJson());
      await dataSource.save();
      return modelWithId;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllNotes() async {
    try {
      await dataSource.erase();
      await dataSource.save();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteANoteByID(String? id) async {
    try {
      await dataSource.remove(id!);
      await dataSource.save();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateANote(EventNoteModel? model) async {
    try {
      await dataSource.write(model!.eventID!, model.toJson());
      await dataSource.save();
    } catch (e) {
      rethrow;
    }
  }
}
