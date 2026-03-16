import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:budgeting_app/ui/core/widget/safe_area_padding.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_daily_list_model.dart';
import 'package:budgeting_app/ui/dashboard/values/calendar_mode.dart';
import 'package:budgeting_app/ui/dashboard/view_models/dashboard_top_view_model.dart';
import 'package:budgeting_app/ui/dashboard/widgets/dashboard_top/dashboard_top_daily_element.dart';
import 'package:budgeting_app/ui/dashboard/widgets/dashboard_top/dashboard_top_monthly_calendar.dart';
import 'package:budgeting_app/ui/dashboard/widgets/dashboard_top/dashboard_top_summary.dart';
import 'package:budgeting_app/ui/dashboard/widgets/dashboard_top/dashboard_top_weekly_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardTop extends StatelessWidget {
  const DashboardTop({
    super.key,
    required DashboardTopViewModel viewModel,
    required Future Function(BuildContext, { required int year, required int month, required int date }) onClickNewLog,
  }):
    _viewModel = viewModel,
    _onClickNewLog = onClickNewLog;

  final DashboardTopViewModel _viewModel;
  final Future Function(BuildContext, { required int year, required int month, required int date }) _onClickNewLog;

  void _updateScaffold() {
    mainFrameViewModel.hideTopBar();
    mainFrameViewModel.showNavigator();
    mainFrameViewModel.setFloatingActionButton();
  }

  @override
  Widget build(BuildContext context) {
    _updateScaffold();

    _viewModel.setCalendarCurrentMonth();
    _viewModel.setCalendarCurrentWeek();

    return Material(
      child: CustomScrollView(
        slivers: [
          SliverList.list(
            children:[
              SafeAreaPadding.top,
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
                              onClickCell: _viewModel.onSelectDateMonthly,
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
                              onClickCell: _viewModel.onSelectDateWeekly,
                            );
                          } else {
                            return Container();
                          }
                        }
                      );
                  }
                }
              ),

              ValueListenableBuilder(
                valueListenable: _viewModel.summary, 
                builder: (_, summary, _) {
                  if (summary != null) {
                    return DashboardTopSummary(
                      model: summary,
                    );
                  } else {
                    return Container();
                  }
                }
              ),
            ],
          ),

          ValueListenableBuilder(
            valueListenable: _viewModel.dailyModel, 
            builder: (_, logList, _) => logList == null ? SliverList.list(children: []) : SliverMainAxisGroup(
              slivers: [
                SliverFloatingHeader(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide()),
                    ),
                    padding: EdgeInsetsGeometry.only(left: 16.0, right: 16.0),
                    child:Text(
                      DateFormat(L10n.of(context)!.commonFullDateFormat).format(DateTime(logList.year, logList.month, logList.date))
                    ),
                  ),
                ),

                SliverList.list(
                  children: [
                    ...logList.logs.map(
                      (log) => Padding(
                        padding: EdgeInsetsGeometry.only(left: 24.0, right: 24.0),
                        child: DashboardTopDailyElement(model: log),
                      ),
                    ),

                    // ログが存在しない場合の表示
                    if (logList.logs.isEmpty)
                      Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(24.0, 16.0, 24.0, 16.0),
                        child: Text(L10n.of(context)!.dashboardTopDailyLogEmpty)
                      ),
                    
                    SizedBox(height: 20.0),

                    // 追加ボタン
                    Padding(
                      padding: EdgeInsetsGeometry.only(left:24.0, right:24.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          DashboardTopDailyListModel? model = _viewModel.dailyModel.value;
                          if (model != null) {
                            await _onClickNewLog(
                              context,
                              year: model.year,
                              month: model.month,
                              date: model.date,
                            );
                            _updateScaffold();
                          }
                        }, 
                        child: Text(
                          L10n.of(context)!.dashboardTopButtonNewLog,
                        )
                      ),
                    ),

                    SizedBox(height: 24.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
