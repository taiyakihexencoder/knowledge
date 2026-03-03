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

  /// タグを追加する
  /// 
  /// すでにあるものと重複している場合は追加できずfalse, 
  /// それ以外はtrue
  Future<bool> addTag({
    required String name,
  }) {
    return _expenseTagService.addTag(name: name);
  }

  /// タグを上書きする
  /// 
  /// すでにあるものと重複している場合は追加できずfalse, 
  /// それ以外はtrue
  Future<bool> updateTag({
    required int id,
    required String name,
  }) {
    return _expenseTagService.updateTagName(id: id, name: name);
  }

  /// タグを削除する
  Future<void> deleteTag({
    required int id,
  }) {
    return _expenseTagService.deleteTag(id: id);
  }

}