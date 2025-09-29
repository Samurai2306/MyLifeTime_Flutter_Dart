// lib/core/errors/failures.dart
abstract class Failure {
  final String message;
  final StackTrace? stackTrace;

  const Failure(this.message, [this.stackTrace]);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);
}

class CacheFailure extends Failure {
  const CacheFailure(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);
}

class BackupFailure extends Failure {
  const BackupFailure(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);
}