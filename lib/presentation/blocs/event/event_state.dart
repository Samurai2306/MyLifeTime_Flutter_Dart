// presentation/blocs/event/event_state.dart
part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventsLoaded extends EventState {
  final List<EventEntity> events;

  const EventsLoaded({required this.events});

  @override
  List<Object> get props => [events];
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);

  @override
  List<Object> get props => [message];
}
class EventLoaded extends EventState {
  final EventEntity event;

  const EventLoaded({required this.event});

  @override
  List<Object> get props => [event];
}