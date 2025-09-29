// data/repositories/event_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/data/datasources/local/event_local_datasource.dart';
import 'package:mylifetime/data/models/event_model.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource localDataSource;

  EventRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents(DateTime start, DateTime end) async {
    try {
      final events = await localDataSource.getEventsForRange(start, end);
      return Right(events.map((model) => _mapModelToEntity(model)).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> addEvent(EventEntity event) async {
    try {
      final model = _mapEntityToModel(event);
      final id = await localDataSource.insertEvent(model);
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  // Остальные методы (updateEvent, deleteEvent) аналогично

  EventModel _mapEntityToModel(EventEntity entity) {
    return EventModel()
      ..id = entity.id
      ..title = entity.title
      ..description = entity.description
      ..startDate = entity.startDate
      ..endDate = entity.endDate
      ..isAllDay = entity.isAllDay
      ..colorValue = entity.colorValue
      ..categoryId = entity.categoryId
      ..reminders = entity.reminders
      ..recurrenceRule = entity.recurrenceRule != null
          ? RecurrenceRuleModel()
            ..frequency = entity.recurrenceRule!.frequency
            ..interval = entity.recurrenceRule!.interval
            ..count = entity.recurrenceRule!.count
            ..until = entity.recurrenceRule!.until
            ..byWeekday = entity.recurrenceRule!.byWeekday
            ..byMonthDay = entity.recurrenceRule!.byMonthDay
            ..byYearDay = entity.recurrenceRule!.byYearDay
            ..byWeek = entity.recurrenceRule!.byWeek
            ..byMonth = entity.recurrenceRule!.byMonth
            ..bySetPos = entity.recurrenceRule!.bySetPos
            ..exceptionDates = entity.recurrenceRule!.exceptionDates
          : null
      ..tags = entity.tags;
  }

  EventEntity _mapModelToEntity(EventModel model) {
    return EventEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      startDate: model.startDate,
      endDate: model.endDate,
      isAllDay: model.isAllDay,
      colorValue: model.colorValue,
      categoryId: model.categoryId,
      reminders: model.reminders,
      recurrenceRule: model.recurrenceRule != null
          ? RecurrenceRuleEntity(
              frequency: model.recurrenceRule!.frequency,
              interval: model.recurrenceRule!.interval,
              count: model.recurrenceRule!.count,
              until: model.recurrenceRule!.until,
              byWeekday: model.recurrenceRule!.byWeekday,
              byMonthDay: model.recurrenceRule!.byMonthDay,
              byYearDay: model.recurrenceRule!.byYearDay,
              byWeek: model.recurrenceRule!.byWeek,
              byMonth: model.recurrenceRule!.byMonth,
              bySetPos: model.recurrenceRule!.bySetPos,
              exceptionDates: model.recurrenceRule!.exceptionDates,
            )
          : null,
      tags: model.tags,
    );
  }
}