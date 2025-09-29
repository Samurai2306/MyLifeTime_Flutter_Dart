// domain/repositories/event_repository.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventEntity>>> getEvents(DateTime start, DateTime end);
  Future<Either<Failure, int>> addEvent(EventEntity event);
  Future<Either<Failure, void>> updateEvent(EventEntity event);
  Future<Either<Failure, void>> deleteEvent(EventEntity event);
  Future<Either<Failure, EventEntity>> getEventById(int id);
}