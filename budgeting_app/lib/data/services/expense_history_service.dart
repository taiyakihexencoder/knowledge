import 'package:budgeting_app/data/entities/expense_history_content_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_log_entity.dart';

abstract interface class ExpenseHistoryService {
  /// 購入履歴を取得。
  /// 
  /// nullの項目は検索条件に含めない。
  /// 
  /// historyIds: 履歴ID（別テーブルのタグリストから逆算して取得する想定）
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
  Future<List<ExpenseHistoryEntity>> getHistoryList({
    Iterable<int>? historyIds,
    int? minAmount,
    int? maxAmount,
    String? minUsedAt,
    String? maxUsedAt,
    Iterable<int>? categories,
    Iterable<int>? shops,
  });

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

  /// 期間内の消費合計金額を取得
  Future<int> getAmountSum({
    required String from, 
    required String to,
  });
}