// lib/presentation/blocs/pomodoro/pomodoro_event.dart
part of 'pomodoro_bloc.dart';

abstract class PomodoroEvent extends Equatable {
  const PomodoroEvent();

  @override
  List<Object> get props => [];
}

class StartTimer extends PomodoroEvent {}

class PauseTimer extends PomodoroEvent {}

class ResetTimer extends PomodoroEvent {}

class TimerTick extends PomodoroEvent {}

class ChangeSessionType extends PomodoroEvent {
  final PomodoroSessionType sessionType;

  const ChangeSessionType(this.sessionType);

  @override
  List<Object> get props => [sessionType];
}