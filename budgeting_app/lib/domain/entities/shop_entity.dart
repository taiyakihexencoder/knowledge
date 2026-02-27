import 'package:budgeting_app/domain/entities/entity_common.dart';

/// 購入先Entity
class ShopEntity {
  ShopEntity({
    required this.id,
    required this.name,
  });

  /// 購入先ID
  final int id;

  /// 購入先の名称
  final String name;

  /// Map変換
  Map<String, Object?> get toMap => {
    'id': id,
    'name': name,
  };

  /// JSONをエンティティに変換
  static ShopEntity fromJson(String json) => commonDecodeFromJson(json, _fromMap);

  // JSONをエンティティに変換（リスト）
  static List<ShopEntity> fromListJson(String json) => commonDecodeFromListJson(json, _fromMap);

  static ShopEntity _fromMap(Map<String, Object?> map) {
    return switch (map) {
      {
        'id': final int id,
        'name': final String name,  
      } => ShopEntity(
        id: id, 
        name: name
      ),
      _ => throw FormatException(),
    };
  }
}