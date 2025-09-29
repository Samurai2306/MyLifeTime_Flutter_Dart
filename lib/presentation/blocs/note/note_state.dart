// lib/presentation/blocs/note/note_state.dart
part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NotesLoaded extends NoteState {
  final List<NoteEntity> notes;

  const NotesLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NoteOperationSuccess extends NoteState {
  final String message;

  const NoteOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class NoteError extends NoteState {
  final String message;

  const NoteError(this.message);

  @override
  List<Object> get props => [message];
}