import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';
import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_history_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_daily_element_model.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_daily_list_model.dart';
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
    required ExpenseCategoryRepository expenseCategoryRepository,
    required ShopRepository shopRepository,
    required ExpenseTagRepository expenseTagRepository,
  }) : 
    _monthlyModel = ValueNotifier(null),
    _weeklyModel = ValueNotifier(null),
    _calendarMode = ValueNotifier(CalendarMode.weekly),
    _expenseHistoryRepository = expenseHistoryRepository,
    _expenseCategoryRepository = expenseCategoryRepository,
    _shopRepository = shopRepository,
    _expenseTagRepository = expenseTagRepository,
    _summary = ValueNotifier(null),
    _dailyModel = ValueNotifier(null) {

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

          if (model.defaultSelectedDate != null) {
            onSelectDateMonthly(model.defaultSelectedDate!);
          } else {
            _dailyModel.value = null;
          }
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

          if (model.defaultSelectedDate != null) {
            onSelectDateWeekly(model.defaultSelectedDate!);
          } else {
            _dailyModel.value = null;
          }
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
  final ExpenseCategoryRepository _expenseCategoryRepository;
  final ShopRepository _shopRepository;
  final ExpenseTagRepository _expenseTagRepository;

  final ValueNotifier<DashboardTopDailyListModel?> _dailyModel;
  /// 選択した日付のログ一覧
  ValueNotifier<DashboardTopDailyListModel?> get dailyModel => _dailyModel;
  
  final ValueNotifier<DashboardTopSummaryModel?> _summary;
  /// 集計情報
  ValueNotifier<DashboardTopSummaryModel?> get summary => _summary;

  void dispose() {
    _monthlyModel.dispose();
    _weeklyModel.dispose();
    _calendarMode.dispose();
    _summary.dispose();
    _dailyModel.dispose();
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
    _updateCalendarMonth(DateTime(now.year, now.month), defaultSelectedDate: now.day);
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
        _updateCalendarWeek(targetDateTime, defaultSelectedDate: now.day);
      }
    }
  }

  /// カレンダーデータを今の週に
  void setCalendarCurrentWeek() {
    DateTime now = DateTime.now();
    DateTime targetDateTime = now.add(Duration(days: -(now.weekday % 7)));
    _updateCalendarWeek(targetDateTime, defaultSelectedDate: now.day);
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

  /// ログを追加して戻ってきたときに、
  /// データを更新する
  void updateOnNewlog() {
    switch (_calendarMode.value) {
      case CalendarMode.monthly: {
        DashboardTopMonthlyCalendarModel? model = monthlyModel.value;
        if (model != null) {
          _updateCalendarMonth(
            DateTime(model.year, model.month, 1), 
            defaultSelectedDate: _dailyModel.value?.date ?? 1
          );
        }
      }
      case CalendarMode.weekly: {
        DashboardTopWeeklyCalendarModel? model = weeklyModel.value;
        if (model != null) {
          _updateCalendarWeek(
            DateTime(model.startYear, model.startMonth, model.startDate),
            defaultSelectedDate: _dailyModel.value?.date ?? model.startDate
          );
        }
      }
    }
  }

  /// 週間カレンダー表示の更新
  Future _updateCalendarWeek(DateTime targetDate, { int? defaultSelectedDate }) async {
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
        ).toList(),
      defaultSelectedDate: defaultSelectedDate,
    );
  }

  /// 月間カレンダー表示の更新
  Future _updateCalendarMonth(DateTime targetDate, { int? defaultSelectedDate }) async {
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
      defaultSelectedDate: defaultSelectedDate,
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

  /// セルが選択されたときの処理：Monthly
  void onSelectDateMonthly(int date) {
    final DashboardTopMonthlyCalendarModel? model = _monthlyModel.value;
    if (model != null) {
      _onSelectDate(
        year: model.year, 
        month: model.month, 
        date: date
      );
    }
  }

  /// セルが選択されたときの処理：Weekly
  void onSelectDateWeekly(int date) {
    final DashboardTopWeeklyCalendarModel? model = _weeklyModel.value;
    if (model != null) {
      _onSelectDate(
        year: model.startYear == model.endYear || date >= model.startDate ? model.startYear : model.endYear, 
        month: model.startMonth == model.endMonth || date >= model.startDate ? model.startMonth : model.endMonth, 
        date: date
      );
    }
  }

  /// セルが選択されたときにその日のデータを検索する
  void _onSelectDate({
    required int year,
    required int month,
    required int date,
  }) async {
    final String usedAt = '$year${month.toString().padLeft(2,'0')}${date.toString().padLeft(2,'0')}';
    List<ExpenseHistoryEntity> logList = await _expenseHistoryRepository.getHistoryList(minUsedAt:usedAt, maxUsedAt: usedAt);

    List<ExpenseCategoryEntity> categories = await _expenseCategoryRepository.getCategories(logList.map((log) => log.categoryId).toSet());
    List<ShopEntity> shops = await _shopRepository.getShops(logList.map((log) => log.shopId).toSet());
    Map<int, List<ExpenseHistoryTagEntity>> tags = await _expenseTagRepository.getTags(logList.map((log) => log.id));

    _dailyModel.value = DashboardTopDailyListModel(
      year: year, 
      month: month, 
      date: date, 
      logs: logList.map(
        (log) => DashboardTopDailyElementModel.from(
          expenseHistory: log,
          expenseCategory: categories.firstWhereOrNull((category) => category.id == log.categoryId),
          shop: shops.firstWhereOrNull((shop) => shop.id == log.shopId),
          expenseTags: tags[log.id] ?? [],
        )
      ).toList(),
    );
  }
}