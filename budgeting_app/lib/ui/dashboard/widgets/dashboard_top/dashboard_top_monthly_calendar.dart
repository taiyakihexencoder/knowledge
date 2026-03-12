import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_listenable_provider.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_monthly_calendar_model.dart';
import 'package:budgeting_app/ui/dashboard/values/date_type.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:intl/intl.dart';

/// 月カレンダー表示
class DashboardTopMonthlyCalendar extends StatefulWidget {
  DashboardTopMonthlyCalendar({
    super.key,
    required DashboardTopMonthlyCalendarModel model,
    required Function() onClickPrevMonth,
    required Function() onClickNextMonth,
    required Function() onClickToday,
    required Function() onClickSwitch,
  }):
    _model = model,
    _onClickPrevMonth = onClickPrevMonth,
    _onClickNextMonth = onClickNextMonth,
    _onClickToday = onClickToday,
    _onClickSwitch = onClickSwitch,
    _notifiers = List.generate(model.days, (_) => ValueNotifier(false));

  /// データモデル
  final DashboardTopMonthlyCalendarModel _model;

  /// 前の月に移動
  final Function() _onClickPrevMonth;
  /// 次の月に移動
  final Function() _onClickNextMonth;
  /// 現在の日付に移動
  final Function() _onClickToday;
  /// 画面切り替え
  final Function() _onClickSwitch;

  /// 各セルの選択状態を管理
  final List<ValueNotifier<bool>> _notifiers;

  @override
  DashboardTopMonthlyCalendarState createState() {
    return DashboardTopMonthlyCalendarState();
  }
}

class DashboardTopMonthlyCalendarState extends State<DashboardTopMonthlyCalendar> {
  @override
  void dispose() {
    for (ValueNotifier notifier in widget._notifiers) {
      notifier.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int nextMonthDate = (7 - (widget._model.days + widget._model.prevMonthDates.length) % 7) % 7;
    final List<String> dows = [
      L10n.of(context)!.commonAbbrSunDay,
      L10n.of(context)!.commonAbbrMonDay,
      L10n.of(context)!.commonAbbrTuesDay,
      L10n.of(context)!.commonAbbrWednesDay,
      L10n.of(context)!.commonAbbrThursDay,
      L10n.of(context)!.commonAbbrFriDay,
      L10n.of(context)!.commonAbbrSaturDay,
    ];

    final DateFormat yearMonthFormat = DateFormat('yyyy MMMM');
    final DateTime yearMonth = DateTime(widget._model.year, widget._model.month);
    final prevDays = widget._model.prevMonthDates.length;

    return Column(
      children:[
        // 年月表示・ボタン部分
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            IconButton(
              onPressed: widget._onClickPrevMonth,
              icon: Icon(Icons.keyboard_arrow_left),
            ),
            SizedBox(width: 16.0),

            Text(
              yearMonthFormat.format(yearMonth),
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
              onPressed: widget._onClickNextMonth,
              icon: Icon(Icons.keyboard_arrow_right),
            ),

            Spacer(),

            IconButton.filled(
              constraints: BoxConstraints(),
              iconSize: 16.0,
              onPressed: widget._onClickSwitch,
              icon: Icon(Icons.view_list),
            ),
          ],
        ),

        // 曜日ヘッダー
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 7,
          shrinkWrap: true,
          childAspectRatio: 1.6,
          children: [
            ...dows.mapIndexed(
              (index, dow) => _DashboardTopCalendarMonthlyHeaderCell(
                text: dow,
                dateType: _calcDateType(index),
              ),
            )
          ],
        ),

        // 日付
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 7,
          childAspectRatio: 0.75,
          shrinkWrap: true,
          children: [
            // 前月表示
            ... widget._model.prevMonthDates.mapIndexed(
              (index, date) =>  _DashboardTopMonthlyCalendarCellLayout(
                date: date, 
                dateType: _calcDateType(index),
                selected: false, 
                isCurrentMonth: false,
              ),
            ),             
            
            // 今月表示
            for (int date = 1; date <= widget._model.days; ++date)
              _DashboardTopMonthlyCalendarCell(
                date: date, 
                dateType: _calcDateType(date + prevDays-1),
                selected: widget._notifiers[date-1],
                onClick: _onClickCell,
              ),
            
            // 来月表示
            for (int date = 1; date <= nextMonthDate; ++date)
              _DashboardTopMonthlyCalendarCellLayout(
                date: date, 
                dateType: _calcDateType(date + prevDays + widget._model.days-1),
                selected: false, 
                isCurrentMonth: false,
              ),
          ],
        ),
      ],
    );
  }

  /// セルをタップしたらそのセルを選択状態にして、
  /// 他の選択状態のセルを選択解除する
  void _onClickCell(int date) {
    for (int i = 1; i <= widget._model.days; ++i) {
      if ( widget._notifiers[i-1].value != (i == date) ) {
        widget._notifiers[i-1].value = (i == date);
      }
    }
  }

  /// 日付タイプの取得
  /// 
  /// 複雑になるので一旦祝日は想定しない
  DateType _calcDateType(int offset) {
    int idx = offset % 7;
    return idx == 0 ? DateType.red : (idx == 6) ? DateType.blue : DateType.normal;
  }
}

/// 曜日ヘッダ
class _DashboardTopCalendarMonthlyHeaderCell  extends StatelessWidget {
  const _DashboardTopCalendarMonthlyHeaderCell({
    required String text,
    required DateType dateType,
  }):
    _text = text,
    _dateType = dateType;

  final String _text;
  final DateType _dateType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: _dateType.bgColor,
          border: Border.all(),
        ),
        child: Center(
          child: Text(
            _text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: _dateType.fgColor),            
          ),
        ),
      )
    );
  }
}

/// 日付セル
class _DashboardTopMonthlyCalendarCellLayout extends StatelessWidget {
  /// date: 日付
  /// 
  /// dateType: 日付のデザイン
  /// 
  /// selected: 選択状態
  /// 
  /// isCurrentMonth: 今月の日付か
  /// 
  /// builder: 表示コンテンツ
  const _DashboardTopMonthlyCalendarCellLayout({
    required int date,
    required DateType dateType,
    required bool selected,
    required bool isCurrentMonth,
    Widget Function(BuildContext)? builder,
  }):
    _date = date,
    _dateType = dateType,
    _selected = selected,
    _isCurrentMonth = isCurrentMonth,
    _builder = builder;

  /// 日付
  final int _date;
  /// 日付の描画デザイン
  final DateType _dateType;
  /// 選択状態か
  final bool _selected;
  /// 今月かそうでないかで表示を変える
  final bool _isCurrentMonth;
  /// 内部のコンテンツ描画
  final Widget Function(BuildContext)? _builder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_selected ? 2.0 : 4.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: _selected ? Colors.green : Colors.black,
          width: _selected ? 3.0 : 1.0,
        ),
        color: _dateType.bgColor,
      ),
      child: Opacity(
        opacity: _isCurrentMonth ? 1.0 : 0.5,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                _date.toString(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: _dateType.fgColor),
              ),
            ),

            if (_builder != null) 
              Align(
                alignment: Alignment.topLeft,
                child: _builder(context),
              ),
          ],
        ),
      ),
    );
  }
}

/// 操作可能な日付セル
class _DashboardTopMonthlyCalendarCell extends StatelessWidget {
  /// date: 日付
  /// 
  /// dateType: 日付のデザイン
  /// 
  /// selected: 選択状態監視用State
  /// 
  /// onClick: クリック時処理
  const _DashboardTopMonthlyCalendarCell({
    required int date,
    required DateType dateType,
    required ValueListenable<bool> selected,
    required Function(int) onClick,
  }):
    _date = date,
    _dateType = dateType,
    _selected = selected,
    _onClick = onClick;

  final int _date;
  final DateType _dateType;
  final ValueListenable<bool> _selected;
  final Function(int) _onClick;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selected, 
      builder: (_, selected, _) => Material(
        child:InkWell(
          onTap: () { _onClick(_date); },
          child: _DashboardTopMonthlyCalendarCellLayout(
            date: _date,
            dateType: _dateType,
            selected: selected, 
            isCurrentMonth: true,
          ),
        ),
      ),
    );
  }
}

@Preview(
  name: 'Monthly Calendar',
  wrapper: previewWrapper,
)
Widget previewMonthlyCalendar() {
  return DashboardTopMonthlyCalendar(
    model: DashboardTopMonthlyCalendarModel(
      year: 2026, 
      month: 3,
      prevMonthDates: [28],
      days: 31
    ),
    onClickPrevMonth: (){},
    onClickNextMonth: (){},
    onClickToday: (){},
    onClickSwitch: (){},
  );
}

@Preview(
  name: 'Header Cell',
  wrapper: previewWrapper,
)
Widget previewHeaderCell() {
  List<String> textList = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat',];

  return Row(
    children: [
      ...textList.mapIndexed(
        (index, text) => _DashboardTopCalendarMonthlyHeaderCell(
          text: text,
          dateType: index == 0 ? DateType.red : index == 6 ? DateType.blue : DateType.normal,
        ),
      ),
        
    ],
  );
}

@Preview(
  name: 'Cell Layout',
  wrapper: previewWrapper,
)
Widget previewCellLayout() {
  List<int> dateList = [29, 30, 31, 1, 2, 3, 4];

  return Row(
    children: [
      for (int date in dateList) 
        Expanded(
          child: _DashboardTopMonthlyCalendarCellLayout(
            date: date, 
            dateType: date == 29 ? DateType.red : (date == 4 ? DateType.blue : DateType.normal),
            selected: date == 2, 
            isCurrentMonth: date < 10,
          ),
        ),
    ],
  );
}

@Preview(
  name: 'Cell',
  wrapper: previewWrapper,
)
Widget previewCell() {
  return Row(
    children: [
      for (var i = 1; i <= 7; ++i)
        Expanded(
          child: PreviewListenableProvider(
            value: i == 3,
            builder: (listenable) => _DashboardTopMonthlyCalendarCell(
              date: i, 
              dateType: i == 1 ? DateType.red : (i == 7 ? DateType.blue : DateType.normal),
              selected: listenable, 
              onClick: (_) {},
            ),
          ),
        ),
    ],
  );
}