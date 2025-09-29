// lib/data/repositories/goal_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/errors/error_handler.dart';
import 'package:mylifetime/data/datasources/local/goal_local_datasource.dart';
import 'package:mylifetime/domain/entities/goal_entity.dart';
import 'package:mylifetime/domain/repositories/goal_repository.dart';
import 'package:mylifetime/data/models/goal_model.dart';
import 'package:mylifetime/data/mappers/goal_mapper.dart';

class GoalRepositoryImpl implements GoalRepository {
  final GoalLocalDataSource localDataSource;

  GoalRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<GoalEntity>>> getGoals() async {
    return handleException(() async {
      final models = await localDataSource.getAllGoals();
      return models.map(GoalMapper.toEntity).toList();
    });
  }

  @override
  Future<Either<Failure, int>> addGoal(GoalEntity goal) async {
    return handleException(() async {
      final model = GoalMapper.toModel(goal);
      return await localDataSource.insertGoal(model);
    });
  }

  @override
  Future<Either<Failure, void>> updateGoal(GoalEntity goal) async {
    return handleException(() async {
      final model = GoalMapper.toModel(goal);
      await localDataSource.updateGoal(model);
    });
  }

  @override
  Future<Either<Failure, void>> deleteGoal(int id) async {
    return handleException(() async {
      await localDataSource.deleteGoal(id);
    });
  }
}