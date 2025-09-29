// lib/domain/entities/event_entity.dart
import 'package:equatable/equatable.dart';
import 'recurrence_rule_entity.dart';

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

  EventEntity copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isAllDay,
    int? colorValue,
    int? categoryId,
    List<DateTime>? reminders,
    RecurrenceRuleEntity? recurrenceRule,
    List<String>? tags,
  }) {
    return EventEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isAllDay: isAllDay ?? this.isAllDay,
      colorValue: colorValue ?? this.colorValue,
      categoryId: categoryId ?? this.categoryId,
      reminders: reminders ?? this.reminders,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      tags: tags ?? this.tags,
    );
  }
}