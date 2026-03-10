/// 検索フィルター用購入先モデル
class HistoryFilterShopListModel {
  const HistoryFilterShopListModel({
    required this.shopList,
    this.active = false,
  });

  /// 選択要素リスト
  final List<HistoryFilterShopModel> shopList;

  /// 有効かどうか
  final bool active;
}

/// 個別の要素
class HistoryFilterShopModel {
  const HistoryFilterShopModel({
    required this.id,
    required this.name,
  });

  /// ID
  final int id;

  /// 購入先名称
  final String name;
}