// lib/presentation/blocs/backup/backup_event.dart
part of 'backup_bloc.dart';

abstract class BackupEvent extends Equatable {
  const BackupEvent();

  @override
  List<Object> get props => [];
}

class CreateBackupEvent extends BackupEvent {}

class RestoreBackupEvent extends BackupEvent {
  final String filePath;

  const RestoreBackupEvent(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class ExportDataEvent extends BackupEvent {
  final String format;

  const ExportDataEvent(this.format);

  @override
  List<Object> get props => [format];
}