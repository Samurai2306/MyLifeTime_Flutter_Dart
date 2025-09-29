// domain/entities/category_entity.dart
import 'package:equatable/equatable.dart';

class CalendarCategoryEntity extends Equatable {
  final int id;
  final String name;
  final int colorValue;
  final bool isVisible;
  final int sortOrder;

  const CalendarCategoryEntity({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.isVisible,
    required this.sortOrder,
  });

  @override
  List<Object> get props => [id, name, colorValue, isVisible, sortOrder];
}