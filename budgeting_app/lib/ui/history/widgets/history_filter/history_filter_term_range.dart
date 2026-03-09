import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/history/models/history_filter_date_time_range_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:intl/intl.dart';

class HistoryFilterTermRange extends StatelessWidget {
  const HistoryFilterTermRange({
    super.key,
    required HistoryFilterDateTimeRangeModel model,
    required bool active,
    required Function(DateTimeRange) onRangeChanged,
  }) : 
    _model = model,
    _active = active,
    _onRangeChanged = onRangeChanged;

  final HistoryFilterDateTimeRangeModel _model;
  final Function(DateTimeRange) _onRangeChanged;
  final bool _active;

  @override
  Widget build(BuildContext context) {
    final DateFormat viewFormat = DateFormat(L10n.of(context)!.commonFullDateFormat);

    final DateTime? start = _model.range?.start;
    final DateTime? end = _model.range?.end;
    
    final String startText = start == null ? L10n.of(context)!.commonEmpty : viewFormat.format(start);
    final String endText = end == null ? L10n.of(context)!.commonEmpty : viewFormat.format(end);

    return Opacity(
      opacity: _active ? 1.0 : 0.5,
      child: AbsorbPointer(
        absorbing: !_active,
        child: Row(
          children: [
            Text('$startText – $endText'),
            SizedBox(width:25.0),
            IconButton.filled(
              onPressed: () => onPressedIconButton(context), 
              icon: Icon(Icons.calendar_month)
            ),
          ]
        ),
      ),
    );
  }

  void onPressedIconButton(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTimeRange? range = await showDateRangePicker(
      context: context, 
      initialDateRange: _model.range,
      firstDate: DateTime.fromMillisecondsSinceEpoch(0), 
      lastDate: DateTime(now.year + 20, now.month, now.day),
      initialEntryMode: DatePickerEntryMode.input,
    );

    if (range != null) {
      _onRangeChanged(range);
    }
  }
}

@Preview(
  name: 'Term Range Active',
  wrapper: previewWrapper,
)
Widget previewTermRangeActive() {
  return HistoryFilterTermRange(
    model: HistoryFilterDateTimeRangeModel(), 
    active: true, 
    onRangeChanged: (_) {} 
  );
}

@Preview(
  name: 'Term Range Inactive',
  wrapper: previewWrapper,
)
Widget previewTermRangeInactive() {
  return HistoryFilterTermRange(
    model: HistoryFilterDateTimeRangeModel(), 
    active: false, 
    onRangeChanged: (_) {} 
  );
}