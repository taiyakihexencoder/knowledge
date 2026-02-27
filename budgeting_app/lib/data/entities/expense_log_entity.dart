import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/entities/expense_tag_entity.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';

/// ログ書き込み用データEntity
class ExpenseLogEntity {
  const ExpenseLogEntity({
    required this.amount,
    required this.shop,
    required this.category,
    required this.contents,
    required this.tags,
    required this.usedAt,
});

  /// 消費総額
  final int amount;

  /// 消費先
  final ShopEntity shop;

  /// 消費カテゴリー
  final ExpenseCategoryEntity category;

  /// 消費詳細
  final List<ExpenseLogContentEntity> contents;

  /// タグ
  final List<ExpenseTagEntity> tags;

  /// 日付
  final String usedAt;

  /// Map変換
  Map<String, Object?> get toMap => {
    'amount': amount,
    'shop': shop.toMap,
    'category': category.toMap,
    'contents': contents.map((content) => content.toMap).toList(),
    'tags': tags.map((tag) => tag.toMap).toList(),
  };
}

/// 消費内容詳細
class ExpenseLogContentEntity{
  const ExpenseLogContentEntity({
    required this.title,
    required this.description,
  });

  /// タイトル
  final String title;

  /// 概要
  final String description;

  /// Map変換
  Map<String, Object?> get toMap => {
    'title': title,
    'description': description,
  };
}
