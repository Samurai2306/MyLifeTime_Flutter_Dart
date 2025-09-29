// lib/domain/usecases/goals/get_goals.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/usecases/usecase.dart';
import 'package:mylifetime/domain/entities/goal_entity.dart';
import 'package:mylifetime/domain/repositories/goal_repository.dart';

class GetGoals implements UseCase<List<GoalEntity>, NoParams> {
  final GoalRepository repository;

  GetGoals(this.repository);

  @override
  Future<Either<Failure, List<GoalEntity>>> call(NoParams params) {
    return repository.getGoals();
  }
}