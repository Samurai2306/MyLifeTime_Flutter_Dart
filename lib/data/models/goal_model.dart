// lib/data/models/goal_model.dart
import 'package:isar/isar.dart';

part 'goal_model.g.dart';

@embedded
class GoalMilestone {
  late String title;
  String? description;
  bool isCompleted = false;
  DateTime? completedDate;
  
  GoalMilestone({
    required this.title,
    this.description,
    this.isCompleted = false,
    this.completedDate,
  });
}

@Collection()
class GoalModel {
  Id id = Isar.autoIncrement;
  
  late String title;
  String? description;
  int colorValue;
  
  @Index()
  late DateTime startDate;
  
  @Index()
  late DateTime targetDate;
  
  List<GoalMilestone> milestones = [];
  
  @Index()
  int? categoryId;
  
  bool isArchived = false;
  
  double get progress {
    if (milestones.isEmpty) return 0.0;
    final completed = milestones.where((m) => m.isCompleted).length;
    return completed / milestones.length;
  }
  
  bool get isCompleted => progress >= 1.0;
  
  int get daysRemaining {
    final now = DateTime.now();
    return targetDate.difference(now).inDays;
  }
}