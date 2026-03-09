import 'package:flutter/material.dart';

class StatefulCheckbox extends StatefulWidget {
  const StatefulCheckbox({
    super.key,
    required ValueNotifier<bool> notifier,
    required Function(bool? value) onChanged,
  }):
    _notifier = notifier,
    _onChanged = onChanged;

  final ValueNotifier<bool> _notifier;
  final Function(bool? value) _onChanged;

  @override
  StatefulCheckboxState createState() {
    return StatefulCheckboxState();
  }
}

class StatefulCheckboxState extends State<StatefulCheckbox> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget._notifier, 
      builder: (_, active, _) => Checkbox(
        value: active, 
        onChanged: widget._onChanged,
      ),
    );
  }
}