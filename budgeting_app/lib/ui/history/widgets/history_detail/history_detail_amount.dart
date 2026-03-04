import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 消費履歴詳細・消費額
class HistoryDetailAmount extends StatelessWidget {
  const HistoryDetailAmount({
    super.key,
    required int amount,
  }): _amount = amount;

  final int _amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            L10n.of(context)!.expenseHistoryDetailAmount,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            _amount.toString(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(width: 10),
          Text(L10n.of(context)!.commonPriceSuffix),
        ],
      ),
    );

  }
}

@Preview(
  name: 'History Detail Amount',
  wrapper: previewWrapper,
)
Widget previewHistoryDetailAmount() {
  return HistoryDetailAmount(amount: 12300);
}