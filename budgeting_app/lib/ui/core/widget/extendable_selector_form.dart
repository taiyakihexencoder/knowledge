import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/text_editing_controller_provider.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 新規追加が可能なドロップダウンメニュー.
/// 
/// 初期状態はコンストラクタ引数ではなくcontrollerにセットする.
class ExtendableSelectorForm<T> extends StatefulWidget{
  /// entries: 選択肢
  /// 
  /// controller: 入力状況取得用
  /// 
  /// display: 選択肢に対応する表示テキスト
  /// 
  /// onRequestAdd: 新規追加が選択されたときの処理。ここでリストへの追加処理を行う
  /// 
  /// inputLength: 入力可能なテキストの長さ
  /// 
  /// clearOnSelect: 選択したときに消すかどうか
  /// 
  /// onSelected: 選択されたときの処理
  /// 
  /// validator: バリデーション
  const ExtendableSelectorForm({
    super.key,
    required ValueListenable<List<T>> entries,
    required TextEditingController controller,
    required String Function(T) display,
    required Future<T?> Function(String) onRequestAdd,
    required Function(T?) onSaved,
    int inputLength = 30,
    bool clearOnSelect = false,
    Function(T?) onSelected = _emptyOnSelected,
    String? Function(T?)? validator,
  }): 
    _entries = entries,
    _controller = controller,
    _display = display,
    _onRequestAdd = onRequestAdd,
    _onSaved = onSaved,
    _onSelected = onSelected,
    _inputLength = inputLength,
    _validator = validator;

  final ValueListenable<List<T>> _entries;
  final TextEditingController _controller;
  final String Function(T) _display;
  final Future<T?> Function(String) _onRequestAdd;
  final Function(T?) _onSaved;
  final Function(T?) _onSelected;
  final int _inputLength;
  final String? Function(T? value)? _validator;

  @override
  ExtendableSelectorFieldState<T> createState() {
    return ExtendableSelectorFieldState();
  }
}

class ExtendableSelectorFieldState<T> extends State<ExtendableSelectorForm<T>> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        String text = widget._controller.text;
        if (text.isNotEmpty) {
          T? selected = widget._entries.value.firstWhereOrNull(
            (entry) => widget._display(entry) == text
          );
          if (selected == null) {
            widget._controller.text = '';
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget._entries,
      builder: (_, entries, _) => _dropdown(context, entries),
    );
  }

  /// ドロップダウンWidget
  Widget _dropdown(BuildContext context, List<T> entries) {
    T? initialSelection = entries.firstWhereOrNull(
      (entry) => widget._display(entry) == widget._controller.text,
    );

    return DropdownMenuFormField<T?>(
      controller: widget._controller,
      // keyを設定しないと、
      // リスト更新後にinitialSelectionは更新されない。
      initialSelection: initialSelection,
      key: ValueKey(entries),
      autovalidateMode: AutovalidateMode.disabled,
      validator: widget._validator,
      focusNode: _focusNode,
      width: double.infinity,
      enableFilter: true,
      onSaved: widget._onSaved,
      dropdownMenuEntries: [
        ...entries.map(
          (entry) => DropdownMenuEntry(
            value: entry,
            label: widget._display(entry),
          ),
        ),

        // filterCallbackで要素が増えると、Indexでアクセスしようとしてエラーになる
        // これを回避するためにダミーの項目を置いておく
        DropdownMenuEntry(
          value: null, 
          label: '',
          enabled: false,
        ),
      ],
      onSelected:_onSelected,
      filterCallback: (entries, filter) => _filter(
        entries: entries,
        filter: filter,
      ),
    );
  }

  /// 新規追加を選択した場合を含めた選択時処理
  void _onSelected(T? selected) async {
    if (selected == null && widget._controller.text.isNotEmpty) {
      T? result = await widget._onRequestAdd(widget._controller.text);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget._onSelected(result);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget._onSelected(selected);
      });
    }
  }

  /// 候補がない場合に新規追加を選択できるフィルター
  List<DropdownMenuEntry<T?>> _filter({
    required List<DropdownMenuEntry<T?>> entries, 
    required String filter
  }) {
    List<DropdownMenuEntry<T?>> filteredEntries = entries.where(
      (entry) => entry.value != null && entry.label.contains(filter)
    ).toList();

    if (filter.isNotEmpty && !filteredEntries.any((entry) => entry.label == filter)) {
      if (filter.length <= widget._inputLength) {
        filteredEntries.add(_emptyMenuEntry());
      } else {
        filteredEntries.add(_overflowMenuEntry());
      }
    }

    return filteredEntries;
  }

  /// 新規追加のエントリー
  DropdownMenuEntry<T?> _emptyMenuEntry() {
    return DropdownMenuEntry(
      value: null,
      label: widget._controller.text,
      enabled: true,
      trailingIcon: Icon(Icons.add),
    );
  }

  DropdownMenuEntry<T?> _overflowMenuEntry() {
    return DropdownMenuEntry(
      value: null, 
      label: L10n.of(context)?.inputExcessSelectWord(widget._inputLength) ?? '',
      enabled: false,
    );
  }
}

/// 空の関数
void _emptyOnSelected(Object? entry) {}

@Preview(
  name: 'Extendable Selector Form',
  wrapper: previewWrapper,
)
Widget previewExtendableSelectorField() {
  ValueNotifier<List<String>> entries = ValueNotifier([
    'AAAA',
    'aaaa',
    'abab',
  ]);

  return TextEditingControllerProvider(
    builder: (context, controllers) {
      return SizedBox(
        height: 300.0,
        child: ExtendableSelectorForm(
          entries: entries,
          controller: controllers[0], 
          validator: (value) {
            if (value == 'AAAA') {
              return 'NG';
            } else {
              return null;
            }
          },
          display: (String? selected) => selected ?? '', 
          onRequestAdd: (text) => Future.value(text),
          onSaved: (_) {}
        ),
      );
    }
  );
}
