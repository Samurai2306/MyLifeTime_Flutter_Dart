// lib/domain/usecases/habits/get_habits.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/usecases/usecase.dart';
import 'package:mylifetime/domain/entities/habit_entity.dart';
import 'package:mylifetime/domain/repositories/habit_repository.dart';

class GetHabits implements UseCase<List<HabitEntity>, NoParams> {
  final HabitRepository repository;

  GetHabits(this.repository);

  @override
  Future<Either<Failure, List<HabitEntity>>> call(NoParams params) {
    return repository.getHabits();
  }
}