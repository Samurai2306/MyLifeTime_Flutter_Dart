// lib/data/models/event_model.dart
import 'package:isar/isar.dart';
import 'package:mylifetime/core/utils/date_utils.dart';

part 'event_model.g.dart';

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
    // В реальной реализации здесь будет сериализация в JSON
    return recurrenceRule.toString();
  }
  
  // Метод для получения всех экземпляров повторяющегося события в диапазоне
  List<DateTime> getOccurrencesInRange(DateTime start, DateTime end) {
    final occurrences = <DateTime>[];
    
    if (recurrenceRule == null) {
      // Не повторяющееся событие
      if (_isInRange(startDate, start, end)) {
        occurrences.add(startDate);
      }
      return occurrences;
    }
    
    // Для повторяющихся событий генерируем все экземпляры в диапазоне
    var current = startDate;
    final until = recurrenceRule?.until ?? end.add(const Duration(days: 365));
    
    while (current.isBefore(until) && occurrences.length < 1000) { // Защита от бесконечного цикла
      if (_isInRange(current, start, end) && 
          recurrenceRule!.isDateInRecurrence(current)) {
        occurrences.add(current);
      }
      
      // Переходим к следующему интервалу в зависимости от частоты
      current = _getNextOccurrence(current);
    }
    
    return occurrences;
  }
  
  DateTime _getNextOccurrence(DateTime current) {
    switch (recurrenceRule?.frequency) {
      case 'daily':
        return current.add(Duration(days: recurrenceRule!.interval ?? 1));
      case 'weekly':
        return current.add(Duration(days: 7 * (recurrenceRule!.interval ?? 1)));
      case 'monthly':
        return DateTime(current.year, current.month + (recurrenceRule!.interval ?? 1), current.day);
      case 'yearly':
        return DateTime(current.year + (recurrenceRule!.interval ?? 1), current.month, current.day);
      default:
        return current.add(const Duration(days: 1));
    }
  }
  
  bool _isInRange(DateTime date, DateTime rangeStart, DateTime rangeEnd) {
    return (date.isAfter(rangeStart) || date.isAtSameMomentAs(rangeStart)) &&
           (date.isBefore(rangeEnd) || date.isAtSameMomentAs(rangeEnd));
  }
}