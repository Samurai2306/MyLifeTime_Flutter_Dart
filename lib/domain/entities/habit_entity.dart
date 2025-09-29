// lib/domain/entities/habit_entity.dart
import 'package:equatable/equatable.dart';
import 'package:mylifetime/core/utils/date_utils.dart' as date_utils;
import 'package:mylifetime/core/utils/extension_methods.dart';

class HabitScheduleEntity extends Equatable {
  final int? weekday;
  final int? hour;
  final int? minute;

  const HabitScheduleEntity({
    this.weekday,
    this.hour,
    this.minute,
  });

  @override
  List<Object?> get props => [weekday, hour, minute];
}

class HabitEntity extends Equatable {
  final int id;
  final String title;
  final String? description;
  final int colorValue;
  final DateTime startDate;
  final DateTime? endDate;
  final List<HabitScheduleEntity> schedule;
  final List<DateTime> completedDates;
  final int targetCount;
  final String frequency;
  final bool isArchived;
  final int? categoryId;

  const HabitEntity({
    required this.id,
    required this.title,
    this.description,
    required this.colorValue,
    required this.startDate,
    this.endDate,
    this.schedule = const [],
    this.completedDates = const [],
    this.targetCount = 1,
    required this.frequency,
    this.isArchived = false,
    this.categoryId,
  });

  bool get isCompletedToday {
    final today = date_utils.DateUtils.startOfDay(DateTime.now());
    return completedDates.any((date) => date_utils.DateUtils.isSameDay(date, today));
  }

  int get currentStreak {
    if (completedDates.isEmpty) return 0;
    
    final sortedDates = completedDates.sortedBy((date) => date);
    var streak = 0;
    var currentDate = date_utils.DateUtils.startOfDay(DateTime.now());
    
    while (true) {
      if (sortedDates.any((date) => date_utils.DateUtils.isSameDay(date, currentDate))) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    
    return streak;
  }

  int get completionRate {
    final totalDays = date_utils.DateUtils.startOfDay(DateTime.now())
        .difference(date_utils.DateUtils.startOfDay(startDate))
        .inDays + 1;
    
    final completedDays = completedDates.length;
    return totalDays > 0 ? ((completedDays / totalDays) * 100).round() : 0;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        colorValue,
        startDate,
        endDate,
        schedule,
        completedDates,
        targetCount,
        frequency,
        isArchived,
        categoryId,
      ];

  HabitEntity copyWith({
    int? id,
    String? title,
    String? description,
    int? colorValue,
    DateTime? startDate,
    DateTime? endDate,
    List<HabitScheduleEntity>? schedule,
    List<DateTime>? completedDates,
    int? targetCount,
    String? frequency,
    bool? isArchived,
    int? categoryId,
  }) {
    return HabitEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      colorValue: colorValue ?? this.colorValue,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      schedule: schedule ?? this.schedule,
      completedDates: completedDates ?? this.completedDates,
      targetCount: targetCount ?? this.targetCount,
      frequency: frequency ?? this.frequency,
      isArchived: isArchived ?? this.isArchived,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}