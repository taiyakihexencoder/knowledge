import 'package:budgeting_app/ui/dashboard/models/dashboard_top_daily_element_model.dart';

/// ダッシュボードの中でその日のログリストを表示するためのデータモデル
class DashboardTopDailyListModel {
  const DashboardTopDailyListModel({
    required this.year,
    required this.month,
    required this.date,
    required this.logs,
  });

  /// 年
  final int year;
  /// 月
  final int month;
  /// 日
  final int date;
  /// その日の購入記録一覧
  final List<DashboardTopDailyElementModel> logs;
}