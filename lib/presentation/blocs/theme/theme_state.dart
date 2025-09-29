// lib/presentation/blocs/theme/theme_state.dart
part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final Color accentColor;
  final bool isAmoled;

  const ThemeState({
    required this.themeMode,
    required this.accentColor,
    required this.isAmoled,
  });

  factory ThemeState.initial() {
    return const ThemeState(
      themeMode: ThemeMode.system,
      accentColor: Colors.blue,
      isAmoled: false,
    );
  }

  ThemeState copyWith({
    ThemeMode? themeMode,
    Color? accentColor,
    bool? isAmoled,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      isAmoled: isAmoled ?? this.isAmoled,
    );
  }

  @override
  List<Object> get props => [themeMode, accentColor, isAmoled];
}