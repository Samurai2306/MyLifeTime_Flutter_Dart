// lib/data/models/note_model.dart
import 'package:isar/isar.dart';

part 'note_model.g.dart';

@Collection()
class NoteModel {
  Id id = Isar.autoIncrement;
  
  late String title;
  String? content;
  
  @Index()
  late DateTime createdAt;
  
  @Index()
  late DateTime updatedAt;
  
  List<String> tags = [];
  List<String> attachedFiles = []; // Пути к файлам
  
  int colorValue;
  bool isPinned = false;
  bool isArchived = false;
  
  NoteModel({
    required this.title,
    this.content,
    required this.colorValue,
  }) {
    final now = DateTime.now();
    createdAt = now;
    updatedAt = now;
  }
}