/// 購入履歴追加時の購入カテゴリー選択肢モデル
class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
  });

  /// カテゴリーID
  final int id;

  /// カテゴリー名
  final String name;
}