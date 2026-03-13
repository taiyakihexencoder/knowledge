import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_listenable_provider.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_expense_log_model.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_weekly_calendar_model.dart';
import 'package:budgeting_app/ui/dashboard/values/date_type.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:intl/intl.dart';

/// ウィークリーカレンダー
/// 表示内容の都合で横倒しになっている
class DashboardTopWeeklyCalendar extends StatefulWidget {
  DashboardTopWeeklyCalendar({
    super.key,
    required DashboardTopWeeklyCalendarModel model,
    required Function() onClickPrevWeek,
    required Function() onClickNextWeek,
    required Function() onClickToday,
    required Function() onClickSwitch,
    required Function(int) onClickCell,
  }): 
    _model = model,
    _onClickPrevWeek = onClickPrevWeek,
    _onClickNextWeek = onClickNextWeek,
    _onClickToday = onClickToday,
    _onClickSwitch = onClickSwitch,
    _onClickCell = onClickCell,
    _dateList = List.generate(
      7, 
      (index) {
        // 月替わりの日付算出
        if(model.endDate < 7) {
          final int offset = model.endDate + index - 6;
          return offset > 0 ? offset : model.startDate + index;
        } else {
          return model.startDate + index;
        }
      }
    ),
    _notifiers = List.generate(7, 
      (index) {
        if(model.endDate < 7) {
          final int offset = model.endDate + index - 6;
          final int date = offset > 0 ? offset : model.startDate + index;
          return ValueNotifier(date == model.defaultSelectedDate);
        } else {
          final int date = model.startDate + index;
          return ValueNotifier(date == model.defaultSelectedDate);
        }
      }
    );

  final DashboardTopWeeklyCalendarModel _model;
  final Function() _onClickPrevWeek;
  final Function() _onClickNextWeek;
  final Function() _onClickToday;
  final Function() _onClickSwitch;
  final Function(int) _onClickCell;

  final List<int> _dateList;
  final List<ValueNotifier<bool>> _notifiers;

  @override
  DashboardTopWeeklyCalendarState createState() {
    return DashboardTopWeeklyCalendarState();
  }
}

class DashboardTopWeeklyCalendarState extends State<DashboardTopWeeklyCalendar> {
  @override
  void dispose() {
    for(ValueNotifier<bool> notifier in widget._notifiers) {
      notifier.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat yearMonthFormat = DateFormat('yyyy MMMM');
    final DateTime yearMonth = DateTime(widget._model.startYear, widget._model.startMonth);
    // 日曜日の日付から第何週かを求める
    final int weekNo = ((widget._model.startDate+5) / 7).toInt() + 1;

    final List<String> dows = [
      L10n.of(context)!.commonAbbrSunDay,
      L10n.of(context)!.commonAbbrMonDay,
      L10n.of(context)!.commonAbbrTuesDay,
      L10n.of(context)!.commonAbbrWednesDay,
      L10n.of(context)!.commonAbbrThursDay,
      L10n.of(context)!.commonAbbrFriDay,
      L10n.of(context)!.commonAbbrSaturDay,
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(), 
            IconButton(
              onPressed: widget._onClickPrevWeek,
              icon: Icon(Icons.keyboard_arrow_left),
            ),
            SizedBox(width: 16.0),

            Text(
              '${yearMonthFormat.format(yearMonth)} ${L10n.of(context)!.dashboardTopWeekNo(weekNo)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            SizedBox(width: 16.0),

            IconButton.filled(
              constraints: BoxConstraints(),
              iconSize: 16.0,
              onPressed: widget._onClickToday, 
              icon: Icon(Icons.today),
            ),

            SizedBox(width: 8.0),
            IconButton(
              onPressed: widget._onClickNextWeek,
              icon: Icon(Icons.keyboard_arrow_right),
            ),
            
            Spacer(),

            IconButton.filled(
              constraints: BoxConstraints(),
              iconSize: 16.0,
              onPressed: widget._onClickSwitch,
              icon: Icon(Icons.calendar_month),
            ),
          ],
        ),

        ...widget._dateList.mapIndexed(
          // 一番上の場合：年月日を表示
          // それ以外：年・月は変わる（日付が１）場合のみ表示
          (index, date) => _DashboardTopWeeklyCalendarCell(
            dateType: _calcDateType(index),
            dow: dows[index],
            year: index == 0 
              ? widget._model.startYear 
              : date == 1 && widget._model.startYear != widget._model.endYear ? widget._model.endYear : null, 
            month: index == 0 
              ? widget._model.startMonth 
              : date == 1 ? widget._model.endMonth : null, 
            date: date,
            selected: widget._notifiers[index],
            onClick: _onSelect,
            builder: getBuilder(index, date),
          ),
        ),
      ],
    );
  }

  /// 日付タイプの取得
  /// 
  /// 複雑になるので一旦祝日は想定しない
  DateType _calcDateType(int offset) {
    return offset == 0 ? DateType.red : (offset == 6) ? DateType.blue : DateType.normal;
  }

  /// タップ時に日付の選択状態を切り替える
  void _onSelect(int date) {
    widget._onClickCell(date);
    for (int i = 0; i < 7; ++i) {
      if (widget._notifiers[i].value != (date == widget._dateList[i])) {
        widget._notifiers[i].value = date == widget._dateList[i];
      }
    }
  }

  Widget Function(BuildContext)? getBuilder(int offset, int date) {
    final DateType dateType = _calcDateType(offset);
    final datePattern = date.toString().padLeft(2, '0');
    final DashboardTopExpenseLogModel? model = widget._model.expenseLog.firstWhereOrNull((log) => log.usedAt.endsWith(datePattern));
    return model == null ? null : (_) => _DashboardWeeklyContents(model: model, dateType: dateType);
  }
}

/// 表の中身
class _DashboardWeeklyContents extends StatelessWidget {
  const _DashboardWeeklyContents({
    required DashboardTopExpenseLogModel model,
    required DateType dateType,
  }): 
    _model = model,
    _dateType = dateType;

  final DashboardTopExpenseLogModel _model;
  final DateType _dateType;

  @override
  Widget build(BuildContext context) {
    final Color logColor = Color.from(red:0.75, green: 0.75, blue: 0.75, alpha: 0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 2.0, right: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            border: Border.all(color:_dateType.fgColor),
          ),
          child: Text(
            L10n.of(context)!.dashboardTopWeeklyLogCount(_model.logs.length),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: _dateType.fgColor),
          ),
        ),
        SizedBox(height: 4.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 2.0,
          children: [
            ..._model.logs.map(
              (log) => Container(
                padding: EdgeInsets.only(left:4.0, right:4.0,),
                decoration: ShapeDecoration(
                  shape: StadiumBorder(side: BorderSide()),
                  color: logColor,
                ),
                child: Text(
                  L10n.of(context)!.commonPrice(log),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ),
          ]
        ),
      ],
    );
  }
}

/// 個別の日付
class _DashboardTopWeeklyCalendarCell extends StatelessWidget {
  const _DashboardTopWeeklyCalendarCell({
    required DateType dateType,
    required String dow,
    required int? year,
    required int? month,
    required int date,
    required ValueListenable<bool> selected,
    required Function(int) onClick,
    Widget Function(BuildContext)? builder,
  }):
    _dateType = dateType,
    _dow = dow,
    _year = year,
    _month = month,
    _date = date,
    _selected = selected,
    _onClick = onClick,
    _builder = builder;

  /// 日付のデザイン
  final DateType _dateType;
  /// 曜日テキスト(Day of Week)
  final String _dow;
  /// 年
  final int? _year;
  /// 月
  final int? _month;
  /// 日付
  final int _date;
  /// 内部のコンテンツ描画
  final Widget Function(BuildContext)? _builder;

  final ValueListenable<bool> _selected;
  final Function(int) _onClick;

  @override
  Widget build(BuildContext context) {
    final String dateExpression = _year == null
      ? _month == null 
        ? _date.toString()
        : L10n.of(context)!.commonMonthDate(_date, _month)
      : L10n.of(context)!.commonYearMonthDate(_date, _month!, _year);

    final textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(color: _dateType.fgColor);

    return ValueListenableBuilder(
      valueListenable: _selected,
      builder: (context, selected, _) => Material(
        child: InkWell(
          onTap: () { _onClick(_date); },
          child: Container(
            width: double.infinity,
            height: 100.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? Colors.green : Colors.black,
                width: selected ? 3.0 : 1.0,
              ),
              color: _dateType.bgColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    left: selected ? 2.0 : 4.0,
                  ),
                  child: Text(
                    _dow,
                    style: textStyle,
                  ),
                ),

                VerticalDivider(
                  color: _dateType.fgColor,
                  thickness: 1.0,
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(
                      right: selected ? 2.0 : 4.0,
                      top: selected ? 2.0 : 4.0,
                      bottom: selected ? 2.0 : 4.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dateExpression,
                          style: textStyle,
                        ),

                        if (_builder != null)
                          _builder(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@Preview(
  name: 'Weekly Calendar (New Year)',
  wrapper: previewWrapper,
)
Widget previewWeeklyCalendarNewYear() {
  return DashboardTopWeeklyCalendar(
    model: DashboardTopWeeklyCalendarModel(
      startYear: 2025, 
      startMonth: 12, 
      startDate: 28, 
      endYear: 2026, 
      endMonth: 1, 
      endDate: 3,
      expenseLog: [
        DashboardTopExpenseLogModel(
          usedAt: '20261228', 
          logs: [1000, 2000, 3000,1000, 2000, 3000,1000, 2000, 3000,],
        ),
        DashboardTopExpenseLogModel(
          usedAt: '20251231', 
          logs: [10000],
        ),
      ]
    ),
    onClickPrevWeek: (){},
    onClickNextWeek: (){},
    onClickToday: (){},
    onClickSwitch: (){},
    onClickCell: (_){},
  );
}

@Preview(
  name: 'Weekly Calendar (New Month)',
  wrapper: previewWrapper,
)
Widget previewWeeklyCalendarNewMonth() {
  return DashboardTopWeeklyCalendar(
    model: DashboardTopWeeklyCalendarModel(
      startYear: 2026, 
      startMonth: 3, 
      startDate: 29, 
      endYear: 2026,
      endMonth: 4, 
      endDate: 4,
      expenseLog: [],
    ),
    onClickPrevWeek: (){},
    onClickNextWeek: (){},
    onClickToday: (){},
    onClickSwitch: (){},
    onClickCell: (_){},
  );
}

@Preview(
  name: 'Weekly Calendar',
  wrapper: previewWrapper,
)
Widget previewWeeklyCalendar() {
  return DashboardTopWeeklyCalendar(
    model: DashboardTopWeeklyCalendarModel(
      startYear: 2026, 
      startMonth: 1, 
      startDate: 4, 
      endYear: 2026,
      endMonth: 1, 
      endDate: 10,
      expenseLog: [
        DashboardTopExpenseLogModel(
          usedAt: '20261228', 
          logs: [1000, 2000, 3000],
        ),
      ]
    ),
    onClickPrevWeek: (){},
    onClickNextWeek: (){},
    onClickToday: (){},
    onClickSwitch: (){},
    onClickCell: (_){},
  );
}

@Preview(
  name: 'Cell',
  wrapper: previewWrapper,
)
Widget previewCalendarCell() {
  return PreviewListenableProvider(
    builder: (notifier) => _DashboardTopWeeklyCalendarCell(
      dateType: DateType.red, 
      dow: 'Sun',
      year: 2026, 
      month: 2, 
      date: 29,
      selected: notifier,
      onClick: (_){},
    ), 
    value: true,
  );
}