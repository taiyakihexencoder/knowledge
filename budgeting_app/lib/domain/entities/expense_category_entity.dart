import 'package:budgeting_app/domain/entities/entity_common.dart';

/// 消費カテゴリEntity
class ExpenseCategoryEntity {
  ExpenseCategoryEntity({
    required this.id,
    required this.name,
  });

  /// カテゴリーID
  final int id;

  /// カテゴリー名
  final String name;

  /// Map変換
  Map<String, Object?> get toMap => {
    'id': id,
    'name': name,
  };

  /// JSONをエンティティに変換
  static ExpenseCategoryEntity fromJson(String json) => commonDecodeFromJson(json, _fromMap);

  /// JSONをエンティティに変換（リスト）
  static List<ExpenseCategoryEntity> fromListJson(String json) => commonDecodeFromListJson(json, _fromMap);

  static ExpenseCategoryEntity _fromMap(Map<String, Object?> map) {
    return switch (map) {
      {
        'id': final int id,
        'name': final String name,
      } => ExpenseCategoryEntity(
        id: id, 
        name: name
      ),
      _ => throw FormatException(),
    };
  }
}