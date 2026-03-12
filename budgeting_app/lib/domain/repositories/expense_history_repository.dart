import 'package:budgeting_app/data/entities/expense_history_content_entity.dart';
import 'package:budgeting_app/data/services/expense_history_service.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_log_entity.dart';
import 'package:budgeting_app/data/services/expense_tag_service.dart';

/// 購入履歴情報Repository
class ExpenseHistoryRepository {

  const ExpenseHistoryRepository({
    required ExpenseHistoryService historyService,
    required ExpenseTagService tagService,
  }):
    _historyService = historyService,
    _tagService = tagService;

  final ExpenseHistoryService _historyService;
  final ExpenseTagService _tagService;

  /// 購入履歴リストを取得する。
  /// 
  /// nullの項目は検索条件に含めない。
  /// 
  /// minAmount: 最低金額（境界値含）
  /// 
  /// maxAmount: 最高金額（境界値含）
  /// 
  /// minUsedAt: 最古の日付（境界値含）
  /// 
  /// maxUsedAt: 最新の日付（境界値含）
  /// 
  /// categories: 対象となるカテゴリーのID
  /// 
  /// shops: 対象となる購入先のID
  /// 
  /// tags: 対象となるタグのID
  Future<List<ExpenseHistoryEntity>> getHistoryList({
    int? minAmount,
    int? maxAmount,
    String? minUsedAt,
    String? maxUsedAt,
    Iterable<int>? categories,
    Iterable<int>? shops,
    Iterable<int>? tags,
  }) async {
    // タグは別テーブル管理。
    // タグIDから履歴IDを限定する。
    List<int>? historyIds = (tags == null || tags.isEmpty) 
      ? null
      : await _tagService.getAssignedHistoryIds(tags);

    return _historyService.getHistoryList(
      historyIds: historyIds,
      minAmount: minAmount,
      maxAmount: maxAmount,
      minUsedAt: minUsedAt,
      maxUsedAt: maxUsedAt,
      categories: categories,
      shops: shops,
    );
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

  // ログを更新
  Future<void> updateLog({
    required int id,
    required ExpenseLogEntity log,
  }) {
    return _historyService.updateLog(id: id, log: log);
  }

  // 指定した期間の合計金額
  Future<int> getAmountSum({
    required String from,
    required String to,
  }) {
    try {
      return _historyService.getAmountSum(from: from, to: to);
    } on Exception catch (e){
      print(e);
      return Future.value(0);
    }
  }
}