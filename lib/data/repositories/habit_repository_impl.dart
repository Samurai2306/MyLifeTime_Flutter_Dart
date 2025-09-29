// lib/data/repositories/habit_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/errors/error_handler.dart';
import 'package:mylifetime/data/datasources/local/habit_local_datasource.dart';
import 'package:mylifetime/domain/entities/habit_entity.dart';
import 'package:mylifetime/domain/repositories/habit_repository.dart';
import 'package:mylifetime/data/models/habit_model.dart';
import 'package:mylifetime/data/mappers/habit_mapper.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource localDataSource;

  HabitRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<HabitEntity>>> getHabits() async {
    return handleException(() async {
      final models = await localDataSource.getAllHabits();
      return models.map(HabitMapper.toEntity).toList();
    });
  }

  @override
  Future<Either<Failure, HabitEntity>> getHabitById(int id) async {
    return handleException(() async {
      final model = await localDataSource.getHabitById(id);
      if (model == null) {
        throw DatabaseException('Habit with id $id not found');
      }
      return HabitMapper.toEntity(model);
    });
  }

  @override
  Future<Either<Failure, int>> addHabit(HabitEntity habit) async {
    return handleException(() async {
      final model = HabitMapper.toModel(habit);
      return await localDataSource.insertHabit(model);
    });
  }

  @override
  Future<Either<Failure, void>> updateHabit(HabitEntity habit) async {
    return handleException(() async {
      final model = HabitMapper.toModel(habit);
      await localDataSource.updateHabit(model);
    });
  }

  @override
  Future<Either<Failure, void>> deleteHabit(int id) async {
    return handleException(() async {
      await localDataSource.deleteHabit(id);
    });
  }

  @override
  Future<Either<Failure, void>> markHabitCompleted(
    int habitId,
    DateTime date,
    bool completed,
  ) async {
    return handleException(() async {
      await localDataSource.markHabitCompleted(habitId, date, completed);
    });
  }
}