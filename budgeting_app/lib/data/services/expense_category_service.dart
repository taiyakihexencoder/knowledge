import 'package:budgeting_app/data/entities/expense_category_entity.dart';

abstract interface class ExpenseCategoryService {
  Future<ExpenseCategoryEntity> getCategory(int categoryId);
  Future<List<ExpenseCategoryEntity>> getAllCategoryList();
}