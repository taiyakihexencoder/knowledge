import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:intl/intl.dart';

/// 日付選択フォームフィールド
class DateSelectorForm extends FormField<String> {

  /// onSaved: フォーム保存時に値を取得できる
  /// 
  /// validator: バリデーション
  /// 
  /// initialValue: 初期値
  /// 
  /// firstDate: 選択可能な古い日付。未設定の場合はepoch_time=0が設定される
  /// 
  /// lastDate: 選択可能な新しい日付。未設定の場合は今日から20年後が設定される
  DateSelectorForm({
    super.key,
    required super.onSaved,
    required FormFieldValidator<String> validator,
    String? initialValue,
    DateTime? firstDate,
    DateTime? lastDate,
  }):
    super(
      validator: validator,
      initialValue: initialValue ?? '',
      autovalidateMode: AutovalidateMode.disabled,
      builder: (FormFieldState<String> state) {
        final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
        final String viewFormat = L10n.of(state.context)!.commonFullDateFormat;

        DateTime inputDateTime = inputFormat.tryParse(state.value ?? '') ?? DateTime.now();

        return 
          Padding(
            padding: EdgeInsetsGeometry.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: state.hasError ? Colors.red : Colors.black,
                          )
                        ),
                      ),
                      child: Text(DateFormat(viewFormat).format(inputDateTime))
                    ),

                    SizedBox(width:16.0),

                    IconButton.filled(
                      icon: Icon(Icons.calendar_month),
                      onPressed: () async {
                        DateTime now = DateTime.now();
                        DateTime? selectedDateTime = await showDatePicker(
                          context: state.context, 
                          initialDate: inputDateTime,
                          firstDate: firstDate ?? DateTime.fromMicrosecondsSinceEpoch(0, isUtc: false), 
                          lastDate: lastDate ?? DateTime(now.year + 20, now.month, now.day),
                        );

                        if (selectedDateTime != null) {
                          state.didChange(inputFormat.format(selectedDateTime));
                        }
                      },
                    ),
                  ],
                ),

                if (state.hasError) 
                  Text(
                    state.errorText ?? '',
                    style: Theme.of(state.context).textTheme.bodySmall?.copyWith(color: Colors.red),
                  ),
              ],
            ),
        );
      }
    ); 
}

@Preview(
  name: 'Date Selector Field',
  wrapper: previewWrapper,
)
Widget previewDateSelectorField() {
  return DateSelectorForm(
    onSaved: (_){}, 
    validator: (_) => null,
  );
}