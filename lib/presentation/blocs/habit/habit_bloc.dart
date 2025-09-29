// lib/presentation/blocs/habit/habit_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylifetime/domain/entities/habit_entity.dart';
import 'package:mylifetime/domain/usecases/habits/get_habits.dart';
import 'package:mylifetime/domain/usecases/habits/get_habit_by_id.dart';
import 'package:mylifetime/domain/usecases/habits/add_habit.dart';
import 'package:mylifetime/domain/usecases/habits/update_habit.dart';
import 'package:mylifetime/domain/usecases/habits/delete_habit.dart';
import 'package:mylifetime/domain/usecases/habits/mark_habit_completed.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final GetHabits getHabits;
  final GetHabitById getHabitById;
  final AddHabit addHabit;
  final UpdateHabit updateHabit;
  final DeleteHabit deleteHabit;
  final MarkHabitCompleted markHabitCompleted;

  HabitBloc({
    required this.getHabits,
    required this.getHabitById,
    required this.addHabit,
    required this.updateHabit,
    required this.deleteHabit,
    required this.markHabitCompleted,
  }) : super(HabitInitial()) {
    on<LoadHabits>(_onLoadHabits);
    on<LoadHabitById>(_onLoadHabitById);
    on<AddHabitEvent>(_onAddHabit);
    on<UpdateHabitEvent>(_onUpdateHabit);
    on<DeleteHabitEvent>(_onDeleteHabit);
    on<MarkHabitCompletedEvent>(_onMarkHabitCompleted);
  }

  Future<void> _onLoadHabits(
    LoadHabits event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    
    final result = await getHabits(NoParams());

    result.fold(
      (failure) => emit(HabitError(failure.message)),
      (habits) => emit(HabitsLoaded(habits: habits)),
    );
  }

  Future<void> _onLoadHabitById(
    LoadHabitById event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    
    final result = await getHabitById(GetHabitByIdParams(habitId: event.habitId));

    result.fold(
      (failure) => emit(HabitError(failure.message)),
      (habit) => emit(HabitLoaded(habit: habit)),
    );
  }

  Future<void> _onAddHabit(
    AddHabitEvent event,
    Emitter<HabitState> emit,
  ) async {
    final result = await addHabit(AddHabitParams(habit: event.habit));
    
    result.fold(
      (failure) => emit(HabitError(failure.message)),
      (habitId) => emit(HabitOperationSuccess('Habit added successfully')),
    );
  }

  Future<void> _onUpdateHabit(
    UpdateHabitEvent event,
    Emitter<HabitState> emit,
  ) async {
    final result = await updateHabit(UpdateHabitParams(habit: event.habit));
    
    result.fold(
      (failure) => emit(HabitError(failure.message)),
      (_) => emit(HabitOperationSuccess('Habit updated successfully')),
    );
  }

  Future<void> _onDeleteHabit(
    DeleteHabitEvent event,
    Emitter<HabitState> emit,
  ) async {
    final result = await deleteHabit(DeleteHabitParams(habitId: event.habitId));
    
    result.fold(
      (failure) => emit(HabitError(failure.message)),
      (_) => emit(HabitOperationSuccess('Habit deleted successfully')),
    );
  }

  Future<void> _onMarkHabitCompleted(
    MarkHabitCompletedEvent event,
    Emitter<HabitState> emit,
  ) async {
    final result = await markHabitCompleted(
      MarkHabitCompletedParams(
        habitId: event.habitId,
        date: event.date,
        completed: event.completed,
      ),
    );
    
    result.fold(
      (failure) => emit(HabitError(failure.message)),
      (_) => emit(HabitOperationSuccess('Habit status updated')),
    );
  }
}