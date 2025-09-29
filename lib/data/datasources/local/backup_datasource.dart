// lib/data/datasources/local/backup_datasource.dart
import 'dart:convert';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mylifetime/data/models/event_model.dart';
import 'package:mylifetime/data/models/category_model.dart';
import 'package:mylifetime/data/models/habit_model.dart';
import 'package:mylifetime/data/models/goal_model.dart';
import 'package:mylifetime/data/models/note_model.dart';
import 'package:mylifetime/core/errors/exceptions.dart';

class BackupLocalDataSource {
  final Isar isar;

  BackupLocalDataSource(this.isar);

  Future<String> createBackup() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final backupFile = File('${directory.path}/backup_$timestamp.json');

      // Собираем все данные из базы
      final backupData = {
        'events': await isar.eventModels.where().findAll(),
        'categories': await isar.calendarCategoryModels.where().findAll(),
        'habits': await isar.habitModels.where().findAll(),
        'goals': await isar.goalModels.where().findAll(),
        'notes': await isar.noteModels.where().findAll(),
        'metadata': {
          'version': '1.0.0',
          'createdAt': DateTime.now().toIso8601String(),
          'totalItems': await _getTotalItemsCount(),
        },
      };

      // Конвертируем в JSON и сохраняем
      final jsonString = jsonEncode(backupData);
      await backupFile.writeAsString(jsonString);

      return backupFile.path;
    } catch (e, stackTrace) {
      throw BackupException(
        'Failed to create backup: $e',
        stackTrace,
      );
    }
  }

  Future<void> restoreBackup(String filePath) async {
    try {
      final backupFile = File(filePath);
      if (!await backupFile.exists()) {
        throw BackupException('Backup file not found');
      }

      final jsonString = await backupFile.readAsString();
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;

      // Восстанавливаем данные в транзакции
      await isar.writeTxn(() async {
        // Очищаем существующие данные
        await isar.eventModels.clear();
        await isar.calendarCategoryModels.clear();
        await isar.habitModels.clear();
        await isar.goalModels.clear();
        await isar.noteModels.clear();

        // Восстанавливаем данные
        if (backupData['events'] != null) {
          final events = (backupData['events'] as List)
              .map((e) => EventModel.fromJson(e))
              .toList();
          await isar.eventModels.putAll(events);
        }

        if (backupData['categories'] != null) {
          final categories = (backupData['categories'] as List)
              .map((e) => CalendarCategoryModel.fromJson(e))
              .toList();
          await isar.calendarCategoryModels.putAll(categories);
        }

        // Аналогично для других моделей...
      });
    } catch (e, stackTrace) {
      throw BackupException(
        'Failed to restore backup: $e',
        stackTrace,
      );
    }
  }

  Future<String> exportData(String format) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      
      if (format == 'csv') {
        return await _exportToCsv(directory, timestamp);
      } else {
        return await _exportToJson(directory, timestamp);
      }
    } catch (e, stackTrace) {
      throw BackupException(
        'Failed to export data: $e',
        stackTrace,
      );
    }
  }

  Future<String> _exportToCsv(Directory directory, int timestamp) async {
    final csvFile = File('${directory.path}/export_$timestamp.csv');
    final csvBuffer = StringBuffer();

    // Заголовки CSV
    csvBuffer.writeln('Type,Title,Description,Start Date,End Date,Status');

    // Экспорт событий
    final events = await isar.eventModels.where().findAll();
    for (final event in events) {
      csvBuffer.writeln('Event,${event.title},"${event.description ?? ""}",'
          '${event.startDate.toIso8601String()},${event.endDate.toIso8601String()},'
          '${event.isAllDay ? "All Day" : "Timed"}');
    }

    // Экспорт привычек
    final habits = await isar.habitModels.where().findAll();
    for (final habit in habits) {
      csvBuffer.writeln('Habit,${habit.title},"${habit.description ?? ""}",'
          '${habit.startDate.toIso8601String()},,'
          '${habit.isCompletedToday ? "Completed" : "Pending"}');
    }

    await csvFile.writeAsString(csvBuffer.toString());
    return csvFile.path;
  }

  Future<String> _exportToJson(Directory directory, int timestamp) async {
    final jsonFile = File('${directory.path}/export_$timestamp.json');
    
    final exportData = {
      'events': await isar.eventModels.where().findAll(),
      'habits': await isar.habitModels.where().findAll(),
      'goals': await isar.goalModels.where().findAll(),
      'exportedAt': DateTime.now().toIso8601String(),
    };

    await jsonFile.writeAsString(jsonEncode(exportData));
    return jsonFile.path;
  }

  Future<int> _getTotalItemsCount() async {
    final eventsCount = await isar.eventModels.count();
    final categoriesCount = await isar.calendarCategoryModels.count();
    final habitsCount = await isar.habitModels.count();
    final goalsCount = await isar.goalModels.count();
    final notesCount = await isar.noteModels.count();
    
    return eventsCount + categoriesCount + habitsCount + goalsCount + notesCount;
  }
}