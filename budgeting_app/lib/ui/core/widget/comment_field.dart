import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/core/widget/text_editing_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// タイトルと説明を入力するフィールド
class CommentField extends StatefulWidget{
  const CommentField({
    super.key,
    required TextEditingController titleController,
    required TextEditingController descriptionContoller,
    int titleLength = 30,
    int descritpionLength = 100,
    int minDescriptionLines = 3,
    int? maxDescriptionLines,
  }): 
    _titleController = titleController,
    _descriptionController = descriptionContoller,
    _titleLength = titleLength,
    _descriptionLength = descritpionLength,
    _minDescriptionLines = minDescriptionLines,
    _maxDescriptionLines = maxDescriptionLines;

  final int _titleLength;
  final int _descriptionLength;
  final int _minDescriptionLines;
  final int? _maxDescriptionLines;

  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  @override
  CommentFieldState createState() {
    return CommentFieldState();
  }
}

class CommentFieldState extends State<CommentField> {
  final FocusNode _descriptionFocus = FocusNode();

  @override
  void dispose() {
    _descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _titleWidget(
          context: context, 
          descriptionFocus: _descriptionFocus,
        ),

        SizedBox(height: 12.0,),

        _descriptionWidget(
          context: context, 
          descriptionFocus: _descriptionFocus
        ),
      ],
    );
  }

  /// タイトル
  Widget _titleWidget({
    required BuildContext context,
    required FocusNode descriptionFocus,
  }) {
    final String title = L10n.of(context)!.newLogContentTitle;
    return TextField(
      controller: widget._titleController,
      maxLength: widget._titleLength,
      onSubmitted: (value) => {
        descriptionFocus.requestFocus(),
      },
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder()
      ),
    );
  }

  Widget _descriptionWidget({
    required BuildContext context,
    required FocusNode descriptionFocus,
  }) {
    final String description = L10n.of(context)!.newLogContentDescription;

    return TextField(
      controller: widget._descriptionController,
      focusNode: descriptionFocus,
      keyboardType: TextInputType.multiline,
      maxLength: widget._descriptionLength,
      minLines: widget._minDescriptionLines,
      maxLines: widget._maxDescriptionLines,
      onSubmitted: (value) => {},
      decoration: InputDecoration(
        labelText: description,
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
    );
  }
}

@Preview(
  name: 'Comment Field',
  wrapper: previewWrapper,
)
Widget previewContent() {
  return TextEditingControllerProvider(
    controllerCount: 2,
    builder: (context, controllers) {
      return CommentField(
        titleController: controllers[0],
        descriptionContoller: controllers[1],
      );
    }
  );
}
