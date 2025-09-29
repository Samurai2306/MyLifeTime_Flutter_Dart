// lib/domain/usecases/events/get_event_by_id.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/usecases/usecase.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/domain/repositories/event_repository.dart';

class GetEventByIdParams {
  final int eventId;

  GetEventByIdParams({required this.eventId});
}

class GetEventById implements UseCase<EventEntity, GetEventByIdParams> {
  final EventRepository repository;

  GetEventById(this.repository);

  @override
  Future<Either<Failure, EventEntity>> call(GetEventByIdParams params) {
    return repository.getEventById(params.eventId);
  }
}