/// 検索フィルター用のタグのモデル
class HistoryFilterTagModel {
  const HistoryFilterTagModel({
    required this.id,
    required this.name,
  });

  /// タグID
  final int id;

  /// タグ名
  final String name;
}