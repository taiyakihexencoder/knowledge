import 'package:budgeting_app/data/entities/expense_category_entity.dart';

abstract interface class ExpenseCategoryService {
  Future<ExpenseCategoryEntity> getCategory(int categoryId);
  Future<List<ExpenseCategoryEntity>> getAllCategoryList();

  /// 購入カテゴリーの追加
  /// 
  /// 他と重複する名称になる場合はfalse
  Future<bool> addCategory({
    required String name,
  });

  /// 購入カテゴリーの名称変更
  /// 
  /// 他と重複する名称になる場合はfalse
  Future<bool> updateCategoryName({
    required int id,
    required String name,
  });

  /// 購入カテゴリーの削除
  Future<void> deleteCategory({
    required int id,
  });
}