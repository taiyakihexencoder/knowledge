import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/core/util/field_notifier.dart';
import 'package:budgeting_app/ui/history/models/history_filter_amount_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_category_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_shop_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_tag_model.dart';
import 'package:flutter/material.dart';

class HistoryFilterViewModel {
  HistoryFilterViewModel({
    required ExpenseCategoryRepository categoryRepository,
    required ExpenseTagRepository tagRepository,
    required ShopRepository shopRepository,
    HistoryFilterModel? filter,
  }) : 
    _categoryRepository = categoryRepository,
    _tagRepository = tagRepository,
    _shopRepository = shopRepository,
    _amount = ValueNotifier(HistoryFilterAmountModel()),
    _usedAt = ValueNotifier(null),
    _shops = ValueNotifier([]),
    _categories = ValueNotifier([]),
    _tags = ValueNotifier([]);

  /// 購入カテゴリーReposiotry
  final ExpenseCategoryRepository _categoryRepository;
  
  /// 購入履歴タグRepository
  final ExpenseTagRepository _tagRepository;

  /// 購入先Repository
  final ShopRepository _shopRepository;

  final ValueNotifier<HistoryFilterAmountModel> _amount;
  /// 金額フィルタの状態
  ValueNotifier<HistoryFilterAmountModel> get amount => _amount;
  
  late final ValueNotifier<bool> _amountFilterActive = _amount.map((amount) => amount.active);
  /// 金額フィルタがアクティブかどうか
  ValueNotifier<bool> get amountFilterActive => _amountFilterActive;

  final ValueNotifier<DateTimeRange?> _usedAt;
  /// 日付フィルタの状態
  ValueNotifier<DateTimeRange?> get usedAt => _usedAt;

  final ValueNotifier<List<HistoryFilterShopModel>> _shops;
  /// 購入先リスト
  ValueNotifier<List<HistoryFilterShopModel>> get shops => _shops;

  final ValueNotifier<List<HistoryFilterCategoryModel>> _categories;
  /// カテゴリーリスト
  ValueNotifier<List<HistoryFilterCategoryModel>> get categories => _categories;

  final ValueNotifier<List<HistoryFilterTagModel>> _tags;
  /// タグリスト
  ValueNotifier<List<HistoryFilterTagModel>> get tags => _tags;

  void dispose() {
    _amountFilterActive.dispose();
    _amount.dispose();
    _usedAt.dispose();
    _shops.dispose();
    _categories.dispose();
    _tags.dispose();
  }

  /// 購入先・カテゴリー・タグのリストを取得する
  Future<void> loadData() async {
    Future fetchShopList = _shopRepository.getAllShopList().then(
      (list) => {
        _shops.value = list.map(
          (shop) => HistoryFilterShopModel(
            id: shop.id, 
            name: shop.name,
          ),
        ).toList(),
      }
    );

    Future fetchCategoryList = _categoryRepository.getAllCategoryList().then(
      (list) => {
        _categories.value = list.map(
          (category) => HistoryFilterCategoryModel(
            id: category.id,
            name: category.name,
          ),
        ).toList(),
      }
    );

    Future fetchTagList = _tagRepository.getAllTags().then(
      (list) => {
        _tags.value = list.map(
          (tag) => HistoryFilterTagModel(
            id: tag.id, 
            name: tag.name,
          ),
        ).toList(),
      }
    );

    Future.wait([fetchShopList, fetchCategoryList, fetchTagList]);
  }

  /// 金額を検索条件に含めるかどうかを変更
  void setAmountFilterActive(bool active) {
    _amount.value = HistoryFilterAmountModel(
      min: _amount.value.min,
      max: _amount.value.max,
      active: active,
    );
  }
}