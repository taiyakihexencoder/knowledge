/// 消費カテゴリーのデータソース
class ExpenseCategoryService {
  const ExpenseCategoryService();

  String getCategory(int categoryId) {
    return switch (categoryId){
      1 => '{"id": 1, "name": "食費"}',
      2 => '{"id": 2, "name": "水道光熱費"}',
      3 => '{"id": 3, "name": "その他サービス費"}',
      4 => '{"id": 4, "name": "交通費"}',
      _ => '{"id": 0, "name": "Unknown"}',
    };
  }

  String getAllCategoryList() {
    return '''
[
  {"id": 1, "name": "食費"},
  {"id": 2, "name": "水道光熱費"},
  {"id": 3, "name": "その他サービス費"},
  {"id": 4, "name": "交通費"}
]
''';
  }
}