// lib/presentation/blocs/goal/goal_state.dart
part of 'goal_bloc.dart';

abstract class GoalState extends Equatable {
  const GoalState();

  @override
  List<Object> get props => [];
}

class GoalInitial extends GoalState {}

class GoalLoading extends GoalState {}

class GoalsLoaded extends GoalState {
  final List<GoalEntity> goals;

  const GoalsLoaded({required this.goals});

  @override
  List<Object> get props => [goals];
}

class GoalOperationSuccess extends GoalState {
  final String message;

  const GoalOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class GoalError extends GoalState {
  final String message;

  const GoalError(this.message);

  @override
  List<Object> get props => [message];
}