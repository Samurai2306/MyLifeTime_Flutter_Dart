lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── route_names.dart
│   │   └── string_constants.dart
│   ├── errors/
│   │   ├── exceptions.dart
│   │   ├── failures.dart
│   │   └── error_handler.dart
│   ├── network/
│   │   └── network_info.dart
│   ├── usecases/
│   │   └── usecase.dart
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── extension_methods.dart
│   │   ├── notification_utils.dart
│   │   ├── backup_utils.dart
│   │   └── widget_utils.dart
│   └── injection_container.dart
├── data/
│   ├── datasources/
│   │   ├── local/
│   │   │   ├── isar_database.dart
│   │   │   ├── event_local_datasource.dart
│   │   │   ├── category_local_datasource.dart
│   │   │   ├── habit_local_datasource.dart
│   │   │   ├── goal_local_datasource.dart
│   │   │   ├── note_local_datasource.dart
│   │   │   └── backup_datasource.dart
│   │   └── remote/ (заготовка для будущего)
│   ├── models/
│   │   ├── event_model.dart
│   │   ├── category_model.dart
│   │   ├── habit_model.dart
│   │   ├── goal_model.dart
│   │   ├── note_model.dart
│   │   ├── recurrence_rule_model.dart
│   │   └── backup_model.dart
│   └── repositories/
│       ├── event_repository_impl.dart
│       ├── category_repository_impl.dart
│       ├── habit_repository_impl.dart
│       ├── goal_repository_impl.dart
│       ├── note_repository_impl.dart
│       └── backup_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── event_entity.dart
│   │   ├── category_entity.dart
│   │   ├── habit_entity.dart
│   │   ├── goal_entity.dart
│   │   ├── note_entity.dart
│   │   └── recurrence_rule_entity.dart
│   ├── repositories/
│   │   ├── event_repository.dart
│   │   ├── category_repository.dart
│   │   ├── habit_repository.dart
│   │   ├── goal_repository.dart
│   │   ├── note_repository.dart
│   │   └── backup_repository.dart
│   └── usecases/
│       ├── events/
│       │   ├── get_events.dart
│       │   ├── get_event_by_id.dart
│       │   ├── add_event.dart
│       │   ├── update_event.dart
│       │   ├── delete_event.dart
│       │   └── get_events_by_date_range.dart
│       ├── categories/
│       │   ├── get_categories.dart
│       │   ├── add_category.dart
│       │   ├── update_category.dart
│       │   └── delete_category.dart
│       ├── habits/
│       │   ├── get_habits.dart
│       │   ├── get_habit_by_id.dart
│       │   ├── add_habit.dart
│       │   ├── update_habit.dart
│       │   ├── delete_habit.dart
│       │   └── mark_habit_completed.dart
│       ├── goals/
│       │   ├── get_goals.dart
│       │   ├── add_goal.dart
│       │   ├── update_goal.dart
│       │   └── delete_goal.dart
│       ├── notes/
│       │   ├── get_notes.dart
│       │   ├── add_note.dart
│       │   ├── update_note.dart
│       │   └── delete_note.dart
│       └── backup/
│           ├── create_backup.dart
│           ├── restore_backup.dart
│           └── export_data.dart
└── presentation/
    ├── blocs/
    │   ├── event/
    │   │   ├── event_bloc.dart
    │   │   ├── event_event.dart
    │   │   └── event_state.dart
    │   ├── category/
    │   │   ├── category_bloc.dart
    │   │   ├── category_event.dart
    │   │   └── category_state.dart
    │   ├── habit/
    │   │   ├── habit_bloc.dart
    │   │   ├── habit_event.dart
    │   │   └── habit_state.dart
    │   ├── goal/
    │   │   ├── goal_bloc.dart
    │   │   ├── goal_event.dart
    │   │   └── goal_state.dart
    │   ├── note/
    │   │   ├── note_bloc.dart
    │   │   ├── note_event.dart
    │   │   └── note_state.dart
    │   ├── theme/
    │   │   ├── theme_bloc.dart
    │   │   ├── theme_event.dart
    │   │   └── theme_state.dart
    │   ├── pomodoro/
    │   │   ├── pomodoro_bloc.dart
    │   │   ├── pomodoro_event.dart
    │   │   └── pomodoro_state.dart
    │   └── backup/
    │       ├── backup_bloc.dart
    │       ├── backup_event.dart
    │       └── backup_state.dart
    ├── pages/
    │   ├── calendar/
    │   │   ├── calendar_page.dart
    │   │   ├── day_view_page.dart
    │   │   ├── week_view_page.dart
    │   │   ├── month_view_page.dart
    │   │   └── agenda_view_page.dart
    │   ├── habits/
    │   │   ├── habits_page.dart
    │   │   ├── habit_form_page.dart
    │   │   └── habit_stats_page.dart
    │   ├── goals/
    │   │   ├── goals_page.dart
    │   │   └── goal_form_page.dart
    │   ├── notes/
    │   │   ├── notes_page.dart
    │   │   └── note_form_page.dart
    │   ├── pomodoro/
    │   │   └── pomodoro_page.dart
    │   ├── settings/
    │   │   ├── settings_page.dart
    │   │   ├── theme_settings_page.dart
    │   │   ├── category_settings_page.dart
    │   │   └── backup_settings_page.dart
    │   └── event/
    │       └── event_form_page.dart
    ├── widgets/
    │   ├── calendar/
    │   │   ├── glass_event_card.dart
    │   │   ├── hourly_grid.dart
    │   │   ├── week_calendar.dart
    │   │   ├── month_calendar.dart
    │   │   ├── agenda_list.dart
    │   │   └── calendar_navigation.dart
    │   ├── habits/
    │   │   ├── habit_card.dart
    │   │   └── habit_calendar_grid.dart
    │   ├── common/
    │   │   ├── custom_app_bar.dart
    │   │   ├── custom_bottom_nav_bar.dart
    │   │   ├── glass_container.dart
    │   │   ├── loading_indicator.dart
    │   │   └── error_widget.dart
    │   └── custom/
    │       ├── custom_text_field.dart
    │       └── custom_dropdown.dart
    ├── routes/
    │   └── app_router.dart
    └── themes/
        ├── app_theme.dart
        ├── color_extensions.dart
        ├── glass_effects.dart
        └── text_styles.dart