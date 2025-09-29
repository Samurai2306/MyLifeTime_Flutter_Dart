// data/models/event_model.dart
import 'package:isar/isar.dart';

part 'event_model.g.dart';

@embedded
class RecurrenceRuleModel {
  String? frequency; // 'daily', 'weekly', 'monthly', 'yearly'
  int? interval;
  int? count;
  DateTime? until;
  
  @enumerated
  Weekdays? byWeekday;
  
  int? byMonthDay;
  int? byYearDay;
  int? byWeek;
  int? byMonth;
  int? bySetPos;
  
  List<DateTime>? exceptionDates;
}

enum Weekdays {
  monday(1),
  tuesday(2),
  wednesday(3),
  thursday(4),
  friday(5),
  saturday(6),
  sunday(7);

  const Weekdays(this.value);
  final int value;
}

@Collection()
class EventModel {
  Id id = Isar.autoIncrement;
  
  @Index()
  late DateTime startDate;
  
  @Index()
  late DateTime endDate;
  
  late String title;
  String? description;
  
  bool isAllDay = false;
  int colorValue;
  
  @Index()
  int? categoryId;
  
  List<DateTime> reminders = [];
  RecurrenceRuleModel? recurrenceRule;
  List<String> tags = [];
  
  // Для производительности - храним расширенные поля для поиска
  @Index()
  List<String> get searchableTags => tags;
  
  String? get recurrenceRuleJson {
    if (recurrenceRule == null) return null;
    // Сериализация для поиска/фильтрации
    return recurrenceRule.toString();
  }
}

@Collection()
class CalendarCategoryModel {
  Id id = Isar.autoIncrement;
  
  late String name;
  late int colorValue;
  bool isVisible = true;
  
  @Index()
  late int sortOrder;
}