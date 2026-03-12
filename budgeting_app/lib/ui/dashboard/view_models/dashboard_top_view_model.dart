import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/domain/repositories/expense_history_repository.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_expense_log_model.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_monthly_calendar_model.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_summary_model.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_weekly_calendar_model.dart';
import 'package:budgeting_app/ui/dashboard/values/calendar_mode.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class DashboardTopViewModel {
  DashboardTopViewModel({
    required ExpenseHistoryRepository expenseHistoryRepository,
  }) : 
    _monthlyModel = ValueNotifier(null),
    _weeklyModel = ValueNotifier(null),
    _calendarMode = ValueNotifier(CalendarMode.weekly),
    _expenseHistoryRepository = expenseHistoryRepository,
    _summary = ValueNotifier(null) {

    // 日付が変化したらsummaryを更新する
    _monthlyModel.addListener(
      () {
        final DashboardTopMonthlyCalendarModel? model = _monthlyModel.value;
        if (model != null) {
          DateTime end = DateTime(model.year, model.month+1).add(Duration(days:-1));
          _fetchSummary(
            from: '${model.year}${model.month.toString().padLeft(2,'0')}01',
            to: '${end.year}${end.month.toString().padLeft(2,'0')}${end.day.toString().padLeft(2,'0')}',
          );
        }
      }
    );
    _weeklyModel.addListener(
      () {
        final DashboardTopWeeklyCalendarModel? model = _weeklyModel.value;
        if (model != null) {
          _fetchSummary(
            from: '${model.startYear}${model.startMonth.toString().padLeft(2,'0')}${model.startDate.toString().padLeft(2,'0')}', 
            to: '${model.endYear}${model.endMonth.toString().padLeft(2,'0')}${model.endDate.toString().padLeft(2,'0')}'
          );
        }
      }
    );
  }
  
  final ValueNotifier<DashboardTopMonthlyCalendarModel?> _monthlyModel; 
  /// 月カレンダーの情報
  ValueNotifier<DashboardTopMonthlyCalendarModel?> get monthlyModel => _monthlyModel;

  final ValueNotifier<DashboardTopWeeklyCalendarModel?> _weeklyModel;
  /// 週カレンダーの情報
  ValueNotifier<DashboardTopWeeklyCalendarModel?> get weeklyModel => _weeklyModel;

  final ValueNotifier<CalendarMode> _calendarMode;
  /// どちらのカレンダーを表示しているか
  ValueNotifier<CalendarMode> get calendarMode => _calendarMode;

  final ExpenseHistoryRepository _expenseHistoryRepository;

  final ValueNotifier<DashboardTopSummaryModel?> _summary;
  /// 集計情報
  ValueNotifier<DashboardTopSummaryModel?> get summary => _summary;

  void dispose() {
    _monthlyModel.dispose();
    _weeklyModel.dispose();
    _calendarMode.dispose();
    _summary.dispose();
  }

  /// カレンダーデータを1つ前の月に
  /// 
  /// 1970年1月まで
  void setCalendarPrevMonth() {
    DashboardTopMonthlyCalendarModel? model = _monthlyModel.value;
    if (model != null) {
      DateTime targetDateTime = DateTime(model.year, model.month-1);
      if (targetDateTime.millisecondsSinceEpoch >= 0) {
        _updateCalendarMonth(targetDateTime);
      }
    }
  }

  /// カレンダーデータを1つ先の月に
  /// 
  /// 現在から20年後の月まで
  void setCalendarNextMonth() {
    DashboardTopMonthlyCalendarModel? model = _monthlyModel.value;
    if (model != null) {
      DateTime targetDateTime = DateTime(model.year, model.month+1);
      DateTime now = DateTime.now();
      DateTime limit = now.copyWith(year: now.year + 20);
      if (limit.isAfter(targetDateTime)) {
        _updateCalendarMonth(targetDateTime);
      }
    }
  }

  /// カレンダーデータを今の月に
  void setCalendarCurrentMonth() {
    DateTime now = DateTime.now();
    _updateCalendarMonth(DateTime(now.year, now.month));
  }

  /// カレンダーデータを前の週に
  void setCalendarPrevWeek() {
    DashboardTopWeeklyCalendarModel? model = _weeklyModel.value;
    if (model != null) {
      DateTime targetDateTime = DateTime(model.startYear, model.startMonth, model.startDate - 7);
      if (targetDateTime.millisecondsSinceEpoch >= 0) {
        _updateCalendarWeek(targetDateTime);
      }
    }
  }

  /// カレンダーデータを次の週に
  void setCalendarNextWeek() {
    DashboardTopWeeklyCalendarModel? model = _weeklyModel.value;
    if (model != null) {
      DateTime targetDateTime = DateTime(model.startYear, model.startMonth, model.startDate + 7);
      DateTime now = DateTime.now();
      DateTime limit = now.copyWith(year: now.year + 20);
      if (limit.isAfter(targetDateTime)) {
        _updateCalendarWeek(targetDateTime);
      }
    }
  }

  /// カレンダーデータを今の週に
  void setCalendarCurrentWeek() {
    DateTime now = DateTime.now();
    DateTime targetDateTime = now.add(Duration(days: -(now.weekday % 7)));
    _updateCalendarWeek(targetDateTime);
  }

  /// カレンダーの切り替え
  void switchCalender() {
    if (_calendarMode.value == CalendarMode.monthly) {
      DashboardTopMonthlyCalendarModel? model = _monthlyModel.value;
      if (model == null) {
        setCalendarCurrentWeek();
      } else {
        _updateCalendarWeek(DateTime(model.year, model.month));
      }
      _calendarMode.value = CalendarMode.weekly;
    } else if (_calendarMode.value == CalendarMode.weekly) {
      DashboardTopWeeklyCalendarModel? model = _weeklyModel.value;
      if (model == null) {
        setCalendarCurrentMonth();
      } else {
        _updateCalendarMonth(DateTime(model.startYear, model.startMonth));
      }
      _calendarMode.value = CalendarMode.monthly;
    }
  }

  /// 週間カレンダー表示の更新
  Future _updateCalendarWeek(DateTime targetDate) async {
    final DateTime endDate = targetDate.copyWith(day: targetDate.day + 6);

    List<ExpenseHistoryEntity> historyList = await _expenseHistoryRepository.getHistoryList(
      minUsedAt: '${targetDate.year}${targetDate.month.toString().padLeft(2,'0')}${targetDate.day.toString().padLeft(2,'0')}',
      maxUsedAt: '${endDate.year}${endDate.month.toString().padLeft(2,'0')}${endDate.day.toString().padLeft(2,'0')}',
    );

    _weeklyModel.value = DashboardTopWeeklyCalendarModel.fromDateTime(
      dateTime: targetDate, 
      expenseLog: historyList
        .groupListsBy((record) => record.usedAt).entries.map(
          (entry) => DashboardTopExpenseLogModel(
            usedAt: entry.key, 
            logs: entry.value.map((record) => record.amount).toList(),
          )
        ).toList()
    );
  }

  /// 月間カレンダー表示の更新
  Future _updateCalendarMonth(DateTime targetDate) async {
    final DateTime endDate = DateTime(targetDate.year, targetDate.month+1, targetDate.day-1);
    List<ExpenseHistoryEntity> historyList = await _expenseHistoryRepository.getHistoryList(
      minUsedAt: '${targetDate.year}${targetDate.month.toString().padLeft(2,'0')}${targetDate.day.toString().padLeft(2,'0')}',
      maxUsedAt: '${endDate.year}${endDate.month.toString().padLeft(2,'0')}${endDate.day.toString().padLeft(2,'0')}',
    );

    _monthlyModel.value = DashboardTopMonthlyCalendarModel.fromDateTime(
      dateTime: targetDate,
      expenseLog: historyList
        .groupListsBy((record) => record.usedAt).entries.map(
          (entry) => DashboardTopExpenseLogModel(
            usedAt: entry.key, 
            logs: entry.value.map((record) => record.amount).toList(),
          )
        ).toList(),
    );
  }

  /// 集計情報を取得.
  /// 実運用では連続で呼び出されないように中断なりUIをブロックするなり対応した方がいいが、
  /// ここでは省略する
  /// 
  /// from: yyyyMMdd
  /// 
  /// to: yyyyMMdd
  Future _fetchSummary({
    required String from,
    required String to,
  }) async {
    _summary.value = null;

    final int amountSum = await _expenseHistoryRepository.getAmountSum(from: from, to: to);

    _summary.value = DashboardTopSummaryModel(
      amountSum: amountSum, 
      fromDate: from, 
      toDate: to,
    );
  }
}