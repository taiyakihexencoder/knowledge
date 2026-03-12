import 'package:budgeting_app/ui/dashboard/models/dashboard_top_monthly_calendar_model.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_weekly_calendar_model.dart';
import 'package:budgeting_app/ui/dashboard/values/calendar_mode.dart';
import 'package:flutter/foundation.dart';

class DashboardTopViewModel {
  DashboardTopViewModel(
  ) : 
    _monthlyModel = ValueNotifier(null),
    _weeklyModel = ValueNotifier(null),
    _calendarMode = ValueNotifier(CalendarMode.weekly);
  
  final ValueNotifier<DashboardTopMonthlyCalendarModel?> _monthlyModel; 
  /// 月カレンダーの情報
  ValueNotifier<DashboardTopMonthlyCalendarModel?> get monthlyModel => _monthlyModel;

  final ValueNotifier<DashboardTopWeeklyCalendarModel?> _weeklyModel;
  /// 週カレンダーの情報
  ValueNotifier<DashboardTopWeeklyCalendarModel?> get weeklyModel => _weeklyModel;

  final ValueNotifier<CalendarMode> _calendarMode;
  /// どちらのカレンダーを表示しているか
  ValueNotifier<CalendarMode> get calendarMode => _calendarMode;

  void dispose() {
    _monthlyModel.dispose();
    _weeklyModel.dispose();
    _calendarMode.dispose();
  }

  /// カレンダーデータを1つ前の月に
  /// 
  /// 1970年1月まで
  void setCalendarPrevMonth() {
    DashboardTopMonthlyCalendarModel? model = _monthlyModel.value;
    if (model != null) {
      DateTime targetDateTime = DateTime(model.year, model.month-1);
      if (targetDateTime.millisecondsSinceEpoch >= 0) {
        _monthlyModel.value = DashboardTopMonthlyCalendarModel.fromDateTime(targetDateTime);
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
        _monthlyModel.value = DashboardTopMonthlyCalendarModel.fromDateTime(targetDateTime);
      }
    }
  }

  /// カレンダーデータを今の月に
  void setCalendarCurrentMonth() {
    _monthlyModel.value = DashboardTopMonthlyCalendarModel.fromDateTime(DateTime.now());
  }

  /// カレンダーデータを前の週に
  void setCalendarPrevWeek() {
    DashboardTopWeeklyCalendarModel? model = _weeklyModel.value;
    if (model != null) {
      DateTime targetDateTime = DateTime(model.startYear, model.startMonth, model.startDate - 7);
      if (targetDateTime.millisecondsSinceEpoch >= 0) {
        _weeklyModel.value = DashboardTopWeeklyCalendarModel.fromDateTime(targetDateTime);
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
        _weeklyModel.value = DashboardTopWeeklyCalendarModel.fromDateTime(targetDateTime);
      }
    }
  }

  /// カレンダーデータを今の週に
  void setCalendarCurrentWeek() {
    DateTime now = DateTime.now();
    DateTime targetDateTime = now.add(Duration(days: -(now.weekday % 7)));
    _weeklyModel.value = DashboardTopWeeklyCalendarModel.fromDateTime(targetDateTime);
  }

  /// カレンダーの切り替え
  void switchCalender() {
    if (_calendarMode.value == CalendarMode.monthly) {
      DashboardTopMonthlyCalendarModel? model = _monthlyModel.value;
      if (model == null) {
        setCalendarCurrentWeek();
      } else {
        _weeklyModel.value = DashboardTopWeeklyCalendarModel.fromDateTime(DateTime(model.year, model.month));
      }
      _calendarMode.value = CalendarMode.weekly;
    } else if (_calendarMode.value == CalendarMode.weekly) {
      DashboardTopWeeklyCalendarModel? model = _weeklyModel.value;
      if (model == null) {
        setCalendarCurrentMonth();
      } else {
        _monthlyModel.value = DashboardTopMonthlyCalendarModel.fromDateTime(DateTime(model.startYear, model.startMonth));
      }
      _calendarMode.value = CalendarMode.monthly;
    }
  }
}