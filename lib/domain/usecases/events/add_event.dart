// lib/domain/usecases/events/add_event.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/usecases/usecase.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/domain/repositories/event_repository.dart';

class AddEventParams {
  final EventEntity event;

  AddEventParams({required this.event});
}

class AddEvent implements UseCase<int, AddEventParams> {
  final EventRepository repository;

  AddEvent(this.repository);

  @override
  Future<Either<Failure, int>> call(AddEventParams params) {
    return repository.addEvent(params.event);
  }
}