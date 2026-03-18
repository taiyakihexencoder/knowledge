import 'package:budgeting_app/res/string/l10n.dart';
import 'package:flutter/material.dart';

/// 履歴詳細の入力フォーム
class CommentForm extends StatefulWidget {
  /// initialTitle: 初期状態のタイトル
  ///
  /// titleValidator: タイトルのバリデーション
  /// 
  /// titleSaved: Formセーブ時の処理（タイトル）
  /// 
  /// titleLength: タイトルの最大文字数
  /// 
  /// initialDesciription: 初期状態の説明
  /// 
  /// descriptionValidator: 説明書きのバリデーション
  /// 
  /// descriptionSaved: Formセーブ時の処理（説明）
  /// 
  /// descriptionLength: 説明の最大文字数
  /// 
  /// minDescriptionLines: 説明の表示行数下限
  /// 
  /// maxDescriptionLines: 説明の表示行数上限（nullで無限）
  const CommentForm({
    super.key,
    String initialTitle = '',
    String? Function(String?)? titleValidator,
    Function(String?)? titleSaved,
    int titleLength = 30,
    String initialDescription = '',
    String? Function(String?)? descriptionValidator,
    Function(String?)? descriptionSaved,
    int descriptionLength = 100,
    int minDescriptionLines = 3,
    int? maxDescriptionLines,
  }): 
    _initialTitle = initialTitle,
    _titleValidator = titleValidator,
    _titleSaved = titleSaved,
    _titleLength = titleLength,
    _initialDescription = initialDescription,
    _descriptionValidator = descriptionValidator,
    _descriptionSaved = descriptionSaved,
    _descriptionLength = descriptionLength,
    _minDescriptionLines = minDescriptionLines,
    _maxDescriptionLines = maxDescriptionLines;

  final String _initialTitle;

  final String? Function(String?)? _titleValidator;
  final Function(String?)? _titleSaved;
  final int _titleLength;

  final String _initialDescription;

  final String? Function(String?)? _descriptionValidator;
  final Function(String?)? _descriptionSaved;
  final int _descriptionLength;
  final int _minDescriptionLines;
  final int? _maxDescriptionLines;

  @override
  CommentFormState createState() {
    return CommentFormState();
  }
}

class CommentFormState extends State<CommentForm> {
  final FocusNode _descriptionFocus = FocusNode();

  @override
  void dispose() {
    _descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.0,
      children: [
        TextFormField(
          initialValue: widget._initialTitle,
          validator: widget._titleValidator,
          autovalidateMode: AutovalidateMode.disabled,
          onSaved: widget._titleSaved,
          maxLength: widget._titleLength,
          onFieldSubmitted: (value) => {
            _descriptionFocus.requestFocus(),
          },
          decoration: InputDecoration(
            labelText: L10n.of(context)!.newLogContentTitle,
            border: OutlineInputBorder()
          ),
        ),

        TextFormField(
          initialValue: widget._initialDescription,
          validator: widget._descriptionValidator,
          autovalidateMode: AutovalidateMode.disabled,
          onSaved: widget._descriptionSaved,
          focusNode: _descriptionFocus,
          keyboardType: TextInputType.multiline,
          maxLength: widget._descriptionLength,
          minLines: widget._minDescriptionLines,
          maxLines: widget._maxDescriptionLines,
          onFieldSubmitted: (_) => {},
          decoration: InputDecoration(
            labelText: L10n.of(context)!.newLogContentDescription,
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
        ),
      ]
    );
  }
}