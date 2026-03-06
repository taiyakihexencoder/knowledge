import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/entities/expense_log_entity.dart';
import 'package:budgeting_app/data/entities/expense_tag_entity.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';
import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_history_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/new_log/models/category_model.dart';
import 'package:budgeting_app/ui/new_log/models/log_model.dart';
import 'package:budgeting_app/ui/new_log/models/shop_model.dart';
import 'package:budgeting_app/ui/new_log/models/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewLogViewModel {
  NewLogViewModel({
    required ExpenseHistoryRepository historyRepository,
    required ExpenseCategoryRepository categoryRepository,
    required ExpenseTagRepository tagRepository,
    required ShopRepository shopRepository,
  }):
  _historyRepository = historyRepository,
  _categoryRepository = categoryRepository,
  _tagRepository = tagRepository,
  _shopRepository = shopRepository,
  _categorySelections = ValueNotifier([]),
  _tagSelections = ValueNotifier([]),
  _shopSelections = ValueNotifier([]);

  /// 購入履歴Repository
  final ExpenseHistoryRepository _historyRepository;

  /// 購入カテゴリーReposiotry
  final ExpenseCategoryRepository _categoryRepository;
  
  /// 購入履歴タグRepository
  final ExpenseTagRepository _tagRepository;

  /// 購入先Repository
  final ShopRepository _shopRepository;

  /// カテゴリーの選択肢
  final ValueNotifier<List<CategoryModel>> _categorySelections;
  ValueNotifier<List<CategoryModel>> get categorySelections => _categorySelections;

  /// タグの選択肢
  final ValueNotifier<List<TagModel>> _tagSelections;
  ValueNotifier<List<TagModel>> get tagSelections => _tagSelections;

  /// 購入先の選択肢
  final ValueNotifier<List<ShopModel>> _shopSelections;
  ValueNotifier<List<ShopModel>> get shopSelections => _shopSelections;

  /// カテゴリーリストを更新する
  void refreshCategoryList() async {
    List<ExpenseCategoryEntity> categoryList = await _categoryRepository.getAllCategoryList();
    _categorySelections.value = categoryList.map(
      (category) => CategoryModel(
        id: category.id, 
        name: category.name,
      ),
    ).toList();
  }

  /// タグリストを更新する
  void refreshTagList() async {
    List<ExpenseTagEntity> tagList = await _tagRepository.getAllTags();
    _tagSelections.value = tagList.map(
      (tag)=> TagModel(
        id: tag.id, 
        name: tag.name,
      ),
    ).toList();
  }

  /// 購入先リストを更新する
  void refreshShopList() async {
    List<ShopEntity> shopList = await _shopRepository.getAllShopList();
    _shopSelections.value = shopList.map(
      (shop) => ShopModel(
        id: shop.id,
        name: shop.name,
      ),
    ).toList();
  }

  /// 新規追加時のアクション
  void onRequestAddLog(LogModel log) async {
    await _historyRepository.createLog(
      log: ExpenseLogEntity(
        amount: log.amount, 
        shop: ShopEntity(id: log.shop!.id, name: log.shop!.name), 
        category: ExpenseCategoryEntity(id: log.category!.id, name: log.category!.name), 
        contents: log.contents.where((content) => content.title.isNotEmpty).map(
          (content) => ExpenseLogContentEntity(
            title: content.title, 
            description: content.description,
          ),
        ).toList(), 
        tags: log.tags.nonNulls.map(
          (tag) => ExpenseTagEntity(
            id: tag.id,
            name: tag.name,
          ),
        ).toList(), 
        usedAt: log.usedAt,
      ),
    );
  }

  /// 購入先を追加
  /// 
  /// 追加後にリストを更新する
  Future<void> onRequestAddShopName(String name) async {
    bool result = await _shopRepository.addShop(name: name);
    if (result) {
      refreshShopList();
    }
  }

  /// カテゴリーの追加
  /// 
  /// 追加後にリストを更新する
  Future<void> onRequestAddCategoryName(String name) async {
    bool result = await _categoryRepository.addCategory(name: name);
    if (result) {
      refreshCategoryList();
    }
  }

  /// タグの追加
  /// 
  /// 追加後にリストを更新する
  Future<void> onRequestAddTagName(String name) async {
    bool result = await _tagRepository.addTag(name: name);
    if (result) {
      refreshTagList();
    }
  }
}