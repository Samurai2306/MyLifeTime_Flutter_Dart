// lib/data/models/habit_model.dart
import 'package:isar/isar.dart';

part 'habit_model.g.dart';

@embedded
class HabitSchedule {
  int? weekday; // 1-7 (Monday-Sunday)
  int? hour;
  int? minute;
  
  HabitSchedule({this.weekday, this.hour, this.minute});
}

@Collection()
class HabitModel {
  Id id = Isar.autoIncrement;
  
  late String title;
  String? description;
  int colorValue;
  
  @Index()
  late DateTime startDate;
  
  @Index()
  late DateTime? endDate;
  
  List<HabitSchedule> schedule = [];
  List<DateTime> completedDates = [];
  
  int targetCount = 1; // Цель в день/неделю/месяц
  String frequency; // 'daily', 'weekly', 'monthly'
  
  bool isArchived = false;
  
  @Index()
  int? categoryId;
  
  HabitModel({
    required this.title,
    this.description,
    required this.colorValue,
    required this.startDate,
    this.endDate,
    required this.frequency,
    this.targetCount = 1,
  });
  
  bool get isCompletedToday {
    final today = DateUtils.startOfDay(DateTime.now());
    return completedDates.any((date) => DateUtils.isSameDay(date, today));
  }
  
  int get currentStreak {
    if (completedDates.isEmpty) return 0;
    
    final sortedDates = completedDates.sortedBy((date) => date);
    var streak = 0;
    var currentDate = DateUtils.startOfDay(DateTime.now());
    
    while (true) {
      if (sortedDates.any((date) => DateUtils.isSameDay(date, currentDate))) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    
    return streak;
  }
  
  int get completionRate {
    final totalDays = DateUtils.startOfDay(DateTime.now())
        .difference(DateUtils.startOfDay(startDate))
        .inDays + 1;
    
    final completedDays = completedDates.length;
    return ((completedDays / totalDays) * 100).round();
  }
}