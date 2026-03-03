import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// OK/Cancelのダイアログ
class OkCancelDialog extends StatelessWidget {
  const OkCancelDialog({
    super.key,
    required String? title,
    required String description,
    required Function() onCancel,
    required Function() onOk,
  }):
    _title = title,
    _description = description,
    _onCancel = onCancel,
    _onOk = onOk;

  final String? _title;
  final String _description;

  final Function() _onCancel;
  final Function() _onOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _title != null ? Text(_title) : null,
      content: Container(
        padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
        child: Text(_description),
      ),
      actions: [
        TextButton(
          onPressed: _onCancel,
          child: Text(L10n.of(context)!.commonCancel),
        ),
        TextButton(
          onPressed: _onOk, 
          child: Text(L10n.of(context)!.commonOk)
        ),
      ]
    );
  }

  /// シンプルなメッセージボックス
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
    required Function() onOk,
    String? title,
    required description,
    bool barrierDismissible = false,
  }) async {
    return showDialog(
      context: context, 
      barrierDismissible: barrierDismissible,
      builder: (_) => OkCancelDialog(
        title: title, 
        description: description, 
        onCancel: onCancel, 
        onOk: onOk
      ),
    );
  }
}

@Preview(
  name: 'Ok Cancel Dialog',
  wrapper: previewWrapper,
)
Widget previewOkCancelDialog() {
  return OkCancelDialog(
    title: "Ok Cancel Dialog", 
    description: "ok or cancel", 
    onCancel: () {}, 
    onOk: () {},
  );
}