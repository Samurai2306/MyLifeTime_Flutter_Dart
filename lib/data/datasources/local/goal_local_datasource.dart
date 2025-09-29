// lib/data/datasources/local/goal_local_datasource.dart
import 'package:isar/isar.dart';
import 'package:mylifetime/data/models/goal_model.dart';
import 'package:mylifetime/core/errors/exceptions.dart';

class GoalLocalDataSource {
  final Isar isar;

  GoalLocalDataSource(this.isar);

  Future<int> insertGoal(GoalModel goal) async {
    try {
      return await isar.writeTxn(() async {
        return await isar.goalModels.put(goal);
      });
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to insert goal: $e', stackTrace);
    }
  }

  Future<List<GoalModel>> getAllGoals() async {
    try {
      return await isar.goalModels
          .where()
          .filter()
          .isArchivedEqualTo(false)
          .findAll();
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to get goals: $e', stackTrace);
    }
  }

  Future<GoalModel?> getGoalById(int id) async {
    try {
      return await isar.goalModels.get(id);
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to get goal by id: $e', stackTrace);
    }
  }

  Future<void> updateGoal(GoalModel goal) async {
    try {
      await isar.writeTxn(() async {
        await isar.goalModels.put(goal);
      });
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to update goal: $e', stackTrace);
    }
  }

  Future<void> deleteGoal(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.goalModels.delete(id);
      });
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to delete goal: $e', stackTrace);
    }
  }
}