import 'package:budgeting_app/ui/history/models/history_filter_amount_model.dart';

/// 画面間でやり取りするフィルター情報
class HistoryFilterModel {
  const HistoryFilterModel({
    required this.amountRange,
  });

  final HistoryFilterAmountModel amountRange;
}
