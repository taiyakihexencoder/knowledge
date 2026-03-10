/// 検索フィルタ・選択済の購入先リスト
class HistoryFilterShopSelectedListModel {
  const HistoryFilterShopSelectedListModel({
    required this.selectedList,
  });

  /// 選択済リスト
  final List<int> selectedList;
}