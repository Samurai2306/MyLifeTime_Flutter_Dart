// lib/data/datasources/local/event_local_datasource.dart
import 'package:isar/isar.dart';
import 'package:mylifetime/data/models/event_model.dart';
import 'package:mylifetime/core/errors/exceptions.dart';

class EventLocalDataSource {
  final Isar isar;

  EventLocalDataSource(this.isar);

  Future<int> insertEvent(EventModel event) async {
    try {
      return await isar.writeTxn(() async {
        return await isar.eventModels.put(event);
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to insert event: $e',
        stackTrace,
      );
    }
  }

  Future<List<EventModel>> getEventsForDay(DateTime day) async {
    try {
      final startOfDay = DateUtils.startOfDay(day);
      final endOfDay = DateUtils.endOfDay(day);

      return await isar.eventModels
          .where()
          .filter()
          .startDateBetween(startOfDay, endOfDay)
          .findAll();
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to get events for day: $e',
        stackTrace,
      );
    }
  }

  Future<List<EventModel>> getEventsForRange(
    DateTime start, 
    DateTime end,
  ) async {
    try {
      return await isar.eventModels
          .where()
          .filter()
          .startDateBetween(start, end)
          .findAll();
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to get events for range: $e',
        stackTrace,
      );
    }
  }

  Future<EventModel?> getEventById(int id) async {
    try {
      return await isar.eventModels.get(id);
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to get event by id: $e',
        stackTrace,
      );
    }
  }

  Future<void> updateEvent(EventModel event) async {
    try {
      await isar.writeTxn(() async {
        await isar.eventModels.put(event);
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to update event: $e',
        stackTrace,
      );
    }
  }

  Future<void> deleteEvent(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.eventModels.delete(id);
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to delete event: $e',
        stackTrace,
      );
    }
  }

  Future<List<EventModel>> searchEvents(String query) async {
    try {
      // Поиск по заголовку и описанию
      final results = await isar.eventModels
          .where()
          .filter()
          .titleContains(query, caseSensitive: false)
          .or()
          .descriptionContains(query, caseSensitive: false)
          .findAll();

      return results;
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to search events: $e',
        stackTrace,
      );
    }
  }
}