import 'package:flutter/material.dart';

/// 日付の表示タイプ
enum DateType {
  /// 通常
  normal(
    bgColor: Colors.transparent,
    fgColor: Colors.grey
  ),

  /// 日曜日・祝日
  red(
    bgColor: Color.from(red:1.0, green: 0.25, blue: 0.25, alpha: 0.5),
    fgColor: Color.from(red: 0.75, green: 0.0, blue: 0.0, alpha: 1.0),
  ),
  blue(
    bgColor: Color.from(red:0.25, green: 0.25, blue: 1.0, alpha: 0.5),
    fgColor: Color.from(red:0.0, green:0.0, blue: 0.5, alpha: 1.0),
  );

  /// 土曜日
  const DateType({
    required this.bgColor,
    required this.fgColor,
  });

  /// 背景色
  final Color bgColor;

  /// 文字色
  final Color fgColor;
}