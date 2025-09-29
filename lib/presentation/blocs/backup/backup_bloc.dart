// lib/presentation/blocs/backup/backup_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylifetime/domain/usecases/backup/create_backup.dart';
import 'package:mylifetime/domain/usecases/backup/restore_backup.dart';
import 'package:mylifetime/domain/usecases/backup/export_data.dart';

part 'backup_event.dart';
part 'backup_state.dart';

class BackupBloc extends Bloc<BackupEvent, BackupState> {
  final CreateBackup createBackup;
  final RestoreBackup restoreBackup;
  final ExportData exportData;

  BackupBloc({
    required this.createBackup,
    required this.restoreBackup,
    required this.exportData,
  }) : super(BackupInitial()) {
    on<CreateBackupEvent>(_onCreateBackup);
    on<RestoreBackupEvent>(_onRestoreBackup);
    on<ExportDataEvent>(_onExportData);
  }

  Future<void> _onCreateBackup(
    CreateBackupEvent event,
    Emitter<BackupState> emit,
  ) async {
    emit(BackupLoading());
    
    final result = await createBackup(NoParams());

    result.fold(
      (failure) => emit(BackupError(failure.message)),
      (backupPath) => emit(BackupCreated(backupPath: backupPath)),
    );
  }

  Future<void> _onRestoreBackup(
    RestoreBackupEvent event,
    Emitter<BackupState> emit,
  ) async {
    emit(BackupLoading());
    
    final result = await restoreBackup(RestoreBackupParams(filePath: event.filePath));

    result.fold(
      (failure) => emit(BackupError(failure.message)),
      (_) => emit(BackupRestored()),
    );
  }

  Future<void> _onExportData(
    ExportDataEvent event,
    Emitter<BackupState> emit,
  ) async {
    emit(BackupLoading());
    
    final result = await exportData(ExportDataParams(format: event.format));

    result.fold(
      (failure) => emit(BackupError(failure.message)),
      (exportPath) => emit(DataExported(exportPath: exportPath)),
    );
  }
}