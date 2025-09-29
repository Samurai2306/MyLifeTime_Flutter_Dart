// lib/data/repositories/event_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/errors/error_handler.dart';
import 'package:mylifetime/data/datasources/local/event_local_datasource.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/domain/repositories/event_repository.dart';
import 'package:mylifetime/data/models/event_model.dart';
import 'package:mylifetime/data/mappers/event_mapper.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource localDataSource;

  EventRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<EventEntity>>> getEventsForDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return handleException(() async {
      final models = await localDataSource.getEventsForRange(start, end);
      return models.map(EventMapper.toEntity).toList();
    });
  }

  @override
  Future<Either<Failure, EventEntity>> getEventById(int id) async {
    return handleException(() async {
      final model = await localDataSource.getEventById(id);
      if (model == null) {
        throw DatabaseException('Event with id $id not found');
      }
      return EventMapper.toEntity(model);
    });
  }

  @override
  Future<Either<Failure, int>> addEvent(EventEntity event) async {
    return handleException(() async {
      final model = EventMapper.toModel(event);
      return await localDataSource.insertEvent(model);
    });
  }

  @override
  Future<Either<Failure, void>> updateEvent(EventEntity event) async {
    return handleException(() async {
      final model = EventMapper.toModel(event);
      await localDataSource.updateEvent(model);
    });
  }

  @override
  Future<Either<Failure, void>> deleteEvent(int id) async {
    return handleException(() async {
      await localDataSource.deleteEvent(id);
    });
  }

  @override
  Future<Either<Failure, List<EventEntity>>> searchEvents(String query) async {
    return handleException(() async {
      final models = await localDataSource.searchEvents(query);
      return models.map(EventMapper.toEntity).toList();
    });
  }
}