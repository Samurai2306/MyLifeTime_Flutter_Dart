// lib/core/errors/exceptions.dart
abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);
}

class DatabaseException extends AppException {
  const DatabaseException(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);
}

class CacheException extends AppException {
  const CacheException(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);
}

class NetworkException extends AppException {
  const NetworkException(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);
}

class BackupException extends AppException {
  const BackupException(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);
}