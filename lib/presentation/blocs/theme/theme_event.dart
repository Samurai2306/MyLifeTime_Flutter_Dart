// lib/presentation/blocs/theme/theme_event.dart
part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends ThemeEvent {
  final ThemeMode themeMode;

  const ChangeTheme(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ChangeAccentColor extends ThemeEvent {
  final Color accentColor;

  const ChangeAccentColor(this.accentColor);

  @override
  List<Object> get props => [accentColor];
}

class ToggleDarkMode extends ThemeEvent {}