// lib/data/mappers/event_mapper.dart
import 'package:mylifetime/data/models/event_model.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/data/models/recurrence_rule_model.dart';
import 'package:mylifetime/domain/entities/recurrence_rule_entity.dart';

class EventMapper {
  static EventEntity toEntity(EventModel model) {
    return EventEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      startDate: model.startDate,
      endDate: model.endDate,
      isAllDay: model.isAllDay,
      colorValue: model.colorValue,
      categoryId: model.categoryId,
      reminders: model.reminders,
      recurrenceRule: _recurrenceRuleToEntity(model.recurrenceRule),
      tags: model.tags,
    );
  }

  static EventModel toModel(EventEntity entity) {
    return EventModel()
      ..id = entity.id
      ..title = entity.title
      ..description = entity.description
      ..startDate = entity.startDate
      ..endDate = entity.endDate
      ..isAllDay = entity.isAllDay
      ..colorValue = entity.colorValue
      ..categoryId = entity.categoryId
      ..reminders = entity.reminders
      ..recurrenceRule = _recurrenceRuleToModel(entity.recurrenceRule)
      ..tags = entity.tags;
  }

  static RecurrenceRuleEntity? _recurrenceRuleToEntity(
    RecurrenceRuleModel? model,
  ) {
    if (model == null) return null;
    
    return RecurrenceRuleEntity(
      frequency: model.frequency,
      interval: model.interval,
      count: model.count,
      until: model.until,
      byWeekdays: model.byWeekdays,
      byMonthDays: model.byMonthDays,
      byYearDays: model.byYearDays,
      byWeeks: model.byWeeks,
      byMonths: model.byMonths,
      bySetPos: model.bySetPos,
      exceptionDates: model.exceptionDates,
    );
  }

  static RecurrenceRuleModel? _recurrenceRuleToModel(
    RecurrenceRuleEntity? entity,
  ) {
    if (entity == null) return null;
    
    return RecurrenceRuleModel(
      frequency: entity.frequency,
      interval: entity.interval,
      count: entity.count,
      until: entity.until,
      byWeekdays: entity.byWeekdays,
      byMonthDays: entity.byMonthDays,
      byYearDays: entity.byYearDays,
      byWeeks: entity.byWeeks,
      byMonths: entity.byMonths,
      bySetPos: entity.bySetPos,
      exceptionDates: entity.exceptionDates,
    );
  }
}