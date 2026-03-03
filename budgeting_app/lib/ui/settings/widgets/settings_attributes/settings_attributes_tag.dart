import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/settings/models/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';


/// リストの１個の要素
class SettingsAttributesTagListElement extends StatelessWidget {
  const SettingsAttributesTagListElement({
    super.key,
    required TagModel model,
    required Function(TagModel) onClickEdit,
    required Function(TagModel) onClickDelete,
  }): 
    _model = model,
    _onClickEdit = onClickEdit,
    _onClickDelete = onClickDelete;

  final TagModel _model;
  final Function(TagModel) _onClickEdit;
  final Function(TagModel) _onClickDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        )
      ),
      child: Row(
        children: [
          Text(_model.name),
          Spacer(),
          IconButton.filled(
            onPressed: () => _onClickEdit(_model),
            icon: Icon(
              Icons.edit,
            ),
            color: Theme.of(context).iconTheme.color,
            style: IconButton.styleFrom(backgroundColor: Colors.transparent),
          ),
          SizedBox(width:24),
          IconButton.filled(
            onPressed: () => _onClickDelete(_model),
            icon: Icon(
              Icons.delete,
            ),
            color: Colors.red,
            style: IconButton.styleFrom(backgroundColor: Colors.transparent),
          ),
        ],
      )
    );
  }
}

@Preview(
  name: 'list element',
  wrapper: previewWrapper,
)
Widget previewSettingsAttributesTagListElement() {
  return SettingsAttributesTagListElement(
    model: TagModel(
      id: 0,
      name: 'Test',
    ),
    onClickEdit: (_){},
    onClickDelete: (_){},
  );
}