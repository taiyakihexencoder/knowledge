import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 消費履歴詳細・カテゴリー
class HistoryDetailCategory extends StatelessWidget {
  const HistoryDetailCategory({
    super.key,
    required String? category,
  }): _category = category;

  final String? _category;

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
            L10n.of(context)!.expenseHistoryDetailCategory,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            _category ?? L10n.of(context)!.commonEmpty,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );

  }
}

@Preview(
  name: 'History Detail Category',
  wrapper: previewWrapper,
)
Widget previewHistoryDetailCategory() {
  return HistoryDetailCategory(category: '食費');
}