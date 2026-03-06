/// 検索フィルター用のカテゴリーモデル
class HistoryFilterCategoryModel {
  const HistoryFilterCategoryModel({
    required this.id,
    required this.name,
  });

  /// カテゴリーID
  final int id;

  /// カテゴリー名
  final String name;
}