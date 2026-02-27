import 'package:budgeting_app/data/services/expense_category_service.dart';
import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/services/services.dart';

/// 消費カテゴリー情報Repository
class ExpenseCategoryRepository {
  
  const ExpenseCategoryRepository({
    required ExpenseCategoryService expenseCategoryService
  }): _expenseCategoryService = expenseCategoryService;

  final ExpenseCategoryService _expenseCategoryService;

  /// IDからカテゴリーを取得する
  Future<ExpenseCategoryEntity> getCategory(int categoryId) {
    return expenseCategoryService.getCategory(categoryId);
  }

  /// 登録済のすべてのカテゴリーをリストとして取得する
  Future<List<ExpenseCategoryEntity>> getAllCategoryList() {
    return _expenseCategoryService.getAllCategoryList();
  }
}