// domain/repositories/category_repository.dart
import 'package:dartz/dartz.dart';
import 'package:mylifetime/core/errors/failures.dart';
import 'package:mylifetime/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CalendarCategoryEntity>>> getCategories();
  Future<Either<Failure, int>> addCategory(CalendarCategoryEntity category);
  Future<Either<Failure, void>> updateCategory(CalendarCategoryEntity category);
  Future<Either<Failure, void>> deleteCategory(CalendarCategoryEntity category);
}