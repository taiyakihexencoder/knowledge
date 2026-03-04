import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/history/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 消費履歴の１個を描画するWidget
/// 
class HistoryListElement extends StatelessWidget {
  const HistoryListElement({
    super.key,
    required this.model,
    required Function(BuildContext, int) navigateToDetail
  }): _navigateToDetail = navigateToDetail;

  final HistoryModel model;
  final Function(BuildContext, int) _navigateToDetail;

  @override
  Widget build(BuildContext context) {
    final TextStyle? styleLabel = Theme.of(context).textTheme.labelLarge;

    return InkWell(
      onTap: () {
        _navigateToDetail(context, model.id);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        color: Theme.of(context).cardColor,
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Divider(
              thickness: 0.5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100.0,
                  child: Text(
                    model.usedAt,
                    style: styleLabel,
                  ),
                ),
                Text(
                  model.shop ?? L10n.of(context)!.commonEmpty,
                  style: styleLabel,
                ),
                const Spacer(),
                Text(
                  model.category ?? L10n.of(context)!.commonEmpty,
                  style: styleLabel,
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(
                  L10n.of(context)!.commonPrice(model.amount),
                  style: styleLabel,
                ),
              ],
            ),
            if (model.tags.isNotEmpty)
              SingleChildScrollView(
                child:Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.0,
                  children: [
                    ...model.tags.map(
                      (tag) => HistoryListElementTagWidget(name: tag),
                    ),
                  ]
                )
              )
          ],
        ),
      ),
    );
  }
}

class HistoryListElementTagWidget extends StatelessWidget {
  const HistoryListElementTagWidget({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final TextStyle? styleLabelSmall = Theme.of(context).textTheme.labelSmall;

    return Container(
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(
            color: Theme.of(context).textTheme.bodyMedium!.color!
          )
        ),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(8.0, 2.0, 8.0, 2.0),
        child: Text(
          name,
          style: styleLabelSmall,
        ),
      ),
    );
  }
}

@Preview(
  name: 'History List Element',
  wrapper: previewWrapper,
)
Widget previewHistoryListElement() {
  return HistoryListElement(
    model: HistoryModel(
      id: 1,
      category:'通販',
      shop: 'Amazon',
      amount: 10000,
      usedAt: '2026/2/20',
      tags: ['趣味', 'ゲーム', ],
    ),
    navigateToDetail:(_, _) {},
  );
}

@Preview(
  name: 'History List Element (Empty Tag)',
  wrapper: previewWrapper,
)
Widget previewHistoryListElementEmptyTag() {
  return HistoryListElement(
    model: HistoryModel(
      id: 2,
      category:'雑費',
      shop: 'AEON',
      amount: 230,
      usedAt: '2026/2/17',
      tags:[],
    ),
    navigateToDetail: (_, _) {},
  );
}