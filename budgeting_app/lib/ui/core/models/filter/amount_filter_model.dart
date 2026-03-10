// 検索フィルタ用：金額の範囲
class AmountFilterModel {
  const AmountFilterModel({
    this.min = 0,
    this.max = 99999999, // 入力可能な最大値
    this.active = false,
  });

  /// 最小値
  final int min;

  /// 最大値
  final int max;

  /// 有効かどうか
  final bool active;
}