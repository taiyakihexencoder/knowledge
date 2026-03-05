import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/core/widget/text_editing_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:intl/intl.dart';

/// 日付選択Widget
class DateSelectorField extends StatelessWidget {
  /// controller: 初期値を設定する場合は'yyyy-MM-dd'で設定する
  /// 
  /// firstDate: 選択可能な古い日付。未設定の場合はepoch_time=0が設定される
  /// 
  /// lastDate: 選択可能な新しい日付。未設定の場合は今日から20年後が設定される
  DateSelectorField({
    super.key,
    required TextEditingController controller,
    DateTime? firstDate,
    DateTime? lastDate,
  }):
    _controller = controller,
    _firstDate = firstDate,
    _lastDate = lastDate;

  final TextEditingController _controller;
  final DateFormat _inputFormat = DateFormat('yyyy-MM-dd');
  late final DateFormat _viewFormat;

  final DateTime? _firstDate;
  final DateTime? _lastDate; 

  @override
  Widget build(BuildContext context) {
    _viewFormat = DateFormat(L10n.of(context)!.commonFullDateFormat);

    return Row(
      children:[
        _textField(context),
        SizedBox(width:16),
        _calendarPicker(context),
      ],
    );
  }

  Widget _textField(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (_, edit, _) {
        DateTime? dateTime = _inputFormat.tryParse(edit.text);
        String text;
        if (dateTime != null) {
          text = _viewFormat.format(dateTime);
        } else {
          text = L10n.of(context)!.commonEmptyDate;
        }
        return Text(text);
      },
    );
  }

  Widget _calendarPicker(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_month),
      onPressed: () async {
        DateTime now = DateTime.now();
        DateTime initial = _inputFormat.tryParse(_controller.text) ?? now;

        DateTime? selectedDateTime = await showDatePicker(
          context: context, 
          initialDate: initial,
          firstDate: _firstDate ?? DateTime.fromMicrosecondsSinceEpoch(0, isUtc: false), 
          lastDate: _lastDate ?? DateTime(now.year + 20, now.month, now.day),
        );

        if (selectedDateTime != null) {
          _controller.text = _inputFormat.format(selectedDateTime);
        }
      },
    );
  }
}

@Preview(
  name: 'Date Selector Field',
  wrapper: previewWrapper,
)
Widget previewDateSelectorField() {
  return TextEditingControllerProvider(
    builder: (context, controllers) {
      controllers[0].text = '2000-1';
      return DateSelectorField(
        controller: controllers[0],
      );
    },
  );
}