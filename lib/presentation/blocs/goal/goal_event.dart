// lib/presentation/blocs/goal/goal_event.dart
part of 'goal_bloc.dart';

abstract class GoalEvent extends Equatable {
  const GoalEvent();

  @override
  List<Object> get props => [];
}

class LoadGoals extends GoalEvent {}

class AddGoalEvent extends GoalEvent {
  final GoalEntity goal;

  const AddGoalEvent({required this.goal});

  @override
  List<Object> get props => [goal];
}

class UpdateGoalEvent extends GoalEvent {
  final GoalEntity goal;

  const UpdateGoalEvent({required this.goal});

  @override
  List<Object> get props => [goal];
}

class DeleteGoalEvent extends GoalEvent {
  final int goalId;

  const DeleteGoalEvent({required this.goalId});

  @override
  List<Object> get props => [goalId];
}

class ToggleGoalMilestone extends GoalEvent {
  final int goalId;
  final String milestoneTitle;
  final bool completed;

  const ToggleGoalMilestone({
    required this.goalId,
    required this.milestoneTitle,
    required this.completed,
  });

  @override
  List<Object> get props => [goalId, milestoneTitle, completed];
}