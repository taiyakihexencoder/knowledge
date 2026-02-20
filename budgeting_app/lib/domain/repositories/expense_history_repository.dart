import 'package:budgeting_app/data/services/expense_history_service.dart';
import 'package:budgeting_app/domain/entities/expense_history_entity.dart';

/// 購入履歴情報Repository
class ExpenseHistoryRepository {

  const ExpenseHistoryRepository({
    required ExpenseHistoryService historyService,
  }): _historyService = historyService;

  final ExpenseHistoryService _historyService;

  /// 購入履歴リストを取得する
  List<ExpenseHistoryEntity> getHistoryList() {
    String json = _historyService.getHistoryListJson();
    return ExpenseHistoryEntity.fromListJson(json);
  }
}