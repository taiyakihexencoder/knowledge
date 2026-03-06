// 検索フィルタ用：金額の範囲
class HistoryFilterAmountModel {
  const HistoryFilterAmountModel({
    this.min = 0,
    this.max = 99999999, // 入力可能な最大値
  });

  /// 最小値
  final int min;

  /// 最大値
  final int max;
}