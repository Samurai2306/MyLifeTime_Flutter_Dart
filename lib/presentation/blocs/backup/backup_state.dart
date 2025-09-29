// lib/presentation/blocs/backup/backup_state.dart
part of 'backup_bloc.dart';

abstract class BackupState extends Equatable {
  const BackupState();

  @override
  List<Object> get props => [];
}

class BackupInitial extends BackupState {}

class BackupLoading extends BackupState {}

class BackupCreated extends BackupState {
  final String backupPath;

  const BackupCreated({required this.backupPath});

  @override
  List<Object> get props => [backupPath];
}

class BackupRestored extends BackupState {}

class DataExported extends BackupState {
  final String exportPath;

  const DataExported({required this.exportPath});

  @override
  List<Object> get props => [exportPath];
}

class BackupError extends BackupState {
  final String message;

  const BackupError(this.message);

  @override
  List<Object> get props => [message];
}