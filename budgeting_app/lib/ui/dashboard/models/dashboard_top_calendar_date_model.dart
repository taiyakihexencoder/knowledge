class DashboardTopCalendarDateModel {
  const DashboardTopCalendarDateModel({
    required this.logList,
  });
  
  final List<DashboardTopCalendarDateExpenseModel> logList;
}

class DashboardTopCalendarDateExpenseModel {
  const DashboardTopCalendarDateExpenseModel({
    required this.amount,
    required this.category,
    required this.shop,
    required this.tags,
  });

  /// 購入金額
  final int amount;
  /// カテゴリー
  final String category;
  /// 店舗
  final String shop;
  /// タグ
  final List<String> tags;
}