import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// @PreviewでValueListenableを渡したいときの仮パーツ
class PreviewListenableProvider<T> extends StatefulWidget {
  PreviewListenableProvider({
    super.key,
    required Widget Function(ValueListenable<T> listenable) builder,
    required T value,
  }): _builder = builder, _notifier = ValueNotifier(value);

  final Widget Function(ValueListenable<T> listenable) _builder;
  final ValueNotifier<T> _notifier;

  @override
  PreviewListenableProviderState<T> createState() {
    return PreviewListenableProviderState<T>();
  }
}

class PreviewListenableProviderState<T> extends State<PreviewListenableProvider<T>> {
  @override
  void dispose() {
    widget._notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(widget._notifier);
  }
}