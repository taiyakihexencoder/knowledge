import 'package:budgeting_app/ui/core/models/filter/amount_filter_model.dart';
import 'package:budgeting_app/ui/core/models/filter/category_filter_model.dart';
import 'package:budgeting_app/ui/core/models/filter/date_filter_model.dart';
import 'package:budgeting_app/ui/core/models/filter/shop_filter_model.dart';
import 'package:budgeting_app/ui/core/models/filter/tag_filter_model.dart';

class SearchFilterModel {
  const SearchFilterModel({
    required this.amount,
    required this.usedAt,
    required this.shops,
    required this.categories,
    required this.tags,
  });

  /// 空のフィルター
  const SearchFilterModel.empty() : this(
    amount: const AmountFilterModel(),
    usedAt: const DateFilterModel(),
    shops: const ShopFilterModel(selectedList: []),
    categories: const CategoryFilterModel(selectedList: []),
    tags: const TagFilterModel(selectedList: []),
  );

  /// 金額フィルター
  final AmountFilterModel amount;

  /// 日付フィルター
  final DateFilterModel usedAt;

  /// 購入先フィルター
  final ShopFilterModel shops;

  /// カテゴリーフィルター
  final CategoryFilterModel categories;

  /// タグフィルター
  final TagFilterModel tags;

  /// フィルターが有効かどうか
  bool valid() {
    return (amount.active && amount.min <= amount.max) ||
      (usedAt.active && usedAt.range != null) ||
      (shops.active && shops.selectedList.isNotEmpty) ||
      (categories.active && categories.selectedList.isNotEmpty) ||
      (tags.active && tags.selectedList.isNotEmpty);
  }
}