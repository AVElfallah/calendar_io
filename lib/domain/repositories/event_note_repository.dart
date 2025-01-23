import 'package:calendar_io/core/errors/failures.dart';
import 'package:calendar_io/domain/entities/event_note.dart';
import 'package:fpdart/fpdart.dart';

abstract class EventNoteRepository {
  Future<Either<Failures, List<EventNote>>> getNotes();
  Future<Either<Failures, bool>> deleteANoteByID(String? id);
  Future<Either<Failures, bool>> deleteAllNotes();
  Future<Either<Failures, bool>> updateANote(EventNote note);
  Future<Either<Failures, bool>> createNote(EventNote note);
}
