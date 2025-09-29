// lib/data/models/recurrence_rule_model.dart
import 'package:isar/isar.dart';

part 'recurrence_rule_model.g.dart';

@embedded
class RecurrenceRuleModel {
  String? frequency; // 'daily', 'weekly', 'monthly', 'yearly'
  int? interval;
  int? count;
  DateTime? until;
  
  List<int>? byWeekdays; // 1-7 (Monday-Sunday)
  List<int>? byMonthDays;
  List<int>? byYearDays;
  List<int>? byWeeks;
  List<int>? byMonths;
  List<int>? bySetPos;
  
  List<DateTime>? exceptionDates;
  
  RecurrenceRuleModel({
    this.frequency,
    this.interval = 1,
    this.count,
    this.until,
    this.byWeekdays,
    this.byMonthDays,
    this.byYearDays,
    this.byWeeks,
    this.byMonths,
    this.bySetPos,
    this.exceptionDates,
  });

  // Метод для проверки, попадает ли дата под правило повторения
  bool isDateInRecurrence(DateTime date) {
    if (frequency == null) return false;
    
    // Проверка исключений
    if (exceptionDates?.any((exception) => 
      DateUtils.isSameDay(exception, date)) == true) {
      return false;
    }
    
    switch (frequency) {
      case 'daily':
        return _isDailyRecurrence(date);
      case 'weekly':
        return _isWeeklyRecurrence(date);
      case 'monthly':
        return _isMonthlyRecurrence(date);
      case 'yearly':
        return _isYearlyRecurrence(date);
      default:
        return false;
    }
  }
  
  bool _isDailyRecurrence(DateTime date) {
    if (interval == null) return true;
    
    final startDate = _getStartDate();
    final difference = date.difference(startDate).inDays;
    return difference % interval! == 0;
  }
  
  bool _isWeeklyRecurrence(DateTime date) {
    if (byWeekdays?.isNotEmpty == true) {
      return byWeekdays!.contains(date.weekday);
    }
    
    if (interval == null) return true;
    
    final startDate = _getStartDate();
    final difference = date.difference(startDate).inDays;
    final weeks = (difference / 7).floor();
    return weeks % interval! == 0;
  }
  
  bool _isMonthlyRecurrence(DateTime date) {
    if (byMonthDays?.isNotEmpty == true) {
      return byMonthDays!.contains(date.day);
    }
    
    // TODO: Реализовать другие monthly правила
    return false;
  }
  
  bool _isYearlyRecurrence(DateTime date) {
    // TODO: Реализовать yearly правила
    return false;
  }
  
  DateTime _getStartDate() {
    // В реальной реализации это будет дата начала события
    return DateTime.now();
  }
}