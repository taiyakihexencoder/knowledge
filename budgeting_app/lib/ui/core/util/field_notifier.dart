import 'package:flutter/foundation.dart';

/// ValueNotifierから一部のパラメーターをValueListenableとして観測できるようにするクラス
class FieldNotifier<T, F> extends ValueNotifier<F> {
  FieldNotifier(
    ValueListenable<T> parent,
    F Function(T) selector,
  ): 
    _parent = parent, 
    _selector = selector,
    _prev = selector(parent.value),
    super(selector(parent.value))
  {
    _parent.addListener(_update);
  }

  final ValueListenable<T> _parent;
  final F Function(T) _selector;
  F _prev;

  void _update() {
    final newValue = _selector(_parent.value);
    if (_prev != newValue) {
      _prev = newValue;
      notifyListeners();
    }
  }

  @override
  F get value => _selector(_parent.value);

  @override
  void dispose() {
    _parent.removeListener(_update);
    super.dispose();
  }
}

/// ValueNotifierから一部のパラメーターをValueListenableとして観測できるようにする
extension FieldNotifierConversion<T> on ValueListenable<T> {
  FieldNotifier<T, F> map<F>(F Function(T) selector) => FieldNotifier(this, selector);
}