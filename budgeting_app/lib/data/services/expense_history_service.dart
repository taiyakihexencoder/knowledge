import 'package:budgeting_app/data/entities/expense_history_content_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_log_entity.dart';

abstract interface class ExpenseHistoryService {
  /// 購入履歴を取得
  Future<List<ExpenseHistoryEntity>> getHistoryList();

  /// 購入記録を取得
  Future<ExpenseHistoryEntity?> getHistory({
    required int historyId,
  });

  /// 購入記録から詳細のリストを取得
  Future<List<ExpenseHistoryContentEntity>> getHistoryContents({
    required int historyId,
  });

  /// 購入記録を作成
  Future<int> createLog({
    required ExpenseLogEntity log,
  });

  /// 購入記録を更新
  Future<void> updateLog({
    required int id,
    required ExpenseLogEntity log,
  });
}