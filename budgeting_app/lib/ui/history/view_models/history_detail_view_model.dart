import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_content_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';
import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_history_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/history/models/history_detail_model.dart';
import 'package:flutter/material.dart';

class HistoryDetailViewModel {
  HistoryDetailViewModel({
    required int historyId,
    required ExpenseHistoryRepository historyRepository,
    required ExpenseCategoryRepository categoryRepository,
    required ExpenseTagRepository tagRepository,
    required ShopRepository shopRepository,
  }) : 
    _historyId = historyId,
    _historyRepository = historyRepository,
    _categoryRepository = categoryRepository,
    _tagRepository = tagRepository,
    _shopRepository = shopRepository,
    _model = ValueNotifier(null),
    _historyEdited = false;

  final int _historyId;

  /// 購入履歴Repository
  final ExpenseHistoryRepository _historyRepository;

  /// 購入カテゴリーReposiotry
  final ExpenseCategoryRepository _categoryRepository;
  
  /// 購入履歴タグRepository
  final ExpenseTagRepository _tagRepository;

  /// 購入先Repository
  final ShopRepository _shopRepository;

  final ValueNotifier<HistoryDetailModel?> _model;
  ValueNotifier<HistoryDetailModel?> get model => _model;

  bool _historyEdited;
  /// 履歴が編集画面で編集されたか
  bool get historyEdited => _historyEdited;

  void dispose() {
    _model.dispose();
  }

  /// 詳細情報の取得
  void init() async {
    ExpenseHistoryEntity? history = await _historyRepository.getHistory(historyId: _historyId);
    if (history == null) {
      _model.value = null;
    } else {
      Map<int, List<ExpenseHistoryTagEntity>> tagMap = await _tagRepository.getTags([history.id]);
      Future<ExpenseCategoryEntity?> category = _categoryRepository.getCategory(history.categoryId);
      Future<ShopEntity?> shop = _shopRepository.getShop(history.shopId);
      Future<List<ExpenseHistoryContentEntity>> contents = _historyRepository.getHistoryContents(historyId: history.id);

      model.value = HistoryDetailModel.from(
        expenseHistory: history,
        expenseCategory: await category,
        shop: await shop,
        expenseTags: tagMap[history.id] ?? [],
        expenseContents: await contents,
      );
    }
  }

  void onHistoryEdited() {
    _historyEdited = true;
  }
}