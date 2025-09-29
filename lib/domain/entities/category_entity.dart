// lib/domain/entities/category_entity.dart
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final int colorValue;
  final bool isVisible;
  final int sortOrder;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.isVisible,
    required this.sortOrder,
  });

  @override
  List<Object> get props => [
        id,
        name,
        colorValue,
        isVisible,
        sortOrder,
      ];

  CategoryEntity copyWith({
    int? id,
    String? name,
    int? colorValue,
    bool? isVisible,
    int? sortOrder,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      isVisible: isVisible ?? this.isVisible,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}