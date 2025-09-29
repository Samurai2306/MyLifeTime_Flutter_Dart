// lib/domain/usecases/notes/get_notes.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/usecases/usecase.dart';
import 'package:mylifetime/domain/entities/note_entity.dart';
import 'package:mylifetime/domain/repositories/note_repository.dart';

class GetNotes implements UseCase<List<NoteEntity>, NoParams> {
  final NoteRepository repository;

  GetNotes(this.repository);

  @override
  Future<Either<Failure, List<NoteEntity>>> call(NoParams params) {
    return repository.getNotes();
  }
}