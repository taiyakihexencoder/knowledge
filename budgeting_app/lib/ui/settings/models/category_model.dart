/// 購入カテゴリー編集モデル
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