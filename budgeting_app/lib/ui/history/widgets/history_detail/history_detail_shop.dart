import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 消費履歴詳細・購入先
class HistoryDetailShop extends StatelessWidget {
  const HistoryDetailShop({
    super.key,
    required String? shop,
  }): _shop = shop;

  final String? _shop;

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
        children: [
          Text(
            L10n.of(context)!.expenseHistoryDetailShop,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            _shop ?? L10n.of(context)!.commonEmpty,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );

  }
}

@Preview(
  name: 'History Detail Shop',
  wrapper: previewWrapper,
)
Widget previewHistoryDetailShop() {
  return HistoryDetailShop(shop: 'Amazon');
}