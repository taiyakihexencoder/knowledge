import 'package:budgeting_app/domain/entities/entity_common.dart';

/// 消費情報Entity
class ExpenseHistoryEntity {
  ExpenseHistoryEntity({
    required this.id,
    required this.categoryId,
    required this.shopId,
    required this.amount,
    required this.usedAt,
  });

  /// 消費情報ID
  final int id;

  /// 消費カテゴリー(ExpenseCategoryEntity)
  final int categoryId;

  /// 消費先(ShopEntity)
  final int shopId;

  /// 購入総額
  final int amount;

  /// 消費した日
  final String usedAt;

  /// JSONをエンティティに変換
  static ExpenseHistoryEntity fromJson(String json) => commonDecodeFromJson(json, _fromMap);

  /// JSONをエンティティに変換（リスト）
  static List<ExpenseHistoryEntity> fromListJson(String json) => commonDecodeFromListJson(json, _fromMap);

  static ExpenseHistoryEntity _fromMap(Map<String, Object?> map) {
    return switch (map) {
      {
        'id': final int id,
        'category_id': final int categoryId,
        'shop_id': final int shopId,
        'amount': final int amount,
        'used_at': final String usedAt,
      } => ExpenseHistoryEntity(
        id: id, 
        categoryId: categoryId, 
        shopId: shopId, 
        amount: amount, 
        usedAt: usedAt
      ),
      _ => throw FormatException(),
    };
  }
}