import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/text_editing_controller_provider.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';

/// 金額入力フィールド.
/// 
/// デフォルトの値は引数ではなくcontroller.textに設定する.
class PriceEditField extends StatelessWidget {
  /// controller: テキスト入力取得用
  /// 
  /// maxLength: 入力文字数
  /// 
  /// onSubmitted(not required): キーボードエンター時の挙動
  /// 
  /// focusNode(not required): このWidgetに設定するフォーカス 
  const PriceEditField({
    super.key,
    required TextEditingController controller,
    required int maxLength,
    Function(String input) onSubmitted = _emptySubmitted,
    FocusNode? focusNode,
  }): 
    _controller = controller,
    _maxLength = maxLength,
    _onSubmitted = onSubmitted,
    _focusNode = focusNode;

  final TextEditingController _controller;
  final int _maxLength;
  final Function(String input) _onSubmitted;
  final FocusNode? _focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [ _getDigitFormatter(context) ],
      textAlign: TextAlign.right,
      maxLength: _maxLength,
      onSubmitted: _onSubmitted,
      decoration: _priceInputDecoration(context),
      focusNode: _focusNode,
    );
  }

  /// 金額テキストの入力規則
  TextInputFormatter _getDigitFormatter(BuildContext context) {
    final String pattern = '^[0-9.]+';
    return FilteringTextInputFormatter.allow(RegExp(pattern));
  }

  /// 金額テキストの入力UIデザイン
  InputDecoration _priceInputDecoration(BuildContext context) {
    return InputDecoration(
      border: OutlineInputBorder(),
      suffix: Text(
        L10n.of(context)!.commonPriceSuffix,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 8.0,
        ),
      ),
      hint: Text(
        L10n.of(context)!.newLogAmountHint,
      ),
      counterText: "", // 文字数カウントを表示しない
    );
  }
}

/// 空の処理関数。
/// 
/// TextFieldのonSubmittedに指定しない場合。
void _emptySubmitted(String input) {}

@Preview(
  name: 'Price Edit Field',
  wrapper: previewWrapper,
)
Widget previewPriceEditField() {
  return TextEditingControllerProvider(
    builder: (_, controllers) {
      controllers[0].text = '10000000';
      return PriceEditField(
        controller: controllers[0],
        maxLength: 10,
      );
    },
  );
}