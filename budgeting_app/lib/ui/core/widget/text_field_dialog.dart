import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// テキストフィールドを持つダイアログ
class TextFieldDialog extends StatelessWidget {
  TextFieldDialog({
    super.key,
    required Function() onCancel,
    required Function(String text) onDone,
    required String? title,
    required String? description,
    required String? defaultText,
  }): 
    _onCancel = onCancel,
    _onDone = onDone,
    _title = title,
    _description = description,
    _defaultText = defaultText;

  final String? _title;
  final String? _description;
  final String? _defaultText;

  final Function() _onCancel;
  final Function(String text) _onDone;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = _defaultText ?? "";
    return AlertDialog(
      title: _title != null ? Text(_title) : null,
      content: Container(
        padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
        child: Column(
          spacing: 12.0,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_description != null)
              Text(_description),
            
            TextField(
              controller: _controller,
            )
          ]
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _onCancel();
          },
          child: Text(L10n.of(context)!.commonCancel),
        ),
        TextButton(
          onPressed: () {
            _onDone(_controller.text);
          }, 
          child: Text(L10n.of(context)!.commonOk),
        ),
      ],
    );
  }

  /// テキスト入力フィールドを持ったダイアログを表示する。
  /// 
  /// title: 表示するタイトル
  /// 
  /// description: 説明
  /// 
  /// onCancel: 閉じたときの処理
  /// 
  /// onDone: 入力完了時の処理
  /// 
  /// barrierDismissible: 枠外タップで閉じるならばtrue
  static Future<void> show({
    required BuildContext context,
    required Function() onCancel,
    required Function(String text) onDone,
    String? title,
    String? description,
    String? defaultText,
    bool barrierDismissible = true,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => TextFieldDialog(
        onCancel: onCancel,
        onDone: onDone,
        title: title,
        description: description,
        defaultText: defaultText,
      ),
    );
  }
}

@Preview(
  name: 'Text field dialog',
  wrapper: previewWrapper,
)
Widget previewTextFieldDialog() {
  return TextFieldDialog(
    onCancel: (){},
    onDone: (_){},
    title: "TextFieldDialog",
    description: "Description",
    defaultText: null,
  );
}

@Preview(
  name: 'Text field dialog no title',
  wrapper: previewWrapper,
)
Widget previewTextFieldDialogNoTitle() {
  return TextFieldDialog(
    onCancel: (){},
    onDone: (_){},
    title: null,
    description: "Description",
    defaultText: "Hello",
  );
}

@Preview(
  name: 'Text field dialog no description',
  wrapper: previewWrapper,
)
Widget previewTextFieldDialogNoDescription() {
  return TextFieldDialog(
    onCancel: (){},
    onDone: (_){},
    title: "TextFieldDialog",
    description: null,
    defaultText: "",
  );
}
