// presentation/blocs/event/event_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/domain/usecases/events/get_events.dart';
import 'package:mylifetime/domain/usecases/events/add_event.dart';
import 'package:mylifetime/domain/usecases/events/update_event.dart';
import 'package:mylifetime/domain/usecases/events/delete_event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEvents getEvents;
  final AddEvent addEvent;
  final UpdateEvent updateEvent;
  final DeleteEvent deleteEvent;

  EventBloc({
    required this.getEvents,
    required this.addEvent,
    required this.updateEvent,
    required this.deleteEvent,
  }) : super(EventInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<AddEvent>(_onAddEvent);
    on<UpdateEvent>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
  }

  Future<void> _onLoadEvents(
    LoadEvents event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());
    
    final result = await getEvents(GetEventsParams(
      startDate: event.startDate,
      endDate: event.endDate,
    ));

    result.fold(
      (failure) => emit(EventError(failure.toString())),
      (events) => emit(EventsLoaded(events: events)),
    );
  }

  Future<void> _onAddEvent(
    AddEventEvent event,
    Emitter<EventState> emit,
  ) async {
    if (state is EventsLoaded) {
      final currentState = state as EventsLoaded;
      
      final result = await addEvent(AddEventParams(event: event.event));
      
      result.fold(
        (failure) => emit(EventError(failure.toString())),
        (success) {
          final updatedEvents = List<EventEntity>.from(currentState.events)
            ..add(event.event);
          emit(EventsLoaded(events: updatedEvents));
        },
      );
    }
  }

  Future<void> _onUpdateEvent(
    UpdateEventEvent event,
    Emitter<EventState> emit,
  ) async {
    if (state is EventsLoaded) {
      final currentState = state as EventsLoaded;
      
      final result = await updateEvent(UpdateEventParams(event: event.event));
      
      result.fold(
        (failure) => emit(EventError(failure.toString())),
        (success) {
          final updatedEvents = currentState.events.map((e) => 
            e.id == event.event.id ? event.event : e
          ).toList();
          emit(EventsLoaded(events: updatedEvents));
        },
      );
    }
  }

  Future<void> _onDeleteEvent(
    DeleteEventEvent event,
    Emitter<EventState> emit,
  ) async {
    if (state is EventsLoaded) {
      final currentState = state as EventsLoaded;
      
      final result = await deleteEvent(DeleteEventParams(event: event.event));
      
      result.fold(
        (failure) => emit(EventError(failure.toString())),
        (success) {
          final updatedEvents = currentState.events
              .where((e) => e.id != event.event.id)
              .toList();
          emit(EventsLoaded(events: updatedEvents));
        },
      );
    }
  }
}