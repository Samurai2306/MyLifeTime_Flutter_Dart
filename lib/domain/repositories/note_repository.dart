// lib/domain/repositories/note_repository.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/domain/entities/note_entity.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<NoteEntity>>> getNotes();
  Future<Either<Failure, int>> addNote(NoteEntity note);
  Future<Either<Failure, void>> updateNote(NoteEntity note);
  Future<Either<Failure, void>> deleteNote(int id);
}