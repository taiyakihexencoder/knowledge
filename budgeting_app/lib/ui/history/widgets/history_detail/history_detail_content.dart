import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/history/models/history_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 購入詳細情報リスト
class HistoryDetailContent extends StatelessWidget {
  const HistoryDetailContent({
    super.key,
    required List<HistoryDetailContentModel> models,
  }) : _models = models;

  final List<HistoryDetailContentModel> _models; 

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          L10n.of(context)!.expenseHistoryDetailContent,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 8.0),

        if (_models.isEmpty) 
          Padding(
            padding: EdgeInsetsGeometry.fromSTEB(12.0, 0.0, 12.0, 0.0),
            child:Text(L10n.of(context)!.expenseHistoryDetailContentEmpty),
          ),

        for (HistoryDetailContentModel model in _models)
          ..._contentWidget(context, model),
      ]
    );
  }

  List<Widget> _contentWidget(
    BuildContext context, 
    HistoryDetailContentModel model
  ) {
    return [
      Container(
        margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
        padding: EdgeInsetsDirectional.only(bottom: 4.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          )
        ),
        child: Text(
          model.title,
        ),
      ),

      SizedBox(height: 8.0),

      Padding(
        padding: EdgeInsetsGeometry.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Text(
          model.description,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.2),
        ),
      ),
      
      SizedBox(height: 24.0),
    ];
  }
}

@Preview(
  name: 'History Detail Content',
  wrapper: previewWrapper,
)
Widget previewHistoryDetailContent() {
  return HistoryDetailContent(
    models: [
      HistoryDetailContentModel(
        title: 'Title 1', 
        description: 'Description',
      ),

      HistoryDetailContentModel(
        title: 'The Tale of Genji', 
        description: 'いづれの御時にか、女御、更衣あまたさぶらひたまひけるなかに、いとやむごとなき際にはあらぬが、すぐれてときめきたまふありけり。',
      ),

      HistoryDetailContentModel(
        title: 'Title 3', 
        description: 'Description',
      ),
    ],
  );
}

@Preview(
  name: 'History Detail Content Empty',
  wrapper: previewWrapper,
)
Widget previewHistoryDetailContentEmpty() {
  return HistoryDetailContent(
    models: [],
  );
}