/// 購入履歴追加時のタグ選択肢モデル
class TagModel {
  const TagModel({
    required this.id,
    required this.name,
  });

  /// タグID
  final int id;

  /// タグ名
  final String name;
}