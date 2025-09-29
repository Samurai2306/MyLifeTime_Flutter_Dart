// lib/presentation/blocs/theme/theme_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ChangeTheme>(_onChangeTheme);
    on<ChangeAccentColor>(_onChangeAccentColor);
    on<ToggleDarkMode>(_onToggleDarkMode);
  }

  void _onChangeTheme(ChangeTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _onChangeAccentColor(ChangeAccentColor event, Emitter<ThemeState> emit) {
    emit(state.copyWith(accentColor: event.color));
  }

  void _onToggleDarkMode(ToggleDarkMode event, Emitter<ThemeState> emit) {
    final newThemeMode = state.themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    emit(state.copyWith(themeMode: newThemeMode));
  }
}