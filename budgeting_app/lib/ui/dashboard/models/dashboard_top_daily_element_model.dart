import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';

/// １つの消費履歴を表示するData Model
class DashboardTopDailyElementModel {
  const DashboardTopDailyElementModel({
    required this.id,
    required this.category,
    required this.shop,
    required this.amount,
    required this.tags,
  });

  DashboardTopDailyElementModel.from({
    required ExpenseHistoryEntity expenseHistory,
    required ExpenseCategoryEntity? expenseCategory,
    required ShopEntity? shop,
    required Iterable<ExpenseHistoryTagEntity> expenseTags
  }) : this(
    id: expenseHistory.id,
    category: expenseCategory?.name,
    shop: shop?.name,
    amount: expenseHistory.amount,
    tags: expenseTags.map((tag) => tag.name).toList(),
  );

  /// 履歴ID
  final int id;

  /// カテゴリー
  final String? category;

  /// 購入先
  final String? shop;

  /// 購入総額
  final int amount;

  /// 設定されたタグ
  final List<String> tags;
}
