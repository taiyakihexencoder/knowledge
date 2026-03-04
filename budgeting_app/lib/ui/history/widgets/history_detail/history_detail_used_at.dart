import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:intl/intl.dart';

/// 購入日付
class HistoryDetailUsedAt extends StatelessWidget {
  const HistoryDetailUsedAt({
    super.key,
    required String usedAt,    
  }): _usedAt = usedAt;

  final String _usedAt;

  @override
  Widget build(BuildContext context) {
    String pattern = '${_usedAt.substring(0,4)}-${_usedAt.substring(4,6)}-${_usedAt.substring(6,8)}';
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(pattern);
    String text = DateFormat(
      L10n.of(context)!.expenseHisotryDetailDateTimeFormat,
    ).format(dateTime);
    return Text(
      text,
    );
  }
}

@Preview(
  name: 'History Detail Used At',
  wrapper: previewWrapper,
)
Widget previewHistoryDetailUsedAt() {
  return HistoryDetailUsedAt(usedAt: '20260101',);
}
