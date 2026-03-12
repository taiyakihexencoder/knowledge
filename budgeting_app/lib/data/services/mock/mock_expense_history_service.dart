import 'dart:convert';

import 'package:budgeting_app/data/entities/expense_history_content_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_log_entity.dart';
import 'package:budgeting_app/data/services/expense_history_service.dart';

/// 購入履歴のデータソース
class MockExpenseHistoryService implements ExpenseHistoryService {
  const MockExpenseHistoryService();

  @override
  Future<List<ExpenseHistoryEntity>> getHistoryList({
    Iterable<int>? historyIds,
    int? minAmount,
    int? maxAmount,
    String? minUsedAt,
    String? maxUsedAt,
    Iterable<int>? categories,
    Iterable<int>? shops,
  }) {
    return Future.value(ExpenseHistoryEntity.fromListJson(_mockHistoryList()));
  }

  String _mockHistoryList() {
    return 
'''
[
  { "id": 1, "category_id": 1, "shop_id": 1, "amount": 100, "used_at": "20260101" },
  { "id": 2, "category_id": 2, "shop_id": 2, "amount": 100, "used_at": "20260102" },
  { "id": 3, "category_id": 3, "shop_id": 3, "amount": 200, "used_at": "20260103" },
  { "id": 4, "category_id": 4, "shop_id": 1, "amount": 300, "used_at": "20260104" },
  { "id": 5, "category_id": 1, "shop_id": 2, "amount": 500, "used_at": "20260105" },
  { "id": 6, "category_id": 2, "shop_id": 3, "amount": 800, "used_at": "20260106" },
  { "id": 7, "category_id": 3, "shop_id": 1, "amount": 1300, "used_at": "20260107" },
  { "id": 8, "category_id": 4, "shop_id": 2, "amount": 2100, "used_at": "20260108" },
  { "id": 9, "category_id": 1, "shop_id": 3, "amount": 3400, "used_at": "20260109" },
  { "id": 10, "category_id": 2, "shop_id": 1, "amount": 5500, "used_at": "20260110" },
  { "id": 11, "category_id": 1, "shop_id": 1, "amount": 8900, "used_at": "20260111" },
  { "id": 12, "category_id": 2, "shop_id": 2, "amount": 14400, "used_at": "20260112" },
  { "id": 13, "category_id": 3, "shop_id": 3, "amount": 23300, "used_at": "20260113" },
  { "id": 14, "category_id": 4, "shop_id": 1, "amount": 37700, "used_at": "20260114" },
  { "id": 15, "category_id": 1, "shop_id": 2, "amount": 61000, "used_at": "20260115" },
  { "id": 16, "category_id": 2, "shop_id": 3, "amount": 98700, "used_at": "20260116" },
  { "id": 17, "category_id": 3, "shop_id": 1, "amount": 159700, "used_at": "20260117" },
  { "id": 18, "category_id": 4, "shop_id": 2, "amount": 258400, "used_at": "20260118" },
  { "id": 19, "category_id": 1, "shop_id": 3, "amount": 418100, "used_at": "20260119" },
  { "id": 20, "category_id": 2, "shop_id": 1, "amount": 676500, "used_at": "20260120" }
]
''';
  }

  @override
  Future<ExpenseHistoryEntity?> getHistory({
    required int historyId,
  }) {
    return Future.value(ExpenseHistoryEntity.fromJson(_mockHistory()));
  }

  String _mockHistory() {
    return '{ "id": 1, "category_id": 1, "shop_id": 1, "amount": 100, "used_at": "20260101" }';
  }

  @override
  Future<List<ExpenseHistoryContentEntity>> getHistoryContents({
    required int historyId,
  }) {
    return Future.value(ExpenseHistoryContentEntity.fromListJson(_mockHistoryContent()));
  }

  String _mockHistoryContent() {
    return
      '[' 
      '{ "id": 1, "history_id": 1, "title": "タイトル1", "description": "説明"},'
      '{ "id": 2, "history_id": 1, "title": "タイトル2", "description": "説明2"}'
      ']';
  }

  @override
  /// ログを登録する
  Future<int> createLog({
    required ExpenseLogEntity log,
  }) {
    return Future.value(createLogJson(json: jsonEncode(log.toMap)));
  }

  int createLogJson({
    required String json,
  }) {
    print(json);
    return 0;
  }

  @override
  Future<void> updateLog({
    required int id,
    required ExpenseLogEntity log,
  }) {
    return Future.value();
  }

  @override
  Future<int> getAmountSum({
    required String from,
    required String to,
  }) {
    return Future.value(123456);
  }
}