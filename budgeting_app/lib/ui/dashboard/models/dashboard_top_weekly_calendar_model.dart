import 'package:budgeting_app/ui/dashboard/models/dashboard_top_expense_log_model.dart';

/// 週間カレンダー表示モデル
/// 
/// 開始年月日と終了年月日さえわかれば、
/// DateTimeを介さずとも月末日付を判定可能
class DashboardTopWeeklyCalendarModel {
  const DashboardTopWeeklyCalendarModel({
    required this.startYear,
    required this.startMonth,
    required this.startDate,
    required this.endYear,
    required this.endMonth,
    required this.endDate,
    required this.expenseLog,
    this.defaultSelectedDate,
  });

  /// 注意：dateTimeは日曜日想定
  DashboardTopWeeklyCalendarModel.fromDateTime({
    required DateTime dateTime,
    required List<DashboardTopExpenseLogModel> expenseLog,
    int? defaultSelectedDate,
  }) : this(
    startYear: dateTime.year,
    startMonth: dateTime.month,
    startDate: dateTime.day,
    endYear: dateTime.add(Duration(days: 7)).year,
    endMonth: dateTime.add(Duration(days: 7)).month,
    endDate: dateTime.add(Duration(days: 7)).day,
    expenseLog: expenseLog,
    defaultSelectedDate: defaultSelectedDate,
  );

  /// 開始年
  final int startYear;
  /// 開始月
  final int startMonth;
  /// 開始日付
  final int startDate;
  /// 終了年
  final int endYear;
  /// 終了月
  final int endMonth;
  /// 終了日付
  final int endDate;

  /// 消費のログ
  final List<DashboardTopExpenseLogModel> expenseLog;

  // あらかじめ選択されている日付
  final int? defaultSelectedDate;
}