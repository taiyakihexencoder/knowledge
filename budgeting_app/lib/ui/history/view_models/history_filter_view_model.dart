import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/core/util/field_notifier.dart';
import 'package:budgeting_app/ui/history/models/history_filter_amount_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_category_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_category_selected_list_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_date_time_range_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_shop_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_shop_selected_list_model.dart';
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
    _usedAt = ValueNotifier(HistoryFilterDateTimeRangeModel()),
    _shops = ValueNotifier([]),
    _categories = ValueNotifier([]),
    _tags = ValueNotifier([]),
    _selectedShops = ValueNotifier(HistoryFilterShopSelectedListModel(selectedList: [])),
    _selectedCategories = ValueNotifier(HistoryFilterCategorySelectedListModel(selectedList: []));

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

  final ValueNotifier<HistoryFilterDateTimeRangeModel> _usedAt;
  /// 日付フィルタの状態
  ValueNotifier<HistoryFilterDateTimeRangeModel> get usedAt => _usedAt;

  late final ValueNotifier<bool> _usedAtFilterActive = _usedAt.map((usedAt) => usedAt.active);
  /// 日付フィルタがアクティブかどうか
  ValueNotifier<bool> get usedAtFilterActive => _usedAtFilterActive;

  final ValueNotifier<List<HistoryFilterShopModel>> _shops;
  /// 購入先リスト
  ValueNotifier<List<HistoryFilterShopModel>> get shops => _shops;

  final ValueNotifier<List<HistoryFilterCategoryModel>> _categories;
  /// カテゴリーリスト
  ValueNotifier<List<HistoryFilterCategoryModel>> get categories => _categories;

  final ValueNotifier<List<HistoryFilterTagModel>> _tags;
  /// タグリスト
  ValueNotifier<List<HistoryFilterTagModel>> get tags => _tags;

  late final ValueNotifier<bool> _shopsFilterActive = _selectedShops.map((shops) => shops.active);
  /// 購入先フィルタがアクティブかどうか
  ValueNotifier<bool> get shopsFilterActive => _shopsFilterActive;

  final ValueNotifier<HistoryFilterShopSelectedListModel> _selectedShops;
  /// 選択済の購入先リスト
  ValueNotifier<HistoryFilterShopSelectedListModel> get selectedShops => _selectedShops;

  late final ValueNotifier<bool> _categoriesFilterActive = _selectedCategories.map((categories) => categories.active);
  // カテゴリーフィルタがアクティブかどうか
  ValueNotifier<bool> get categoriesFilterActive => _categoriesFilterActive;

  final ValueNotifier<HistoryFilterCategorySelectedListModel> _selectedCategories;
  /// 選択済のカテゴリーリスト
  ValueNotifier<HistoryFilterCategorySelectedListModel> get selectedCategories => _selectedCategories;

  void dispose() {
    _amountFilterActive.dispose();
    _amount.dispose();
    _usedAtFilterActive.dispose();
    _usedAt.dispose();
    _shops.dispose();
    _categories.dispose();
    _tags.dispose();
    _shopsFilterActive.dispose();
    _selectedShops.dispose();
    _categoriesFilterActive.dispose();
    _selectedCategories.dispose();
  }

  /// 購入先・カテゴリー・タグのリストを取得する
  Future<void> loadData() async {
    Future fetchShopList = _shopRepository.getAllShopList().then(
      (list) {
        _shops.value = list.map(
          (shop) => HistoryFilterShopModel(
            id: shop.id, 
            name: shop.name,
          ),
        ).toList();
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

  /// 金額範囲の変更
  void onAmountRangeChanged(int min, int max) {
    _amount.value = HistoryFilterAmountModel(
      min: min,
      max: max,
      active: _amount.value.active,
    );
  }

  /// 期間を検索条件に含めるかどうかを変更
  void setDateTimeFilterActive(bool active) {
    if (_usedAt.value.range == null) {
      final DateTime now = DateTime.now();
      final DateTimeRange range = DateTimeRange(
        start: DateTime(now.year, now.month-1, now.day),
        end: now,
      );

      _usedAt.value = HistoryFilterDateTimeRangeModel(
        range: range,
        active: active,
      );
    } else {
      _usedAt.value = HistoryFilterDateTimeRangeModel(
        range: _usedAt.value.range,
        active: active,
      );
    }
  }

  /// 期間範囲の変更
  void onDateTimeRangeChanged(DateTimeRange range) {
    _usedAt.value = HistoryFilterDateTimeRangeModel(
      range: range,
      active: _usedAt.value.active,
    );
  }

  /// 購入先フィルタを検索条件に含めるか変更
  void setShopFilterActive(bool active) {
    _selectedShops.value = HistoryFilterShopSelectedListModel(
      selectedList: _selectedShops.value.selectedList,
      active: active,
    );
  }

  /// 購入先のフィルタ追加
  void onShopSelected(int id) {
    if (!_selectedShops.value.selectedList.contains(id)) {
      _selectedShops.value = HistoryFilterShopSelectedListModel(
        selectedList: _selectedShops.value.selectedList..add(id),
        active: _selectedShops.value.active,
      );
    }
  }

  /// 購入先のフィルタ解除
  void onShopDeselect(int id) {
    if (_selectedShops.value.selectedList.contains(id)) {
      _selectedShops.value = HistoryFilterShopSelectedListModel(
        selectedList: _selectedShops.value.selectedList..remove(id),
        active: _selectedShops.value.active,
      );
    }
  }

  /// カテゴリーフィルタを検索条件に含めるか変更
  void setCategoryFilterActive(bool active) {
    _selectedCategories.value = HistoryFilterCategorySelectedListModel(
      selectedList: _selectedCategories.value.selectedList,
      active: active,
    );
  }

  /// カテゴリーのフィルタ追加
  void onCategorySelected(int id) {
    if (!_selectedCategories.value.selectedList.contains(id)) {
      _selectedCategories.value = HistoryFilterCategorySelectedListModel(
        selectedList: _selectedCategories.value.selectedList..add(id),
        active: _selectedCategories.value.active,
      );
    }
  }

  /// カテゴリーのフィルタ解除
  void onCategoryDeselect(int id) {
    if (_selectedCategories.value.selectedList.contains(id)) {
      _selectedCategories.value = HistoryFilterCategorySelectedListModel(
        selectedList: _selectedCategories.value.selectedList..remove(id),
        active: _selectedCategories.value.active,
      );
    }
  }
}