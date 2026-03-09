import 'package:flutter/material.dart';

/// 検索期間モデル
class HistoryFilterDateTimeRangeModel {
  HistoryFilterDateTimeRangeModel({
    this.range,
    this.active = false,
  });

  /// 期間
  final DateTimeRange? range;

  /// 有効かどうか
  final bool active;
}