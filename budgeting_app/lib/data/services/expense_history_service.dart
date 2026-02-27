/// 購入履歴のデータソース
class ExpenseHistoryService {
  const ExpenseHistoryService();

  String getHistoryListJson() {
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

  /// ログを登録する
  int createLog({
    required String json,
  }) {
    print(json);
    return 0;
  }
}