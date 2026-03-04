import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_content_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';

/// 購入詳細のモデル
class HistoryDetailModel {
  const HistoryDetailModel({
    required this.id,
    required this.category,
    required this.shop,
    required this.amount,
    required this.usedAt,
    required this.tags,
    required this.contents,
  });

  /// エンティティから変換
  HistoryDetailModel.from({
    required ExpenseHistoryEntity expenseHistory,
    required ExpenseCategoryEntity? expenseCategory,
    required ShopEntity? shop,
    required Iterable<ExpenseHistoryTagEntity> expenseTags,
    required Iterable<ExpenseHistoryContentEntity> expenseContents,
  }) : this(
    id: expenseHistory.id,
    category: expenseCategory?.name,
    shop: shop?.name,
    amount: expenseHistory.amount,
    usedAt: expenseHistory.usedAt,
    tags: expenseTags.map((tag) => tag.name).toList(),
    contents: expenseContents.map(
      (content) => HistoryDetailContentModel.from(content: content)
    ).toList(),
  );

  /// 履歴ID
  final int id;

  /// カテゴリー
  final String? category;

  /// 購入先
  final String? shop;

  /// 購入総額
  final int amount;

  /// 購入日
  final String usedAt;

  /// 設定されたタグ
  final List<String> tags;

  /// 詳細
  final List<HistoryDetailContentModel> contents;
}

/// 購入詳細UIのモデル
class HistoryDetailContentModel {
  const HistoryDetailContentModel ({
    required this.title,
    required this.description,
  });

  /// エンティティから変換
  HistoryDetailContentModel.from({
    required ExpenseHistoryContentEntity content
  }) : this(
    title: content.title,
    description: content.description,
  );

  /// 詳細タイトル
  final String title;

  /// 詳細説明
  final String description;
}