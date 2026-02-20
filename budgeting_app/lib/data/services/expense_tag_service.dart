/// 消費履歴タグのデータソース
class ExpenseTagService {
  const ExpenseTagService();

  String getExpenseTagList(Iterable<int> ids) {
    return '''[
  {"history_id": 1, "id": 1, "name": "外食" },
  {"history_id": 1, "id": 2, "name": "スーパー" },
  {"history_id": 3, "id": 8, "name": "固定費" },
  {"history_id": 3, "id": 9, "name": "家賃" },
  {"history_id": 4, "id": 5, "name": "電車" },
  {"history_id": 4, "id": 6, "name": "往復" },
  {"history_id": 5, "id": 2, "name": "スーパー" },
  {"history_id": 8, "id": 5, "name": "電車" },
  {"history_id": 8, "id": 6, "name": "往復" },
  {"history_id": 9, "id": 2, "name": "スーパー" },
  {"history_id": 11, "id": 1, "name": "外食" },
  {"history_id": 11, "id": 3, "name": "接待" },
  {"history_id": 11, "id": 4, "name": "領収書あり" },
  {"history_id": 13, "id": 8, "name": "固定費" },
  {"history_id": 13, "id": 10, "name": "サーバー費用" },
  {"history_id": 14, "id": 7, "name": "タクシー" },
  {"history_id": 15, "id": 2, "name": "スーパー" },
  {"history_id": 17, "id": 8, "name": "固定費" },
  {"history_id": 17, "id": 11, "name": "Netflix" },
  {"history_id": 18, "id": 5, "name": "電車" },
  {"history_id": 19, "id": 1, "name": "外食" }
]''';
  }
}