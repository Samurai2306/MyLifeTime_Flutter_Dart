// data/datasources/local/isar_database.dart
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [EventModelSchema, CalendarCategoryModelSchema],
      directory: dir.path,
    );
  }

  static Future<void> close() async {
    await isar.close();
  }
}