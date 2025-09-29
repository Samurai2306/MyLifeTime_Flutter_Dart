// domain/usecases/events/get_events.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/usecases/usecase.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/domain/repositories/event_repository.dart';

class GetEvents implements UseCase<List<EventEntity>, GetEventsParams> {
  final EventRepository repository;

  GetEvents(this.repository);

  @override
  Future<Either<Failure, List<EventEntity>>> call(GetEventsParams params) async {
    return await repository.getEvents(params.startDate, params.endDate);
  }
}

class GetEventsParams {
  final DateTime startDate;
  final DateTime endDate;

  GetEventsParams({required this.startDate, required this.endDate});
}