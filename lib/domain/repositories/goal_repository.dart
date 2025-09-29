// lib/domain/repositories/goal_repository.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/domain/entities/goal_entity.dart';

abstract class GoalRepository {
  Future<Either<Failure, List<GoalEntity>>> getGoals();
  Future<Either<Failure, int>> addGoal(GoalEntity goal);
  Future<Either<Failure, void>> updateGoal(GoalEntity goal);
  Future<Either<Failure, void>> deleteGoal(int id);
}