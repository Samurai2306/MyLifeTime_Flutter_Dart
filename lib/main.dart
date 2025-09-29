// main.dart (ОБНОВЛЕННЫЙ)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mylifetime/core/injection_container.dart' as di;
import 'package:mylifetime/presentation/blocs/event/event_bloc.dart';
import 'package:mylifetime/presentation/routes/app_router.dart';
import 'package:mylifetime/presentation/themes/app_theme.dart';

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
        BlocProvider<EventBloc>(
          create: (context) => GetIt.instance<EventBloc>(),
        ),
        // Добавьте другие BLoC провайдеры по мере реализации
      ],
      child: MaterialApp.router(
        title: 'MyLifeTime',
        theme: AppTheme.lightTheme(Colors.blue),
        darkTheme: AppTheme.darkTheme(Colors.blue),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}