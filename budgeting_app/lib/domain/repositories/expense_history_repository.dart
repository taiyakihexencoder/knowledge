import 'package:budgeting_app/data/entities/expense_history_content_entity.dart';
import 'package:budgeting_app/data/services/expense_history_service.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_log_entity.dart';

/// 購入履歴情報Repository
class ExpenseHistoryRepository {

  const ExpenseHistoryRepository({
    required ExpenseHistoryService historyService,
  }): _historyService = historyService;

  final ExpenseHistoryService _historyService;

  /// 購入履歴リストを取得する
  Future<List<ExpenseHistoryEntity>> getHistoryList() {
    return _historyService.getHistoryList();
  }

  /// 指定した購入履歴を取得する
  Future<ExpenseHistoryEntity?> getHistory({
    required int historyId,
  }) {
    return _historyService.getHistory(historyId: historyId);
  }

  /// 購入詳細を取得する
  Future<List<ExpenseHistoryContentEntity>> getHistoryContents({
    required int historyId,
  }) {
    return _historyService.getHistoryContents(historyId: historyId);
  }

  /// ログを追加
  Future<int> createLog({
    required ExpenseLogEntity log,
  }) {
    return _historyService.createLog(log: log);
  }
}