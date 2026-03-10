import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/expense_tag_entity.dart';
import 'package:budgeting_app/data/services/expense_tag_service.dart';

/// 消費履歴タグのデータソース
class MockExpenseTagService implements ExpenseTagService {
  const MockExpenseTagService();

  @override
  Future<List<ExpenseHistoryTagEntity>> getExpenseTagList(Iterable<int> ids) {
    return Future.value(ExpenseHistoryTagEntity.fromListJson(_mockExpenseTagList(ids)));
  }

  String _mockExpenseTagList(Iterable<int> ids) {
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

  @override
  Future<List<ExpenseTagEntity>> getTags(Iterable<int> ids) {
    return getAllExpenseTagList().then(
      (list) => list.where( (tag) => ids.contains(tag.id) ).toList(),
    );
  }

  @override
  Future<List<ExpenseTagEntity>> getAllExpenseTagList() {
    return Future.value(ExpenseTagEntity.fromListJson(_mockAllExpenseTagList()));
  }

  String _mockAllExpenseTagList() {
    return '''
[
  {"id": 1, "name": "外食"},
  {"id": 2, "name": "スーパー"},
  {"id": 3, "name": "接待"},
  {"id": 4, "name": "領収書あり"},
  {"id": 5, "name": "電車"},
  {"id": 6, "name": "往復"},
  {"id": 7, "name": "タクシー"},
  {"id": 8, "name": "固定費"},
  {"id": 9, "name": "家賃"},
  {"id": 10, "name": "サーバー費用"},
  {"id": 11, "name": "Netflix"}
]
''';
  }

  @override
  Future<bool> addTag({
    required String name,
  }) {
    return Future.value(true);
  }

  @override
  Future<bool> updateTagName({
    required int id, 
    required String name,
  }) {
    return Future.value(true);
  }

  @override
  Future<void> deleteTag({
    required int id,
  }) {
    return Future.value();
  }

}