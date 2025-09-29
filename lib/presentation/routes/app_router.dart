// lib/presentation/routes/app_router.dart - ПОЛНЫЙ ОБНОВЛЕННЫЙ ФАЙЛ
import 'package:go_router/go_router.dart';
import 'package:mylifetime/presentation/pages/calendar/calendar_page.dart';
import 'package:mylifetime/presentation/pages/habits/habits_page.dart';
import 'package:mylifetime/presentation/pages/goals/goals_page.dart';
import 'package:mylifetime/presentation/pages/notes/notes_page.dart';
import 'package:mylifetime/presentation/pages/pomodoro/pomodoro_page.dart';
import 'package:mylifetime/presentation/pages/settings/settings_page.dart';
import 'package:mylifetime/presentation/pages/event/event_form_page.dart';
import 'package:mylifetime/presentation/pages/habit/habit_form_page.dart';
import 'package:mylifetime/presentation/pages/goal/goal_form_page.dart';
import 'package:mylifetime/presentation/pages/note/note_form_page.dart';

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
            path: 'goals',
            name: 'goals',
            builder: (context, state) => const GoalsPage(),
          ),
          GoRoute(
            path: 'notes',
            name: 'notes',
            builder: (context, state) => const NotesPage(),
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
          GoRoute(
            path: 'habit/new',
            name: 'habit_new',
            builder: (context, state) => HabitFormPage(),
          ),
          GoRoute(
            path: 'habit/:id/edit',
            name: 'habit_edit',
            builder: (context, state) {
              final habitId = int.parse(state.pathParameters['id']!);
              return HabitFormPage(habitId: habitId);
            },
          ),
          GoRoute(
            path: 'goal/new',
            name: 'goal_new',
            builder: (context, state) => GoalFormPage(),
          ),
          GoRoute(
            path: 'goal/:id/edit',
            name: 'goal_edit',
            builder: (context, state) {
              final goalId = int.parse(state.pathParameters['id']!);
              return GoalFormPage(goalId: goalId);
            },
          ),
          GoRoute(
            path: 'note/new',
            name: 'note_new',
            builder: (context, state) => NoteFormPage(),
          ),
          GoRoute(
            path: 'note/:id/edit',
            name: 'note_edit',
            builder: (context, state) {
              final noteId = int.parse(state.pathParameters['id']!);
              return NoteFormPage(noteId: noteId);
            },
          ),
        ],
      ),
    ],
  );
}