import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 選択済の項目共通表示
class HistoryFilterSelectedElement extends StatelessWidget {
  /// id: 選択肢に対応するid
  /// 
  /// name: 表示テキスト
  /// 
  /// onClickCloseIcon: 選択解除処理
  const HistoryFilterSelectedElement({
    super.key,
    required int id,
    required String name,
    required Function(int) onClickCloseIcon,
  }): 
    _id = id,
    _name = name,
    _onClickCloseIcon = onClickCloseIcon;

  final int _id;
  final String _name;
  final Function(int) _onClickCloseIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
      padding: EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _name,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          IconButton(
            icon: Icon(Icons.close,),
            iconSize: 18.0,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(), // IconButtonのデフォルトサイズを無視
            onPressed: () { _onClickCloseIcon(_id); },
          ),
        ],
      ),
    );
  }
}

@Preview(
  name: 'History Filter Selected Element',
  wrapper: previewWrapper,
)
Widget previewHistoryFilterSelectedElement() {
  return HistoryFilterSelectedElement(
    id: 0, 
    name: 'HistoryFilterSelectedElement',
    onClickCloseIcon: (_){},
  );
}