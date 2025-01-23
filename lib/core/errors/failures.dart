abstract class Failures {
  final String? message;
  const Failures(this.message);
}

class FirebaseFailure extends Failures {
  const FirebaseFailure(super.message);
}

class StorageFailure extends Failures {
  const StorageFailure(super.message);
}
