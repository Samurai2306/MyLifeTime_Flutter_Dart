// lib/data/mappers/note_mapper.dart
import 'package:mylifetime/data/models/note_model.dart';
import 'package:mylifetime/domain/entities/note_entity.dart';

class NoteMapper {
  static NoteEntity toEntity(NoteModel model) {
    return NoteEntity(
      id: model.id,
      title: model.title,
      content: model.content,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      tags: model.tags,
      attachedFiles: model.attachedFiles,
      colorValue: model.colorValue,
      isPinned: model.isPinned,
      isArchived: model.isArchived,
    );
  }

  static NoteModel toModel(NoteEntity entity) {
    return NoteModel()
      ..id = entity.id
      ..title = entity.title
      ..content = entity.content
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt
      ..tags = entity.tags
      ..attachedFiles = entity.attachedFiles
      ..colorValue = entity.colorValue
      ..isPinned = entity.isPinned
      ..isArchived = entity.isArchived;
  }
}