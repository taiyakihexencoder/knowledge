import 'package:budgeting_app/data/services/expense_tag_service.dart';
import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/expense_tag_entity.dart';
import 'package:collection/collection.dart';

/// 購入履歴に設定するタグリストRepository
class ExpenseTagRepository {

  const ExpenseTagRepository({
    required ExpenseTagService expenseTagService,
  }): _expenseTagService = expenseTagService;

  final ExpenseTagService _expenseTagService;

  /// 指定した購入履歴に設定されたタグの情報を返す
  /// [ids] 購入履歴IDのリスト
  Future<Map<int, List<ExpenseHistoryTagEntity>>> getTags(Iterable<int> ids) {
    Future<List<ExpenseHistoryTagEntity>> entityList = _expenseTagService.getExpenseTagList(ids);
    return entityList.then(
      (list) => list.groupListsBy((item) => item.historyId),
    );
  }

  /// 登録済のすべてのタグを取得する
  Future<List<ExpenseTagEntity>> getAllTags() {
    return _expenseTagService.getAllExpenseTagList();
  }
}