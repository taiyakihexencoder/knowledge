import 'package:budgeting_app/data/services/expense_category_service.dart';
import 'package:budgeting_app/data/entities/expense_category_entity.dart';

/// 消費カテゴリー情報Repository
class ExpenseCategoryRepository {
  
  const ExpenseCategoryRepository({
    required ExpenseCategoryService expenseCategoryService
  }): _expenseCategoryService = expenseCategoryService;

  final ExpenseCategoryService _expenseCategoryService;

  /// IDからカテゴリーを取得する
  Future<ExpenseCategoryEntity?> getCategory(int categoryId) {
    return _expenseCategoryService.getCategory(categoryId);
  }

  /// 登録済のすべてのカテゴリーをリストとして取得する
  Future<List<ExpenseCategoryEntity>> getAllCategoryList() {
    return _expenseCategoryService.getAllCategoryList();
  }

  /// 購入カテゴリーを追加する
  /// 
  /// すでにあるものと重複している場合は追加できずfalse, 
  /// それ以外はtrue
  Future<bool> addCategory({
    required String name,
  }) {
    return _expenseCategoryService.addCategory(name: name);
  }

  /// 購入カテゴリーを上書きする
  /// 
  /// すでにあるものと重複している場合は追加できずfalse, 
  /// それ以外はtrue
  Future<bool> updateCategory({
    required int id,
    required String name,
  }) {
    return _expenseCategoryService.updateCategoryName(id: id, name: name);
  }

  /// 購入カテゴリーを削除する
  Future<void> deleteCategory({
    required int id,
  }) {
    return _expenseCategoryService.deleteCategory(id: id);
  }
}