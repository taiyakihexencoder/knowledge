import 'package:budgeting_app/ui/settings/models/category_model.dart';
import 'package:flutter/material.dart';

/// リストの１個の要素
class SettingsAttributesCategoryListElement extends StatelessWidget {
  const SettingsAttributesCategoryListElement({
    super.key,
    required CategoryModel model,
    required Function(CategoryModel) onClickEdit,
    required Function(CategoryModel) onClickDelete,
  }): 
    _model = model,
    _onClickEdit = onClickEdit,
    _onClickDelete = onClickDelete;

  final CategoryModel _model;
  final Function(CategoryModel) _onClickEdit;
  final Function(CategoryModel) _onClickDelete;

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