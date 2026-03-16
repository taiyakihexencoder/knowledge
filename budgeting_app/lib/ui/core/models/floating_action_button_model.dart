import 'package:flutter/widgets.dart';

/// Floating Action Buttonの内容を定義する
class FloatingActionButtonModel {
  const FloatingActionButtonModel({
    required this.icon,
    required this.heroTag,
    required this.onPressed,
  });

  final IconData icon;
  final String heroTag;
  final Function() onPressed;
}