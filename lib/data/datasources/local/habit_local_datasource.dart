// lib/data/datasources/local/habit_local_datasource.dart
import 'package:isar/isar.dart';
import 'package:mylifetime/data/models/habit_model.dart';
import 'package:mylifetime/core/errors/exceptions.dart';

class HabitLocalDataSource {
  final Isar isar;

  HabitLocalDataSource(this.isar);

  Future<int> insertHabit(HabitModel habit) async {
    try {
      return await isar.writeTxn(() async {
        return await isar.habitModels.put(habit);
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to insert habit: $e',
        stackTrace,
      );
    }
  }

  Future<List<HabitModel>> getAllHabits() async {
    try {
      return await isar.habitModels
          .where()
          .filter()
          .isArchivedEqualTo(false)
          .findAll();
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to get habits: $e',
        stackTrace,
      );
    }
  }

  Future<HabitModel?> getHabitById(int id) async {
    try {
      return await isar.habitModels.get(id);
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to get habit by id: $e',
        stackTrace,
      );
    }
  }

  Future<void> updateHabit(HabitModel habit) async {
    try {
      await isar.writeTxn(() async {
        await isar.habitModels.put(habit);
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to update habit: $e',
        stackTrace,
      );
    }
  }

  Future<void> deleteHabit(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.habitModels.delete(id);
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to delete habit: $e',
        stackTrace,
      );
    }
  }

  Future<void> markHabitCompleted(int habitId, DateTime date, bool completed) async {
    try {
      await isar.writeTxn(() async {
        final habit = await isar.habitModels.get(habitId);
        if (habit != null) {
          if (completed) {
            if (!habit.completedDates.any((d) => DateUtils.isSameDay(d, date))) {
              habit.completedDates.add(date);
            }
          } else {
            habit.completedDates.removeWhere((d) => DateUtils.isSameDay(d, date));
          }
          await isar.habitModels.put(habit);
        }
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to mark habit completed: $e',
        stackTrace,
      );
    }
  }
}