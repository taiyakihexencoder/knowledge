import 'package:budgeting_app/ui/dashboard/models/dashboard_top_expense_log_model.dart';

/// カレンダー表示のためのデータモデル
/// 
/// year: 対象年
/// 
/// month: 対象月
/// 
/// prevMonthDates: 表示する前月の日付.
/// 日曜日から始まらない場合は前月の日付で埋めるため.
/// 
/// days: この月は何日まであるか
class DashboardTopMonthlyCalendarModel {
  const DashboardTopMonthlyCalendarModel({
    required this.year,
    required this.month,
    required this.prevMonthDates,
    required this.days,
    required this.expenseLog,
  });

  /// DateTime型から生成
  /// 
  /// dateTime: 必ず〇月1日を設定する
  DashboardTopMonthlyCalendarModel.fromDateTime({
    required DateTime dateTime,
    required List<DashboardTopExpenseLogModel> expenseLog,
  }): this(
    year: dateTime.year,
    month: dateTime.month,
    prevMonthDates: List.generate(
      dateTime.weekday % 7, 
      (index) {
        final int count = dateTime.weekday % 7;
        final int lastDay = dateTime.add(Duration(days: -1)).day;
        return lastDay - count + index + 1;
      }
    ),
    days: DateTime(dateTime.year, dateTime.month+1, 1).add(Duration(days: -1)).day,
    expenseLog: expenseLog,
  );

  /// 何年か（西暦）
  final int year;

  /// 何月か
  final int month;

  /// 前の月の表示分
  final List<int> prevMonthDates;

  /// この月は何日あるか
  final int days;

  /// 消費のログ
  final List<DashboardTopExpenseLogModel> expenseLog;
}