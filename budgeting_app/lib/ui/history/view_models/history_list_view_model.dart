import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';
import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_history_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/core/models/filter/search_filter_model.dart';
import 'package:budgeting_app/ui/history/models/history_model.dart';
import 'package:flutter/material.dart';

class HistoryListViewModel {
  HistoryListViewModel({
    required ExpenseHistoryRepository historyRepository,
    required ExpenseCategoryRepository categoryRepository,
    required ExpenseTagRepository tagRepository,
    required ShopRepository shopRepository,
    SearchFilterModel? searchFilter,
  }) : 
    _historyRepository = historyRepository,
    _categoryRepository = categoryRepository,
    _tagRepository = tagRepository,
    _shopRepository = shopRepository,
    _models = ValueNotifier([]),
    _searchFilter = searchFilter;

  /// 購入履歴Repository
  final ExpenseHistoryRepository _historyRepository;

  /// 購入カテゴリーReposiotry
  final ExpenseCategoryRepository _categoryRepository;
  
  /// 購入履歴タグRepository
  final ExpenseTagRepository _tagRepository;

  /// 購入先Repository
  final ShopRepository _shopRepository;

  final ValueNotifier<List<HistoryModel>> _models;
  ValueNotifier<List<HistoryModel>> get models => _models;

  /// 表示条件
  final SearchFilterModel? _searchFilter;
  SearchFilterModel? get searchFilter => _searchFilter;

  void dispose() {
    _models.dispose();
  }

  /// 履歴リストの更新
  void refreshList() async {
    List<ExpenseHistoryEntity> historyList = await _historyRepository.getHistoryList();
    Map<int, List<ExpenseHistoryTagEntity>> tagMap = await _tagRepository.getTags(
      historyList.map(
        (history) => history.id
      )
    );

    List<HistoryModel> modelList = [];
    for (ExpenseHistoryEntity history in historyList) {
      Future<ExpenseCategoryEntity?> category = _categoryRepository.getCategory(history.categoryId);
      Future<ShopEntity?> shop = _shopRepository.getShop(history.shopId);
      modelList.add(
        HistoryModel.from(
          expenseHistory: history,
          expenseCategory: await category,
          shop: await shop,
          expenseTags: tagMap[history.id] ?? [],
        )
      );
    }
    _models.value = modelList;
  }
}