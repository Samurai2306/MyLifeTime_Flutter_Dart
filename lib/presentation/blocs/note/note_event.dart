// lib/presentation/blocs/note/note_event.dart
part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final NoteEntity note;

  const AddNoteEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class UpdateNoteEvent extends NoteEvent {
  final NoteEntity note;

  const UpdateNoteEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends NoteEvent {
  final int noteId;

  const DeleteNoteEvent({required this.noteId});

  @override
  List<Object> get props => [noteId];
}

class ToggleNotePin extends NoteEvent {
  final int noteId;

  const ToggleNotePin({required this.noteId});

  @override
  List<Object> get props => [noteId];
}