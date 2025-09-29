// lib/data/mappers/habit_mapper.dart
import 'package:mylifetime/data/models/habit_model.dart';
import 'package:mylifetime/domain/entities/habit_entity.dart';

class HabitMapper {
  static HabitEntity toEntity(HabitModel model) {
    return HabitEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      colorValue: model.colorValue,
      startDate: model.startDate,
      endDate: model.endDate,
      schedule: model.schedule.map((schedule) => 
        HabitScheduleEntity(
          weekday: schedule.weekday,
          hour: schedule.hour,
          minute: schedule.minute,
        ),
      ).toList(),
      completedDates: model.completedDates,
      targetCount: model.targetCount,
      frequency: model.frequency,
      isArchived: model.isArchived,
      categoryId: model.categoryId,
    );
  }

  static HabitModel toModel(HabitEntity entity) {
    return HabitModel()
      ..id = entity.id
      ..title = entity.title
      ..description = entity.description
      ..colorValue = entity.colorValue
      ..startDate = entity.startDate
      ..endDate = entity.endDate
      ..schedule = entity.schedule.map((schedule) => 
        HabitSchedule()
          ..weekday = schedule.weekday
          ..hour = schedule.hour
          ..minute = schedule.minute,
      ).toList()
      ..completedDates = entity.completedDates
      ..targetCount = entity.targetCount
      ..frequency = entity.frequency
      ..isArchived = entity.isArchived
      ..categoryId = entity.categoryId;
  }
}