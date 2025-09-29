// lib/domain/entities/goal_entity.dart
import 'package:equatable/equatable.dart';

class GoalMilestone extends Equatable {
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime? completedDate;

  const GoalMilestone({
    required this.title,
    this.description,
    this.isCompleted = false,
    this.completedDate,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        isCompleted,
        completedDate,
      ];

  GoalMilestone copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? completedDate,
  }) {
    return GoalMilestone(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      completedDate: completedDate ?? this.completedDate,
    );
  }
}

class GoalEntity extends Equatable {
  final int id;
  final String title;
  final String? description;
  final int colorValue;
  final DateTime startDate;
  final DateTime targetDate;
  final List<GoalMilestone> milestones;
  final int? categoryId;
  final bool isArchived;

  const GoalEntity({
    required this.id,
    required this.title,
    this.description,
    required this.colorValue,
    required this.startDate,
    required this.targetDate,
    this.milestones = const [],
    this.categoryId,
    this.isArchived = false,
  });

  int get completedMilestones => milestones.where((m) => m.isCompleted).length;
  int get totalMilestones => milestones.length;
  double get progress => totalMilestones > 0 ? completedMilestones / totalMilestones : 0.0;
  bool get isCompleted => progress >= 1.0;
  int get daysRemaining => targetDate.difference(DateTime.now()).inDays;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        colorValue,
        startDate,
        targetDate,
        milestones,
        categoryId,
        isArchived,
      ];

  GoalEntity copyWith({
    int? id,
    String? title,
    String? description,
    int? colorValue,
    DateTime? startDate,
    DateTime? targetDate,
    List<GoalMilestone>? milestones,
    int? categoryId,
    bool? isArchived,
  }) {
    return GoalEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      colorValue: colorValue ?? this.colorValue,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      milestones: milestones ?? this.milestones,
      categoryId: categoryId ?? this.categoryId,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}