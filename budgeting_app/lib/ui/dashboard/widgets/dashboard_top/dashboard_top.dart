import 'package:budgeting_app/ui/core/widget/budgeting_app_bottom_navigation.dart';
import 'package:budgeting_app/ui/dashboard/values/calendar_mode.dart';
import 'package:budgeting_app/ui/dashboard/view_models/dashboard_top_view_model.dart';
import 'package:budgeting_app/ui/dashboard/widgets/dashboard_top/dashboard_top_monthly_calendar.dart';
import 'package:budgeting_app/ui/dashboard/widgets/dashboard_top/dashboard_top_weekly_calendar.dart';
import 'package:flutter/material.dart';

class DashboardTop extends StatelessWidget {
  const DashboardTop({
    super.key,
    required DashboardTopViewModel viewModel,
  }):
    _viewModel = viewModel;

  final DashboardTopViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel.setCalendarCurrentMonth();
    _viewModel.setCalendarCurrentWeek();

    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _viewModel.calendarMode, 
              builder: (_, mode, _) {
                switch (mode) {
                  case CalendarMode.monthly: // 月間カレンダー
                    return ValueListenableBuilder(
                      valueListenable: _viewModel.monthlyModel, 
                      builder: (_, calendar, _) {
                        if (calendar != null) {
                          return DashboardTopMonthlyCalendar(
                            model: calendar, 
                            onClickPrevMonth: _viewModel.setCalendarPrevMonth, 
                            onClickNextMonth: _viewModel.setCalendarNextMonth,
                            onClickToday: _viewModel.setCalendarCurrentMonth,
                            onClickSwitch: _viewModel.switchCalender,
                          );
                        } else {
                          return Container();
                        }
                      }
                    );
                  case CalendarMode.weekly: // 週間カレンダー
                    return ValueListenableBuilder(
                      valueListenable: _viewModel.weeklyModel, 
                      builder: (_, calendar, _) {
                        if (calendar != null) {
                          return DashboardTopWeeklyCalendar(
                            model: calendar, 
                            onClickPrevWeek: _viewModel.setCalendarPrevWeek, 
                            onClickNextWeek: _viewModel.setCalendarNextWeek, 
                            onClickToday: _viewModel.setCalendarCurrentWeek,
                            onClickSwitch: _viewModel.switchCalender,
                          );
                        } else {
                          return Container();
                        }
                      }
                    );
                }
              }
            )
          ],
        ),
      ),
    );
  }
}
