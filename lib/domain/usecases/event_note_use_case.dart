import 'package:calendar_io/core/errors/failures.dart';
import 'package:calendar_io/core/usecases/usecase.dart';
import 'package:calendar_io/domain/entities/event_note.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/event_note_repository.dart';

class GetEventsNotesUseCase extends UseCase<List<EventNote>, NoParms> {
  final EventNoteRepository repository;

  GetEventsNotesUseCase(this.repository);

  @override
  Future<Either<Failures, List<EventNote>>> call(NoParms prams) async {
    final result = await repository.getNotes();
    return result.fold((l) => left(l), (r) => right(r));
  }
}

class AddEventNoteUseCase extends UseCase<bool, EventNote> {
  final EventNoteRepository repository;

  AddEventNoteUseCase(this.repository);

  @override
  Future<Either<Failures, bool>> call(EventNote prams) async {
    final result = await repository.createNote(prams);
    return result.fold((l) => left(l), (r) => right(true));
  }
}

class UpdateEventNoteUseCase extends UseCase<bool, EventNote> {
  final EventNoteRepository repository;

  UpdateEventNoteUseCase(this.repository);

  @override
  Future<Either<Failures, bool>> call(EventNote prams) async {
    final result = await repository.updateANote(prams);
    return result.fold((l) => left(l), (r) => right(true));
  }
}

class DeleteEventNoteUseCase extends UseCase<bool, String> {
  final EventNoteRepository repository;

  DeleteEventNoteUseCase(this.repository);

  @override
  Future<Either<Failures, bool>> call(String prams) async {
    final result = await repository.deleteANoteByID(prams);
    return result.fold((l) => left(l), (r) => right(true));
  }
}

class DeleteAllEventNotesUseCase extends UseCase<bool, NoParms> {
  final EventNoteRepository repository;

  DeleteAllEventNotesUseCase(this.repository);

  @override
  Future<Either<Failures, bool>> call(NoParms prams) async {
    final result = await repository.deleteAllNotes();
    return result.fold((l) => left(l), (r) => right(true));
  }
}
