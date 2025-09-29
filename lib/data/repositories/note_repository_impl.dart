// lib/data/repositories/note_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/core/errors/error_handler.dart';
import 'package:mylifetime/data/datasources/local/note_local_datasource.dart';
import 'package:mylifetime/domain/entities/note_entity.dart';
import 'package:mylifetime/domain/repositories/note_repository.dart';
import 'package:mylifetime/data/models/note_model.dart';
import 'package:mylifetime/data/mappers/note_mapper.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<NoteEntity>>> getNotes() async {
    return handleException(() async {
      final models = await localDataSource.getAllNotes();
      return models.map(NoteMapper.toEntity).toList();
    });
  }

  @override
  Future<Either<Failure, int>> addNote(NoteEntity note) async {
    return handleException(() async {
      final model = NoteMapper.toModel(note);
      return await localDataSource.insertNote(model);
    });
  }

  @override
  Future<Either<Failure, void>> updateNote(NoteEntity note) async {
    return handleException(() async {
      final model = NoteMapper.toModel(note);
      await localDataSource.updateNote(model);
    });
  }

  @override
  Future<Either<Failure, void>> deleteNote(int id) async {
    return handleException(() async {
      await localDataSource.deleteNote(id);
    });
  }
}