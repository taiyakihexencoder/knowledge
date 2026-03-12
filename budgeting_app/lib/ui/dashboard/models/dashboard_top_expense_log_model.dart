/// 日ごとの消費情報モデル
class DashboardTopExpenseLogModel {
  const DashboardTopExpenseLogModel({
    required this.usedAt,
    required this.logs,
  });

  /// 日付
  final String usedAt;

  /// 消費リスト
  /// 
  /// 月ごとでは合計を、週ごとではリストを表示する
  final List<int> logs;
}