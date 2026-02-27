import 'package:budgeting_app/data/entities/entity_common.dart';

/// 消費情報登録用タグ情報Entity
class ExpenseTagEntity {
  ExpenseTagEntity({
    required this.id,
    required this.name,
  });

  /// タグID
  final int id;

  /// タグ名
  final String name;

  /// Map変換
  Map<String, Object?> get toMap => {
    'id': id,
    'name': name,
  };

  /// JSONをエンティティに変換
  static ExpenseTagEntity fromJson(String json) => commonDecodeFromJson(json, _fromMap);

  /// JSONをエンティティに変換（リスト）
  static List<ExpenseTagEntity> fromListJson(String json) => commonDecodeFromListJson(json, _fromMap);
  
  static ExpenseTagEntity _fromMap(Map<String, Object?> map) {
    return switch(map) {
      {
        'id': final int id,
        'name': final String name,
      } => ExpenseTagEntity(
        id: id, 
        name: name
      ),

      _ => throw FormatException(),
    };
  }
}