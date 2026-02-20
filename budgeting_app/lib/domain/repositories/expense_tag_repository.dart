import 'package:budgeting_app/data/services/expense_tag_service.dart';
import 'package:budgeting_app/domain/entities/expense_history_tag_entity.dart';
import 'package:collection/collection.dart';

/// 購入履歴に設定するタグリストRepository
class ExpenseTagRepository {

  const ExpenseTagRepository({
    required ExpenseTagService expenseTagService,
  }): _expenseTagService = expenseTagService;

  final ExpenseTagService _expenseTagService;

  /// 指定した購入履歴に設定されたタグの情報を返す
  /// [ids] 購入履歴IDのリスト
  Map<int, List<ExpenseHistoryTagEntity>> getTags(Iterable<int> ids) {
    String json = _expenseTagService.getExpenseTagList(ids);
    List<ExpenseHistoryTagEntity> entityList = ExpenseHistoryTagEntity.fromListJson(json);
    return entityList.groupListsBy((item) => item.historyId);
  }
}