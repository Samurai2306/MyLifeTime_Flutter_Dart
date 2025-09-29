// domain/entities/event_entity.dart
import 'package:equatable/equatable.dart';

class RecurrenceRuleEntity extends Equatable {
  final String? frequency;
  final int? interval;
  final int? count;
  final DateTime? until;
  final List<int>? byWeekday;
  final int? byMonthDay;
  final int? byYearDay;
  final int? byWeek;
  final int? byMonth;
  final int? bySetPos;
  final List<DateTime>? exceptionDates;

  const RecurrenceRuleEntity({
    this.frequency,
    this.interval,
    this.count,
    this.until,
    this.byWeekday,
    this.byMonthDay,
    this.byYearDay,
    this.byWeek,
    this.byMonth,
    this.bySetPos,
    this.exceptionDates,
  });

  @override
  List<Object?> get props => [
        frequency,
        interval,
        count,
        until,
        byWeekday,
        byMonthDay,
        byYearDay,
        byWeek,
        byMonth,
        bySetPos,
        exceptionDates,
      ];
}

class EventEntity extends Equatable {
  final int id;
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isAllDay;
  final int colorValue;
  final int? categoryId;
  final List<DateTime> reminders;
  final RecurrenceRuleEntity? recurrenceRule;
  final List<String> tags;

  const EventEntity({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.isAllDay,
    required this.colorValue,
    this.categoryId,
    this.reminders = const [],
    this.recurrenceRule,
    this.tags = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        startDate,
        endDate,
        isAllDay,
        colorValue,
        categoryId,
        reminders,
        recurrenceRule,
        tags,
      ];
}