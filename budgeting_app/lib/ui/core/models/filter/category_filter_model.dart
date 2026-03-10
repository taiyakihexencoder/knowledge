/// 検索フィルタ・選択済のカテゴリーリスト
class CategoryFilterModel {
  const CategoryFilterModel({
    required this.selectedList,
    this.active = false,
  });

  /// 選択済リスト
  final List<int> selectedList;

  /// 有効かどうか
  final bool active;
}