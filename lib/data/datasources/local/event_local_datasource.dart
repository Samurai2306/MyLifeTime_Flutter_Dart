// data/datasources/local/event_local_datasource.dart
import 'package:isar/isar.dart';

class EventLocalDataSource {
  final Isar isar;

  EventLocalDataSource(this.isar);

  Future<int> insertEvent(EventModel event) async {
    return await isar.writeTxn(() async {
      return await isar.eventModels.put(event);
    });
  }

  Future<List<EventModel>> getEventsForDay(DateTime day) async {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = DateTime(day.year, day.month, day.day, 23, 59, 59);

    return await isar.eventModels
        .where()
        .filter()
        .startDateBetween(startOfDay, endOfDay)
        .findAll();
  }

  Future<List<EventModel>> getEventsForRange(
      DateTime start, DateTime end) async {
    return await isar.eventModels
        .where()
        .filter()
        .startDateBetween(start, end)
        .findAll();
  }
}