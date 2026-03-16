import 'package:flutter/widgets.dart';

/// AppBarの内容を設定する
class AppBarModel {
  const AppBarModel({
    required this.title,
    this.actions,
  });

  /// AppBarのタイトル
  final String title;

  /// アクションボタン
  final List<AppBarActionModel>? actions;
}

class AppBarActionModel {
  const AppBarActionModel({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final Function() onPressed;
}