// lib/data/datasources/local/category_local_datasource.dart
import 'package:isar/isar.dart';
import 'package:mylifetime/data/models/category_model.dart';
import 'package:mylifetime/core/errors/exceptions.dart';

class CategoryLocalDataSource {
  final Isar isar;

  CategoryLocalDataSource(this.isar);

  Future<int> insertCategory(CalendarCategoryModel category) async {
    try {
      return await isar.writeTxn(() async {
        return await isar.calendarCategoryModels.put(category);
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to insert category: $e',
        stackTrace,
      );
    }
  }

  Future<List<CalendarCategoryModel>> getAllCategories() async {
    try {
      return await isar.calendarCategoryModels
          .where()
          .sortBySortOrder()
          .findAll();
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to get categories: $e',
        stackTrace,
      );
    }
  }

  Future<CalendarCategoryModel?> getCategoryById(int id) async {
    try {
      return await isar.calendarCategoryModels.get(id);
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to get category by id: $e',
        stackTrace,
      );
    }
  }

  Future<void> updateCategory(CalendarCategoryModel category) async {
    try {
      await isar.writeTxn(() async {
        await isar.calendarCategoryModels.put(category);
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to update category: $e',
        stackTrace,
      );
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.calendarCategoryModels.delete(id);
      });
    } catch (e, stackTrace) {
      throw DatabaseException(
        'Failed to delete category: $e',
        stackTrace,
      );
    }
  }
}