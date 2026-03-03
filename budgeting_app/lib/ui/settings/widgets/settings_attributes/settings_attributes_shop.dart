import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/settings/models/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// リストの１個の要素
class SettingsAttributesShopListElement extends StatelessWidget {
  const SettingsAttributesShopListElement({
    super.key,
    required ShopModel model,
    required Function(ShopModel) onClickEdit,
    required Function(ShopModel) onClickDelete,
  }): 
    _model = model,
    _onClickEdit = onClickEdit,
    _onClickDelete = onClickDelete;

  final ShopModel _model;
  final Function(ShopModel) _onClickEdit;
  final Function(ShopModel) _onClickDelete;

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
Widget previewSettingsAttributesShopListElement() {
  return SettingsAttributesShopListElement(
    model: ShopModel(
      id: 0,
      name: 'Test',
    ),
    onClickEdit: (_){},
    onClickDelete: (_){},
  );
}