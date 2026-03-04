
import 'package:budgeting_app/data/entities/entity_common.dart';

/// 消費詳細Entity
class ExpenseHistoryContentEntity {
  ExpenseHistoryContentEntity({
    required this.id,
    required this.historyId,
    required this.title,
    required this.description,
  });

  /// ID
  final int id;

  /// 消費情報ID(ExpenseHistoryEntity)
  final int historyId;

  /// 詳細タイトル
  final String title;

  /// 詳細概要
  final String description;

  static ExpenseHistoryContentEntity fromJson(String json) => commonDecodeFromJson(json, _fromMap);

  static List<ExpenseHistoryContentEntity> fromListJson(String json) => commonDecodeFromListJson(json, _fromMap);

  static ExpenseHistoryContentEntity _fromMap(Map<String, Object?> map) {
    return switch(map) {
      {
        'id': final int id,
        'history_id': final int historyId,
        'title': final String title,
        'description': final String description,
      } => ExpenseHistoryContentEntity(
        id: id,
        historyId: historyId, 
        title: title, 
        description: description
      ),
      _ => throw FormatException(),
    };
  }
}