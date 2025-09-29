// lib/domain/entities/note_entity.dart
import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int id;
  final String title;
  final String? content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final List<String> attachedFiles;
  final int colorValue;
  final bool isPinned;
  final bool isArchived;

  const NoteEntity({
    required this.id,
    required this.title,
    this.content,
    required this.createdAt,
    required this.updatedAt,
    this.tags = const [],
    this.attachedFiles = const [],
    required this.colorValue,
    this.isPinned = false,
    this.isArchived = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        createdAt,
        updatedAt,
        tags,
        attachedFiles,
        colorValue,
        isPinned,
        isArchived,
      ];

  NoteEntity copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    List<String>? attachedFiles,
    int? colorValue,
    bool? isPinned,
    bool? isArchived,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      attachedFiles: attachedFiles ?? this.attachedFiles,
      colorValue: colorValue ?? this.colorValue,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}