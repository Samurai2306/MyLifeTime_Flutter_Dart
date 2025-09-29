// lib/presentation/blocs/habit/habit_event.dart
part of 'habit_bloc.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class LoadHabits extends HabitEvent {}

class LoadHabitById extends HabitEvent {
  final int habitId;

  const LoadHabitById(this.habitId);

  @override
  List<Object> get props => [habitId];
}

class AddHabitEvent extends HabitEvent {
  final HabitEntity habit;

  const AddHabitEvent({required this.habit});

  @override
  List<Object> get props => [habit];
}

class UpdateHabitEvent extends HabitEvent {
  final HabitEntity habit;

  const UpdateHabitEvent({required this.habit});

  @override
  List<Object> get props => [habit];
}

class DeleteHabitEvent extends HabitEvent {
  final int habitId;

  const DeleteHabitEvent({required this.habitId});

  @override
  List<Object> get props => [habitId];
}

class MarkHabitCompletedEvent extends HabitEvent {
  final int habitId;
  final DateTime date;
  final bool completed;

  const MarkHabitCompletedEvent({
    required this.habitId,
    required this.date,
    required this.completed,
  });

  @override
  List<Object> get props => [habitId, date, completed];
}