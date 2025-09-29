// data/models/habit_model.dart
import 'package:isar/isar.dart';

part 'habit_model.g.dart';

@Collection()
class HabitModel {
  Id id = Isar.autoIncrement;
  
  late String title;
  String? description;
  int colorValue;
  
  @Index()
  late DateTime startDate;
  
  List<HabitSchedule> schedule = [];
  List<DateTime> completedDates = [];
  
  int targetCount; // Цель в день/неделю/месяц
  String frequency; // 'daily', 'weekly', 'monthly'
  
  bool get isCompletedToday {
    final today = DateTime.now();
    return completedDates.any((date) => 
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day
    );
  }
}

@embedded
class HabitSchedule {
  @enumerated
  Weekday? weekday;
  TimeOfDay? time;
}

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}