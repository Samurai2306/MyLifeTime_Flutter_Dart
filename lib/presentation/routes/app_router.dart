// presentation/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:mylifetime/presentation/pages/calendar/calendar_page.dart';
import 'package:mylifetime/presentation/pages/habits/habits_page.dart';
import 'package:mylifetime/presentation/pages/pomodoro/pomodoro_page.dart';
import 'package:mylifetime/presentation/pages/settings/settings_page.dart';
import 'package:mylifetime/presentation/pages/event/event_form_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const CalendarPage(),
        routes: [
          GoRoute(
            path: 'habits',
            name: 'habits',
            builder: (context, state) => const HabitsPage(),
          ),
          GoRoute(
            path: 'pomodoro',
            name: 'pomodoro',
            builder: (context, state) => const PomodoroPage(),
          ),
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: 'event/new',
            name: 'event_new',
            builder: (context, state) => EventFormPage(),
          ),
          GoRoute(
            path: 'event/:id/edit',
            name: 'event_edit',
            builder: (context, state) {
              final eventId = int.parse(state.pathParameters['id']!);
              return EventFormPage(eventId: eventId);
            },
          ),
        ],
      ),
    ],
  );
}