import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/services/expense_category_service.dart';

/// 消費カテゴリーのデータソース
class MockExpenseCategoryService implements ExpenseCategoryService {
  const MockExpenseCategoryService();

  @override
  Future<ExpenseCategoryEntity> getCategory(int categoryId) {
    return Future.value(ExpenseCategoryEntity.fromJson(_mockCategory(categoryId)));
  }

  String _mockCategory(int categoryId) {
    return switch (categoryId){
      1 => '{"id": 1, "name": "食費"}',
      2 => '{"id": 2, "name": "水道光熱費"}',
      3 => '{"id": 3, "name": "その他サービス費"}',
      4 => '{"id": 4, "name": "交通費"}',
      _ => '{"id": 0, "name": "Unknown"}',
    };
  }

  @override
  Future<List<ExpenseCategoryEntity>> getAllCategoryList() {
    return Future.value(ExpenseCategoryEntity.fromListJson(_mockAllCategoryList()));
  }

  String _mockAllCategoryList() {
    return '''
[
  {"id": 1, "name": "食費"},
  {"id": 2, "name": "水道光熱費"},
  {"id": 3, "name": "その他サービス費"},
  {"id": 4, "name": "交通費"}
]
''';
  }

  @override
  Future<bool> addCategory({
    required String name,
  }) {
    return Future.value(true);
  }

  @override
  Future<bool> updateCategoryName({
    required int id,
    required String name
  }) {
    return Future.value(true);
  }

  @override
  Future<void> deleteCategory({
    required int id,
  }) {
    return Future.value();
  }
}