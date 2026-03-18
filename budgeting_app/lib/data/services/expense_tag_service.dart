import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/expense_tag_entity.dart';

abstract interface class ExpenseTagService {
  Future<List<ExpenseHistoryTagEntity>> getExpenseTagList(Iterable<int> ids);
  Future<List<ExpenseTagEntity>> getTags(Iterable<int> ids);
  Future<List<ExpenseTagEntity>> getAllExpenseTagList();

  /// タグIDからそのタグが付いた履歴IDを取得する
  Future<List<int>> getAssignedHistoryIds(Iterable<int> tagIds);

  /// タグの追加
  /// 
  /// 他と重複する名称になる場合は失敗
  Future<ExpenseTagEntity?> addTag({
    required String name,
  });

  /// タグの名称変更
  /// 
  /// 他と重複する名称になる場合はfalse
  Future<bool> updateTagName({
    required int id, 
    required String name,
  });

  /// タグの削除
  Future<void> deleteTag({
    required int id,
  });

}