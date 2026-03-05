import 'package:budgeting_app/ui/core/widget/text_editing_controller_provider.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 新規追加が可能なドロップダウンメニュー.
/// 
/// 初期状態はコンストラクタ引数ではなくcontrollerにセットする.
class ExtendableSelectorField<T> extends StatefulWidget{
  /// entries: 選択肢
  /// 
  /// controller: 入力状況取得用
  /// 
  /// display: 選択肢に対応する表示テキスト
  /// 
  /// onRequestAdd: 新規追加が選択されたときの処理。ここでリストへの追加処理を行う
  /// 
  /// onSelected: 選択されたときの処理。
  /// 新規追加の場合はリストが更新されるので呼ばれない。
  const ExtendableSelectorField({
    super.key,
    required ValueListenable<List<T>> entries,
    required TextEditingController controller,
    required String Function(T) display,
    required Future<void> Function(String) onRequestAdd,
    Function(T?) onSelected = _emptyOnSelected,
  }): 
    _entries = entries,
    _controller = controller,
    _display = display,
    _onRequestAdd = onRequestAdd,
    _onSelected = onSelected;

  final ValueListenable<List<T>> _entries;
  final TextEditingController _controller;
  final String Function(T) _display;
  final Future<void> Function(String) _onRequestAdd;
  final Function(T?) _onSelected;

  @override
  ExtendableSelectorFieldState<T> createState() {
    return ExtendableSelectorFieldState();
  }
}

class ExtendableSelectorFieldState<T> extends State<ExtendableSelectorField<T>> {
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
    return DropdownMenu<T?>(
      controller: widget._controller,
      focusNode: _focusNode,
      width: double.infinity,
      enableFilter: true,
      dropdownMenuEntries: [
        // emptyの場合filterCallbackの表示後にIndexでアクセスしようとしてエラーになる
        if (entries.isEmpty)
          DropdownMenuEntry(
            value: null, 
            label: '',
            enabled: false,
            style: null,
          ),

        ...entries.map(
          (entry) => DropdownMenuEntry(
            value: entry,
            label: widget._display(entry),
          ),
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
      await widget._onRequestAdd(widget._controller.text);
    } else {
      widget._onSelected(selected);
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
    if (filteredEntries.isEmpty) {
      filteredEntries.add(_emptyMenuEntry());
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
}

/// 空の関数
void _emptyOnSelected(Object? entry) {}

@Preview(
  name: 'Extendable Selector Field',
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
        child: ExtendableSelectorField(
          entries: entries,
          controller: controllers[0], 
          display: (String? selected) => selected ?? '', 
          onRequestAdd: (String text) => Future.value()
        ),
      );
    }
  );
}