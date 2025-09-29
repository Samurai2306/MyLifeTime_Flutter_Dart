// lib/presentation/blocs/pomodoro/pomodoro_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pomodoro_event.dart';
part 'pomodoro_state.dart';

class PomodoroBloc extends Bloc<PomodoroEvent, PomodoroState> {
  PomodoroBloc() : super(PomodoroState.initial()) {
    on<StartTimer>(_onStartTimer);
    on<PauseTimer>(_onPauseTimer);
    on<ResetTimer>(_onResetTimer);
    on<TimerTick>(_onTimerTick);
    on<ChangeSessionType>(_onChangeSessionType);
  }

  void _onStartTimer(StartTimer event, Emitter<PomodoroState> emit) {
    if (state.status == PomodoroStatus.running) return;
    
    emit(state.copyWith(status: PomodoroStatus.running));
    
    // Запускаем таймер
    _startTimer(emit);
  }

  void _onPauseTimer(PauseTimer event, Emitter<PomodoroState> emit) {
    if (state.status != PomodoroStatus.running) return;
    
    emit(state.copyWith(status: PomodoroStatus.paused));
  }

  void _onResetTimer(ResetTimer event, Emitter<PomodoroState> emit) {
    emit(PomodoroState.initial());
  }

  void _onTimerTick(TimerTick event, Emitter<PomodoroState> emit) {
    if (state.status != PomodoroStatus.running) return;

    final newSeconds = state.secondsRemaining - 1;
    
    if (newSeconds <= 0) {
      // Таймер завершен
      _completeSession(emit);
    } else {
      emit(state.copyWith(secondsRemaining: newSeconds));
    }
  }

  void _onChangeSessionType(ChangeSessionType event, Emitter<PomodoroState> emit) {
    final newState = state.copyWith(
      sessionType: event.sessionType,
      secondsRemaining: _getDurationForSessionType(event.sessionType),
    );
    emit(newState);
  }

  void _startTimer(Emitter<PomodoroState> emit) {
    // Здесь будет реализация таймера
    // Пока что эмулируем тики через event
  }

  void _completeSession(Emitter<PomodoroState> emit) {
    final completedSessions = state.completedSessions + 1;
    final isBreak = state.sessionType == PomodoroSessionType.breakSession;
    final nextSessionType = isBreak 
        ? PomodoroSessionType.work 
        : (completedSessions % 4 == 0 
            ? PomodoroSessionType.longBreak 
            : PomodoroSessionType.breakSession);
    
    emit(state.copyWith(
      sessionType: nextSessionType,
      secondsRemaining: _getDurationForSessionType(nextSessionType),
      completedSessions: completedSessions,
      status: PomodoroStatus.idle,
    ));
  }

  int _getDurationForSessionType(PomodoroSessionType sessionType) {
    switch (sessionType) {
      case PomodoroSessionType.work:
        return 25 * 60; // 25 минут
      case PomodoroSessionType.breakSession:
        return 5 * 60; // 5 минут
      case PomodoroSessionType.longBreak:
        return 15 * 60; // 15 минут
    }
  }
}