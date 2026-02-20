import 'package:budgeting_app/domain/entities/expense_history_entity.dart';
import 'package:budgeting_app/domain/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_history_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/history/models/history_model.dart';

class HistoryListViewModel {
  HistoryListViewModel({
    required ExpenseHistoryRepository historyRepository,
    required ExpenseCategoryRepository categoryRepository,
    required ExpenseTagRepository tagRepository,
    required ShopRepository shopRepository,
  }) : 
  _historyRepository = historyRepository,
  _categoryRepository = categoryRepository,
  _tagRepository = tagRepository,
  _shopRepository = shopRepository,
  _models = const [];

  /// 購入履歴Repository
  final ExpenseHistoryRepository _historyRepository;

  /// 購入カテゴリーReposiotry
  final ExpenseCategoryRepository _categoryRepository;
  
  /// 購入履歴タグRepository
  final ExpenseTagRepository _tagRepository;

  /// 購入先Repository
  final ShopRepository _shopRepository;

  List<HistoryModel> _models;
  List<HistoryModel> get models => _models;

  void refreshList() {
    List<ExpenseHistoryEntity> historyList = _historyRepository.getHistoryList();
    Map<int, List<ExpenseHistoryTagEntity>> tagMap = _tagRepository.getTags(
      historyList.map(
        (history) => history.id
      )
    );

    _models = historyList.map(
      (history) => HistoryModel.from(
        expenseHistory: history,
        expenseCategory: _categoryRepository.getCategory(history.categoryId),
        shop: _shopRepository.getShop(history.shopId),
        expenseTags: tagMap[history.id] ?? [],
      )
    ).toList();
  }
}