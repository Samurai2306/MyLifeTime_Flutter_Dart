// lib/main.dart - ПОЛНЫЙ ФИНАЛЬНЫЙ ФАЙЛ
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:mylifetime/core/injection_container.dart' as di;
import 'package:mylifetime/presentation/routes/app_router.dart';
import 'package:mylifetime/presentation/themes/app_theme.dart';
import 'package:mylifetime/presentation/blocs/theme/theme_bloc.dart';
import 'package:mylifetime/presentation/pages/main_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => GetIt.instance<ThemeBloc>(),
        ),
        BlocProvider<EventBloc>(
          create: (context) => GetIt.instance<EventBloc>(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => GetIt.instance<CategoryBloc>(),
        ),
        BlocProvider<HabitBloc>(
          create: (context) => GetIt.instance<HabitBloc>(),
        ),
        BlocProvider<GoalBloc>(
          create: (context) => GetIt.instance<GoalBloc>(),
        ),
        BlocProvider<NoteBloc>(
          create: (context) => GetIt.instance<NoteBloc>(),
        ),
        BlocProvider<PomodoroBloc>(
          create: (context) => GetIt.instance<PomodoroBloc>(),
        ),
        BlocProvider<BackupBloc>(
          create: (context) => GetIt.instance<BackupBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'MyLifeTime',
            theme: AppTheme.lightTheme(themeState.accentColor),
            darkTheme: themeState.isAmoled 
                ? AppTheme.amoledTheme(themeState.accentColor)
                : AppTheme.darkTheme(themeState.accentColor),
            themeMode: themeState.themeMode,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return MainScaffold(child: child!);
            },
          );
        },
      ),
    );
  }
}