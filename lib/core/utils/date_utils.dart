// lib/core/utils/date_utils.dart
import 'package:intl/intl.dart';

class DateUtils {
  static DateTime get startOfToday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime get endOfToday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  static DateTime startOfWeek(DateTime date) {
    final weekStart = date.subtract(Duration(days: date.weekday - 1));
    return startOfDay(weekStart);
  }

  static DateTime endOfWeek(DateTime date) {
    final weekEnd = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    return endOfDay(weekEnd);
  }

  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static List<DateTime> getDaysInRange(DateTime start, DateTime end) {
    final days = <DateTime>[];
    var current = startOfDay(start);
    final endDate = startOfDay(end);

    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }

    return days;
  }
}