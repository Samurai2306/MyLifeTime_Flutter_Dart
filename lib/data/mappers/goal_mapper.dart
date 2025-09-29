// lib/data/mappers/goal_mapper.dart
import 'package:mylifetime/data/models/goal_model.dart';
import 'package:mylifetime/domain/entities/goal_entity.dart';

class GoalMapper {
  static GoalEntity toEntity(GoalModel model) {
    return GoalEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      colorValue: model.colorValue,
      startDate: model.startDate,
      targetDate: model.targetDate,
      milestones: model.milestones.map((milestone) => 
        GoalMilestone(
          title: milestone.title,
          description: milestone.description,
          isCompleted: milestone.isCompleted,
          completedDate: milestone.completedDate,
        ),
      ).toList(),
      categoryId: model.categoryId,
      isArchived: model.isArchived,
    );
  }

  static GoalModel toModel(GoalEntity entity) {
    return GoalModel()
      ..id = entity.id
      ..title = entity.title
      ..description = entity.description
      ..colorValue = entity.colorValue
      ..startDate = entity.startDate
      ..targetDate = entity.targetDate
      ..milestones = entity.milestones.map((milestone) => 
        GoalMilestoneModel()
          ..title = milestone.title
          ..description = milestone.description
          ..isCompleted = milestone.isCompleted
          ..completedDate = milestone.completedDate,
      ).toList()
      ..categoryId = entity.categoryId
      ..isArchived = entity.isArchived;
  }
}