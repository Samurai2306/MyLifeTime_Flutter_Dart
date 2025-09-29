// lib/presentation/blocs/pomodoro/pomodoro_state.dart
part of 'pomodoro_bloc.dart';

enum PomodoroStatus { idle, running, paused }
enum PomodoroSessionType { work, breakSession, longBreak }

class PomodoroState extends Equatable {
  final PomodoroStatus status;
  final PomodoroSessionType sessionType;
  final int secondsRemaining;
  final int completedSessions;

  const PomodoroState({
    required this.status,
    required this.sessionType,
    required this.secondsRemaining,
    required this.completedSessions,
  });

  factory PomodoroState.initial() {
    return const PomodoroState(
      status: PomodoroStatus.idle,
      sessionType: PomodoroSessionType.work,
      secondsRemaining: 25 * 60, // 25 минут
      completedSessions: 0,
    );
  }

  String get formattedTime {
    final minutes = (secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  double get progress {
    final totalDuration = _getTotalDurationForSessionType(sessionType);
    return 1 - (secondsRemaining / totalDuration);
  }

  PomodoroState copyWith({
    PomodoroStatus? status,
    PomodoroSessionType? sessionType,
    int? secondsRemaining,
    int? completedSessions,
  }) {
    return PomodoroState(
      status: status ?? this.status,
      sessionType: sessionType ?? this.sessionType,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      completedSessions: completedSessions ?? this.completedSessions,
    );
  }

  int _getTotalDurationForSessionType(PomodoroSessionType sessionType) {
    switch (sessionType) {
      case PomodoroSessionType.work:
        return 25 * 60;
      case PomodoroSessionType.breakSession:
        return 5 * 60;
      case PomodoroSessionType.longBreak:
        return 15 * 60;
    }
  }

  @override
  List<Object> get props => [
        status,
        sessionType,
        secondsRemaining,
        completedSessions,
      ];
}