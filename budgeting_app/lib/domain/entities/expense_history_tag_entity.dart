import 'package:budgeting_app/domain/entities/entity_common.dart';

/// 消費情報タグEntity
class ExpenseHistoryTagEntity {
  ExpenseHistoryTagEntity({
    required this.id,
    required this.historyId,
    required this.name,
  });

  /// タグID
  final int id;

  /// 購入履歴ID
  final int historyId;

  /// タグ名
  final String name;

  /// JSONをエンティティに変換
  static ExpenseHistoryTagEntity fromJson(String json) => commonDecodeFromJson(json, _fromMap);

  /// JSONをエンティティに変換（リスト）
  static List<ExpenseHistoryTagEntity> fromListJson(String json) => commonDecodeFromListJson(json, _fromMap);
  
  static ExpenseHistoryTagEntity _fromMap(Map<String, Object?> map) {
    return switch(map) {
      {
        'id': final int id,
        'history_id': final int historyId,
        'name': final String name,
      } => ExpenseHistoryTagEntity(
        id: id, 
        historyId: historyId, 
        name: name
      ),

      _ => throw FormatException(),
    };
  }
}