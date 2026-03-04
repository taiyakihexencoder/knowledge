import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 消費履歴詳細・タグ
class HistoryDetailTag extends StatelessWidget {
  const HistoryDetailTag({
    super.key,
    required List<String> tags,
  }): _tags = tags;

  final List<String> _tags;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L10n.of(context)!.expenseHistoryDetailTag,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 12),

          if (_tags.isEmpty) 
            Text(
              L10n.of(context)!.expenseHistoryDetailTagEmpty,
            )
          else 
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _tags.map(
                (tag) => _tagWidget(context, tag),
              ).toList(),
            ),
        ],
      ),
    );

  }

  Widget _tagWidget(BuildContext context, String tag) {
    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(
            side: BorderSide(),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(8.0, 2.0, 8.0, 2.0),
        child: Text(
          tag,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      )
    );
  }
}

@Preview(
  name: 'History Detail Tags Empty',
  wrapper: previewWrapper,
)
Widget previewHistoryDetailTagsEmpty() {
  return HistoryDetailTag(tags: []);
}

@Preview(
  name: 'History Detail Tags',
  wrapper: previewWrapper,
)
Widget previewHistoryDetailTags() {
  return HistoryDetailTag(
    tags: [
      'Tag First',
      'Tag Second',
      'Tag Third',
      'Tag Fourth',
      'Tag Fifth',
      'Tag Sixth',
      'Tag Seventh',
      'Tag Eighth',
      'Tag Nineth',
      'Tag Tenth'
    ]
  );
}