// lib/domain/usecases/habits/mark_habit_completed.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/usecases/usecase.dart';
import 'package:mylifetime/domain/repositories/habit_repository.dart';

class MarkHabitCompletedParams {
  final int habitId;
  final DateTime date;
  final bool completed;

  MarkHabitCompletedParams({
    required this.habitId,
    required this.date,
    required this.completed,
  });
}

class MarkHabitCompleted implements UseCase<void, MarkHabitCompletedParams> {
  final HabitRepository repository;

  MarkHabitCompleted(this.repository);

  @override
  Future<Either<Failure, void>> call(MarkHabitCompletedParams params) {
    return repository.markHabitCompleted(
      params.habitId,
      params.date,
      params.completed,
    );
  }
}