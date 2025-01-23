import 'package:fpdart/fpdart.dart';

import 'package:calendar_io/core/errors/failures.dart';
import 'package:calendar_io/data/data_sources/notes_data_source.dart';
import 'package:calendar_io/data/models/event_note_model.dart';
import 'package:calendar_io/domain/entities/event_note.dart';
import 'package:calendar_io/domain/repositories/event_note_repository.dart';

class EventNoteRepositoryImpl extends EventNoteRepository {
  final NotesDataSource dataSource;

  EventNoteRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failures, bool>> createNote(EventNote note) async {
    try {
      final EventNoteModel model = EventNoteModel.fromEventNote(note);
      await dataSource.addNote(model);
      return right(true);
    } on StorageFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failures, bool>> deleteANoteByID(String? id) async {
    try {
      await dataSource.deleteANoteByID(id);
      return right(true);
    } on StorageFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failures, bool>> deleteAllNotes() async {
    try {
      await dataSource.deleteAllNotes();
      return right(true);
    } on StorageFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failures, List<EventNote>>> getNotes() async {
    try {
      final notes = await dataSource.getNotes();
      return right(notes.map((e) => e.toEventNote()).toList());
    } on StorageFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failures, bool>> updateANote(EventNote note) async {
    try {
      final EventNoteModel model = EventNoteModel.fromEventNote(note);
      await dataSource.updateANote(model);
      return right(true);
    } on StorageFailure catch (e) {
      return left(e);
    }
  }
}
