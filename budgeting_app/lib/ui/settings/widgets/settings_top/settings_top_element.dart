import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 設定画面の表示項目
class SettingsTopListElement extends StatelessWidget {
  const SettingsTopListElement({
    super.key,
    required String label,
    required Function() onClick,
  }) : 
    _label = label,
    _onClick = onClick;

  final String _label;
  final Function() _onClick;

  @override
  Widget build(BuildContext context) {
    final BorderSide borderStyle = BorderSide(
      color: Colors.blueGrey,
      width: 1,
    );

    return GestureDetector(
      onTap: _onClick,
      child: Container(
        width: double.infinity,
        height: 40.0,
        padding: EdgeInsetsGeometry.fromSTEB(12, 8, 12, 8),
        decoration: BoxDecoration(
          border: Border(
            left: borderStyle,
            top: borderStyle,
            right: borderStyle,
            bottom: borderStyle,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Row(
          children: [
            Text(_label),
            Spacer(),
            Icon(
              Icons.arrow_right,
              color: Colors.grey,
              size: 24.0,
            )
          ],
        ),
      ),
    );
  }
}

@Preview(
  name: 'Settings List Element',
  wrapper: previewWrapper,
)
Widget previewListElement() {
  return SettingsTopListElement(
    label: "Label",
    onClick: () { },
  );
}