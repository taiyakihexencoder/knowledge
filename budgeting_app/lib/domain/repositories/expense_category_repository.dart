import 'package:budgeting_app/data/services/expense_category_service.dart';
import 'package:budgeting_app/domain/entities/expense_category_entity.dart';

/// 消費カテゴリー情報Repository
class ExpenseCategoryRepository {
  
  const ExpenseCategoryRepository({
    required ExpenseCategoryService expenseCategoryService
  }): _expenseCategoryService = expenseCategoryService;

  final ExpenseCategoryService _expenseCategoryService;

  /// IDからカテゴリーを取得する
  ExpenseCategoryEntity getCategory(int categoryId) {
    String json = _expenseCategoryService.getCategory(categoryId);
    return ExpenseCategoryEntity.fromJson(json);
  }

  /// 登録済のすべてのカテゴリーをリストとして取得する
  List<ExpenseCategoryEntity> getAllCategoryList() {
    String json = _expenseCategoryService.getAllCategoryList();
    return ExpenseCategoryEntity.fromListJson(json);
  }
}