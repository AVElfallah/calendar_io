import 'package:calendar_io/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class UseCase<Type, Prams> {
  Future<Either<Failures, Type>> call(Prams prams);
}

class NoParms {}
