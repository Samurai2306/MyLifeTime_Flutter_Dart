// lib/core/errors/error_handler.dart
import 'package:dartz/dartz.dart';

Either<Failure, T> handleException<T>(T Function() computation) {
  try {
    final result = computation();
    return Right(result);
  } on AppException catch (e, stackTrace) {
    return Left(_mapExceptionToFailure(e, stackTrace));
  } catch (e, stackTrace) {
    return Left(DatabaseFailure('Unexpected error: $e', stackTrace));
  }
}

Failure _mapExceptionToFailure(AppException exception, StackTrace stackTrace) {
  if (exception is DatabaseException) {
    return DatabaseFailure(exception.message, stackTrace);
  } else if (exception is CacheException) {
    return CacheFailure(exception.message, stackTrace);
  } else if (exception is NetworkException) {
    return NetworkFailure(exception.message, stackTrace);
  } else if (exception is BackupException) {
    return BackupFailure(exception.message, stackTrace);
  } else {
    return DatabaseFailure(exception.message, stackTrace);
  }
}