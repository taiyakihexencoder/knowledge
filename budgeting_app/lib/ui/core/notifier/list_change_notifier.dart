import 'package:flutter/material.dart';

class ListChangeNotifier<T> extends ChangeNotifier {
  ListChangeNotifier({
    List<T> list = const [],
  }) : _list = list;

  final List<T> _list;
  List<T> get list => _list;
  set list(List<T> list) {
    if (_list != list) {
      _list.clear();
      _list.addAll(list);
      notifyListeners();
    }
  }

  void add(T element) {
    _list.add(element);
    notifyListeners();
  }

  bool remove(T element) {
    if (_list.remove(element)) {
      notifyListeners();
      return true;
    }
    return false;
  }

  void operator []=(int index, T value) {
    if (_list[index] != value) {
      _list[index] = value;
      notifyListeners();
    }
  }
}