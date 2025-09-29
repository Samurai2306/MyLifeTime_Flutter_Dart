// lib/core/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

// Data Sources
import 'package:mylifetime/data/datasources/local/isar_database.dart';
import 'package:mylifetime/data/datasources/local/event_local_datasource.dart';
import 'package:mylifetime/data/datasources/local/category_local_datasource.dart';
import 'package:mylifetime/data/datasources/local/habit_local_datasource.dart';
import 'package:mylifetime/data/datasources/local/goal_local_datasource.dart';
import 'package:mylifetime/data/datasources/local/note_local_datasource.dart';
import 'package:mylifetime/data/datasources/local/backup_datasource.dart';

// Repositories
import 'package:mylifetime/data/repositories/event_repository_impl.dart';
import 'package:mylifetime/data/repositories/category_repository_impl.dart';
import 'package:mylifetime/data/repositories/habit_repository_impl.dart';
import 'package:mylifetime/data/repositories/goal_repository_impl.dart';
import 'package:mylifetime/data/repositories/note_repository_impl.dart';
import 'package:mylifetime/data/repositories/backup_repository_impl.dart';

// Domain Repositories
import 'package:mylifetime/domain/repositories/event_repository.dart';
import 'package:mylifetime/domain/repositories/category_repository.dart';
import 'package:mylifetime/domain/repositories/habit_repository.dart';
import 'package:mylifetime/domain/repositories/goal_repository.dart';
import 'package:mylifetime/domain/repositories/note_repository.dart';
import 'package:mylifetime/domain/repositories/backup_repository.dart';

// Use Cases - Events
import 'package:mylifetime/domain/usecases/events/get_events.dart';
import 'package:mylifetime/domain/usecases/events/get_event_by_id.dart';
import 'package:mylifetime/domain/usecases/events/add_event.dart';
import 'package:mylifetime/domain/usecases/events/update_event.dart';
import 'package:mylifetime/domain/usecases/events/delete_event.dart';

// Use Cases - Categories
import 'package:mylifetime/domain/usecases/categories/get_categories.dart';
import 'package:mylifetime/domain/usecases/categories/add_category.dart';
import 'package:mylifetime/domain/usecases/categories/update_category.dart';
import 'package:mylifetime/domain/usecases/categories/delete_category.dart';

// Use Cases - Habits
import 'package:mylifetime/domain/usecases/habits/get_habits.dart';
import 'package:mylifetime/domain/usecases/habits/get_habit_by_id.dart';
import 'package:mylifetime/domain/usecases/habits/add_habit.dart';
import 'package:mylifetime/domain/usecases/habits/update_habit.dart';
import 'package:mylifetime/domain/usecases/habits/delete_habit.dart';
import 'package:mylifetime/domain/usecases/habits/mark_habit_completed.dart';

// Use Cases - Goals
import 'package:mylifetime/domain/usecases/goals/get_goals.dart';
import 'package:mylifetime/domain/usecases/goals/add_goal.dart';
import 'package:mylifetime/domain/usecases/goals/update_goal.dart';
import 'package:mylifetime/domain/usecases/goals/delete_goal.dart';

// Use Cases - Notes
import 'package:mylifetime/domain/usecases/notes/get_notes.dart';
import 'package:mylifetime/domain/usecases/notes/add_note.dart';
import 'package:mylifetime/domain/usecases/notes/update_note.dart';
import 'package:mylifetime/domain/usecases/notes/delete_note.dart';

// Use Cases - Backup
import 'package:mylifetime/domain/usecases/backup/create_backup.dart';
import 'package:mylifetime/domain/usecases/backup/restore_backup.dart';
import 'package:mylifetime/domain/usecases/backup/export_data.dart';

// BLoCs
import 'package:mylifetime/presentation/blocs/event/event_bloc.dart';
import 'package:mylifetime/presentation/blocs/category/category_bloc.dart';
import 'package:mylifetime/presentation/blocs/habit/habit_bloc.dart';
import 'package:mylifetime/presentation/blocs/goal/goal_bloc.dart';
import 'package:mylifetime/presentation/blocs/note/note_bloc.dart';
import 'package:mylifetime/presentation/blocs/theme/theme_bloc.dart';
import 'package:mylifetime/presentation/blocs/pomodoro/pomodoro_bloc.dart';
import 'package:mylifetime/presentation/blocs/backup/backup_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  await _initExternalDependencies();
  
  // Data sources
  await _initDataSources();
  
  // Repositories
  _initRepositories();
  
  // Use cases
  _initUseCases();
  
  // BLoCs
  _initBlocs();
}

Future<void> _initExternalDependencies() async {
  // Initialize Isar database
  final isar = await IsarDatabase.initialize();
  sl.registerLazySingleton<Isar>(() => isar);
}

Future<void> _initDataSources() async {
  sl.registerLazySingleton<EventLocalDataSource>(
    () => EventLocalDataSource(sl<Isar>()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSource(sl<Isar>()),
  );
  sl.registerLazySingleton<HabitLocalDataSource>(
    () => HabitLocalDataSource(sl<Isar>()),
  );
  sl.registerLazySingleton<GoalLocalDataSource>(
    () => GoalLocalDataSource(sl<Isar>()),
  );
  sl.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSource(sl<Isar>()),
  );
  sl.registerLazySingleton<BackupLocalDataSource>(
    () => BackupLocalDataSource(sl<Isar>()),
  );
}

void _initRepositories() {
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(localDataSource: sl<EventLocalDataSource>()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(localDataSource: sl<CategoryLocalDataSource>()),
  );
  sl.registerLazySingleton<HabitRepository>(
    () => HabitRepositoryImpl(localDataSource: sl<HabitLocalDataSource>()),
  );
  sl.registerLazySingleton<GoalRepository>(
    () => GoalRepositoryImpl(localDataSource: sl<GoalLocalDataSource>()),
  );
  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(localDataSource: sl<NoteLocalDataSource>()),
  );
  sl.registerLazySingleton<BackupRepository>(
    () => BackupRepositoryImpl(localDataSource: sl<BackupLocalDataSource>()),
  );
}

void _initUseCases() {
  // Event use cases
  sl.registerLazySingleton(() => GetEvents(sl<EventRepository>()));
  sl.registerLazySingleton(() => GetEventById(sl<EventRepository>()));
  sl.registerLazySingleton(() => AddEvent(sl<EventRepository>()));
  sl.registerLazySingleton(() => UpdateEvent(sl<EventRepository>()));
  sl.registerLazySingleton(() => DeleteEvent(sl<EventRepository>()));
  
  // Category use cases
  sl.registerLazySingleton(() => GetCategories(sl<CategoryRepository>()));
  sl.registerLazySingleton(() => AddCategory(sl<CategoryRepository>()));
  sl.registerLazySingleton(() => UpdateCategory(sl<CategoryRepository>()));
  sl.registerLazySingleton(() => DeleteCategory(sl<CategoryRepository>()));
  
  // Habit use cases
  sl.registerLazySingleton(() => GetHabits(sl<HabitRepository>()));
  sl.registerLazySingleton(() => GetHabitById(sl<HabitRepository>()));
  sl.registerLazySingleton(() => AddHabit(sl<HabitRepository>()));
  sl.registerLazySingleton(() => UpdateHabit(sl<HabitRepository>()));
  sl.registerLazySingleton(() => DeleteHabit(sl<HabitRepository>()));
  sl.registerLazySingleton(() => MarkHabitCompleted(sl<HabitRepository>()));
  
  // Goal use cases
  sl.registerLazySingleton(() => GetGoals(sl<GoalRepository>()));
  sl.registerLazySingleton(() => AddGoal(sl<GoalRepository>()));
  sl.registerLazySingleton(() => UpdateGoal(sl<GoalRepository>()));
  sl.registerLazySingleton(() => DeleteGoal(sl<GoalRepository>()));
  
  // Note use cases
  sl.registerLazySingleton(() => GetNotes(sl<NoteRepository>()));
  sl.registerLazySingleton(() => AddNote(sl<NoteRepository>()));
  sl.registerLazySingleton(() => UpdateNote(sl<NoteRepository>()));
  sl.registerLazySingleton(() => DeleteNote(sl<NoteRepository>()));
  
  // Backup use cases
  sl.registerLazySingleton(() => CreateBackup(sl<BackupRepository>()));
  sl.registerLazySingleton(() => RestoreBackup(sl<BackupRepository>()));
  sl.registerLazySingleton(() => ExportData(sl<BackupRepository>()));
}

void _initBlocs() {
  sl.registerFactory(() => EventBloc(
    getEvents: sl<GetEvents>(),
    getEventById: sl<GetEventById>(),
    addEvent: sl<AddEvent>(),
    updateEvent: sl<UpdateEvent>(),
    deleteEvent: sl<DeleteEvent>(),
  ));
  
  sl.registerFactory(() => CategoryBloc(
    getCategories: sl<GetCategories>(),
    addCategory: sl<AddCategory>(),
    updateCategory: sl<UpdateCategory>(),
    deleteCategory: sl<DeleteCategory>(),
  ));
  
  sl.registerFactory(() => HabitBloc(
    getHabits: sl<GetHabits>(),
    getHabitById: sl<GetHabitById>(),
    addHabit: sl<AddHabit>(),
    updateHabit: sl<UpdateHabit>(),
    deleteHabit: sl<DeleteHabit>(),
    markHabitCompleted: sl<MarkHabitCompleted>(),
  ));
  
  sl.registerFactory(() => GoalBloc(
    getGoals: sl<GetGoals>(),
    addGoal: sl<AddGoal>(),
    updateGoal: sl<UpdateGoal>(),
    deleteGoal: sl<DeleteGoal>(),
  ));
  
  sl.registerFactory(() => NoteBloc(
    getNotes: sl<GetNotes>(),
    addNote: sl<AddNote>(),
    updateNote: sl<UpdateNote>(),
    deleteNote: sl<DeleteNote>(),
  ));
  
  sl.registerSingleton<ThemeBloc>(ThemeBloc());
  sl.registerFactory(() => PomodoroBloc());
  sl.registerFactory(() => BackupBloc(
    createBackup: sl<CreateBackup>(),
    restoreBackup: sl<RestoreBackup>(),
    exportData: sl<ExportData>(),
  ));
}