// lib/presentation/blocs/goal/goal_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylifetime/domain/entities/goal_entity.dart';
import 'package:mylifetime/domain/usecases/goals/get_goals.dart';
import 'package:mylifetime/domain/usecases/goals/add_goal.dart';
import 'package:mylifetime/domain/usecases/goals/update_goal.dart';
import 'package:mylifetime/domain/usecases/goals/delete_goal.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GetGoals getGoals;
  final AddGoal addGoal;
  final UpdateGoal updateGoal;
  final DeleteGoal deleteGoal;

  GoalBloc({
    required this.getGoals,
    required this.addGoal,
    required this.updateGoal,
    required this.deleteGoal,
  }) : super(GoalInitial()) {
    on<LoadGoals>(_onLoadGoals);
    on<AddGoalEvent>(_onAddGoal);
    on<UpdateGoalEvent>(_onUpdateGoal);
    on<DeleteGoalEvent>(_onDeleteGoal);
    on<ToggleGoalMilestone>(_onToggleGoalMilestone);
  }

  Future<void> _onLoadGoals(
    LoadGoals event,
    Emitter<GoalState> emit,
  ) async {
    emit(GoalLoading());
    
    final result = await getGoals(NoParams());

    result.fold(
      (failure) => emit(GoalError(failure.message)),
      (goals) => emit(GoalsLoaded(goals: goals)),
    );
  }

  Future<void> _onAddGoal(
    AddGoalEvent event,
    Emitter<GoalState> emit,
  ) async {
    final result = await addGoal(AddGoalParams(goal: event.goal));
    
    result.fold(
      (failure) => emit(GoalError(failure.message)),
      (goalId) => emit(GoalOperationSuccess('Goal added successfully')),
    );
  }

  Future<void> _onUpdateGoal(
    UpdateGoalEvent event,
    Emitter<GoalState> emit,
  ) async {
    final result = await updateGoal(UpdateGoalParams(goal: event.goal));
    
    result.fold(
      (failure) => emit(GoalError(failure.message)),
      (_) => emit(GoalOperationSuccess('Goal updated successfully')),
    );
  }

  Future<void> _onDeleteGoal(
    DeleteGoalEvent event,
    Emitter<GoalState> emit,
  ) async {
    final result = await deleteGoal(DeleteGoalParams(goalId: event.goalId));
    
    result.fold(
      (failure) => emit(GoalError(failure.message)),
      (_) => emit(GoalOperationSuccess('Goal deleted successfully')),
    );
  }

  Future<void> _onToggleGoalMilestone(
    ToggleGoalMilestone event,
    Emitter<GoalState> emit,
  ) async {
    if (state is GoalsLoaded) {
      final currentState = state as GoalsLoaded;
      final goal = currentState.goals.firstWhere(
        (g) => g.id == event.goalId,
        orElse: () => throw Exception('Goal not found'),
      );

      // Update milestone status
      final updatedMilestones = goal.milestones.map((milestone) {
        if (milestone.title == event.milestoneTitle) {
          return milestone.copyWith(
            isCompleted: event.completed,
            completedDate: event.completed ? DateTime.now() : null,
          );
        }
        return milestone;
      }).toList();

      final updatedGoal = goal.copyWith(milestones: updatedMilestones);
      
      final result = await updateGoal(UpdateGoalParams(goal: updatedGoal));
      
      result.fold(
        (failure) => emit(GoalError(failure.message)),
        (_) => emit(GoalOperationSuccess('Milestone updated')),
      );
    }
  }
}