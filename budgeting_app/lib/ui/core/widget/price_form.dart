import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';

/// 金額入力フォーム
class PriceForm extends StatelessWidget {
  /// initialValue: デフォルトの値
  /// 
  /// maxLength: テキストの長さ
  /// 
  /// validator: バリデーション
  /// 
  /// onSubmit: エンター時の挙動
  /// 
  /// onSaved: フォームでsave()が呼ばれたときの値を取得
  /// 
  /// focusNode: フォーカス
  const PriceForm({
    super.key,
    int? initialValue,
    required int maxLength,
    required String? Function(String?) validator,
    Function(String) onSubmitted = _emptySubmitted,
    required Function(String?) onSaved,
    FocusNode? focusNode,
  }):
    _initialValue = initialValue,
    _maxLength = maxLength,
    _validator = validator,
    _onSaved = onSaved,
    _onSubmitted = onSubmitted,
    _focusNode = focusNode;

  final int? _initialValue;
  final int _maxLength;
  final String? Function(String?) _validator;
  final Function(String?) _onSaved;
  final Function(String) _onSubmitted;
  final FocusNode? _focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: _initialValue?.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [ _getDigitFormatter(context), ],
      textAlign: TextAlign.right,
      maxLength: _maxLength,
      onFieldSubmitted: _onSubmitted,
      decoration: _priceInputDecoration(context),
      focusNode: _focusNode,
      onSaved: _onSaved,
      validator: _validator,
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
/// onSubmittedに指定しない場合。
void _emptySubmitted(String input) {}

@Preview(
  name: 'Price Form',
  wrapper: previewWrapper,
)
Widget previewPriceForm() {
  return Form(
    child: PriceForm(
      maxLength: 8,
      validator: (_) => 'validator',
      onSaved: (_) { },
    ),
  );
}