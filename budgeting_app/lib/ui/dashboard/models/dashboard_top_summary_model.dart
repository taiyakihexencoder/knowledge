/// ダッシュボード集計情報のデータモデル
class DashboardTopSummaryModel {
  DashboardTopSummaryModel({
    required this.amountSum,
    required this.fromDate,
    required this.toDate,
  });

  /// 期間内の総額
  final int amountSum;

  /// 期間開始（含）
  final String fromDate;

  /// 期間終了（含）
  final String toDate;
}