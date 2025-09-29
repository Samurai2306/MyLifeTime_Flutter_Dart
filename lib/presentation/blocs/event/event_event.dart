// presentation/blocs/event/event_event.dart
part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends EventEvent {
  final DateTime startDate;
  final DateTime endDate;

  const LoadEvents({required this.startDate, required this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}

class AddEventEvent extends EventEvent {
  final EventEntity event;

  const AddEventEvent({required this.event});

  @override
  List<Object> get props => [event];
}

class UpdateEventEvent extends EventEvent {
  final EventEntity event;

  const UpdateEventEvent({required this.event});

  @override
  List<Object> get props => [event];
}

class DeleteEventEvent extends EventEvent {
  final EventEntity event;

  const DeleteEventEvent({required this.event});

  @override
  List<Object> get props => [event];
}
class LoadEventById extends EventEvent {
  final int eventId;

  const LoadEventById(this.eventId);

  @override
  List<Object> get props => [eventId];
}

class EventOperationSuccess extends EventState {
  const EventOperationSuccess();
}