// lib/domain/entities/recurrence_rule_entity.dart
import 'package:equatable/equatable.dart';

class RecurrenceRuleEntity extends Equatable {
  final String? frequency;
  final int? interval;
  final int? count;
  final DateTime? until;
  final List<int>? byWeekdays;
  final List<int>? byMonthDays;
  final List<int>? byYearDays;
  final List<int>? byWeeks;
  final List<int>? byMonths;
  final List<int>? bySetPos;
  final List<DateTime>? exceptionDates;

  const RecurrenceRuleEntity({
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

  @override
  List<Object?> get props => [
        frequency,
        interval,
        count,
        until,
        byWeekdays,
        byMonthDays,
        byYearDays,
        byWeeks,
        byMonths,
        bySetPos,
        exceptionDates,
      ];

  RecurrenceRuleEntity copyWith({
    String? frequency,
    int? interval,
    int? count,
    DateTime? until,
    List<int>? byWeekdays,
    List<int>? byMonthDays,
    List<int>? byYearDays,
    List<int>? byWeeks,
    List<int>? byMonths,
    List<int>? bySetPos,
    List<DateTime>? exceptionDates,
  }) {
    return RecurrenceRuleEntity(
      frequency: frequency ?? this.frequency,
      interval: interval ?? this.interval,
      count: count ?? this.count,
      until: until ?? this.until,
      byWeekdays: byWeekdays ?? this.byWeekdays,
      byMonthDays: byMonthDays ?? this.byMonthDays,
      byYearDays: byYearDays ?? this.byYearDays,
      byWeeks: byWeeks ?? this.byWeeks,
      byMonths: byMonths ?? this.byMonths,
      bySetPos: bySetPos ?? this.bySetPos,
      exceptionDates: exceptionDates ?? this.exceptionDates,
    );
  }
}