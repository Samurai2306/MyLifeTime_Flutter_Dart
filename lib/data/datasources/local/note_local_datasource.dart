// lib/data/datasources/local/note_local_datasource.dart
import 'package:isar/isar.dart';
import 'package:mylifetime/data/models/note_model.dart';
import 'package:mylifetime/core/errors/exceptions.dart';

class NoteLocalDataSource {
  final Isar isar;

  NoteLocalDataSource(this.isar);

  Future<int> insertNote(NoteModel note) async {
    try {
      return await isar.writeTxn(() async {
        return await isar.noteModels.put(note);
      });
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to insert note: $e', stackTrace);
    }
  }

  Future<List<NoteModel>> getAllNotes() async {
    try {
      return await isar.noteModels
          .where()
          .filter()
          .isArchivedEqualTo(false)
          .sortByIsPinnedDesc()
          .thenByUpdatedAtDesc()
          .findAll();
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to get notes: $e', stackTrace);
    }
  }

  Future<NoteModel?> getNoteById(int id) async {
    try {
      return await isar.noteModels.get(id);
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to get note by id: $e', stackTrace);
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      await isar.writeTxn(() async {
        await isar.noteModels.put(note);
      });
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to update note: $e', stackTrace);
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.noteModels.delete(id);
      });
    } catch (e, stackTrace) {
      throw DatabaseException('Failed to delete note: $e', stackTrace);
    }
  }
}