// lib/presentation/blocs/note/note_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylifetime/domain/entities/note_entity.dart';
import 'package:mylifetime/domain/usecases/notes/get_notes.dart';
import 'package:mylifetime/domain/usecases/notes/add_note.dart';
import 'package:mylifetime/domain/usecases/notes/update_note.dart';
import 'package:mylifetime/domain/usecases/notes/delete_note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotes getNotes;
  final AddNote addNote;
  final UpdateNote updateNote;
  final DeleteNote deleteNote;

  NoteBloc({
    required this.getNotes,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(NoteInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<ToggleNotePin>(_onToggleNotePin);
  }

  Future<void> _onLoadNotes(
    LoadNotes event,
    Emitter<NoteState> emit,
  ) async {
    emit(NoteLoading());
    
    final result = await getNotes(NoParams());

    result.fold(
      (failure) => emit(NoteError(failure.message)),
      (notes) => emit(NotesLoaded(notes: notes)),
    );
  }

  Future<void> _onAddNote(
    AddNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    final result = await addNote(AddNoteParams(note: event.note));
    
    result.fold(
      (failure) => emit(NoteError(failure.message)),
      (noteId) => emit(NoteOperationSuccess('Note added successfully')),
    );
  }

  Future<void> _onUpdateNote(
    UpdateNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    final result = await updateNote(UpdateNoteParams(note: event.note));
    
    result.fold(
      (failure) => emit(NoteError(failure.message)),
      (_) => emit(NoteOperationSuccess('Note updated successfully')),
    );
  }

  Future<void> _onDeleteNote(
    DeleteNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    final result = await deleteNote(DeleteNoteParams(noteId: event.noteId));
    
    result.fold(
      (failure) => emit(NoteError(failure.message)),
      (_) => emit(NoteOperationSuccess('Note deleted successfully')),
    );
  }

  Future<void> _onToggleNotePin(
    ToggleNotePin event,
    Emitter<NoteState> emit,
  ) async {
    if (state is NotesLoaded) {
      final currentState = state as NotesLoaded;
      final note = currentState.notes.firstWhere(
        (n) => n.id == event.noteId,
        orElse: () => throw Exception('Note not found'),
      );

      final updatedNote = note.copyWith(isPinned: !note.isPinned);
      
      final result = await updateNote(UpdateNoteParams(note: updatedNote));
      
      result.fold(
        (failure) => emit(NoteError(failure.message)),
        (_) => emit(NoteOperationSuccess('Note pin status updated')),
      );
    }
  }
}