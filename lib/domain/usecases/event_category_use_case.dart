import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/event_category.dart';
import 'package:fpdart/fpdart.dart';
import '../repositories/event_category_repository.dart';

class GetEventCategoriesUseCase extends UseCase<List<EventCategory>, NoParms> {
  final EventCategoryRepository repository;

  GetEventCategoriesUseCase(this.repository);

  @override
  Future<Either<Failures, List<EventCategory>>> call(NoParms prams) async {
    final result = await repository.getCategories();
    return result.fold((l) => left(l), (r) => right(r));
  }
}

class AddEventCategoryUseCase extends UseCase<EventCategory, EventCategory> {
  final EventCategoryRepository repository;

  AddEventCategoryUseCase(this.repository);

  @override
  Future<Either<Failures, EventCategory>> call(EventCategory prams) async {
    final result = await repository.addCategory(prams);
    return result.fold((l) => left(l), (r) => right(r));
  }
}

class UpdateEventCategoryUseCase extends UseCase<bool, EventCategory> {
  final EventCategoryRepository repository;

  UpdateEventCategoryUseCase(this.repository);

  @override
  Future<Either<Failures, bool>> call(EventCategory prams) async {
    final result = await repository.updateCategory(prams);
    return result.fold((l) => left(l), (r) => right(r));
  }
}

class DeleteEventCategoryUseCase extends UseCase<bool, String> {
  final EventCategoryRepository repository;

  DeleteEventCategoryUseCase(this.repository);

  @override
  Future<Either<Failures, bool>> call(String prams) async {
    final result = await repository.deleteCategory(prams);
    return result.fold((l) => left(l), (r) => right(r));
  }
}

class DeleteAllEventCategoriesUseCase extends UseCase<bool, NoParms> {
  final EventCategoryRepository repository;

  DeleteAllEventCategoriesUseCase(this.repository);

  @override
  Future<Either<Failures, bool>> call(NoParms prams) async {
    final result = await repository.deleteAllCategories();
    return result.fold((l) => left(l), (r) => right(r));
  }
}
