import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/settings/models/category_model.dart';
import 'package:budgeting_app/ui/settings/models/shop_model.dart';
import 'package:budgeting_app/ui/settings/models/tag_model.dart';
import 'package:flutter/material.dart';

class SettingsAttributesViewModel {
  SettingsAttributesViewModel({
    required ShopRepository shopRepository,
    required ExpenseCategoryRepository categoryRepository,
    required ExpenseTagRepository tagRepository,
  }) : 
    _shopRepository = shopRepository,
    _categoryRepository = categoryRepository,
    _tagRepository = tagRepository,
    _usedAtRange = ValueNotifier(null),
    _shops = ValueNotifier([]),
    _categories = ValueNotifier([]),
    _tags = ValueNotifier([]);

  final ShopRepository _shopRepository;
  final ExpenseCategoryRepository _categoryRepository;
  final ExpenseTagRepository _tagRepository;

  final ValueNotifier<DateTimeRange?> _usedAtRange;
  ValueNotifier<DateTimeRange?> get usedAtRange => _usedAtRange;

  final ValueNotifier<List<ShopModel>> _shops;
  ValueNotifier<List<ShopModel>> get shops => _shops;

  final ValueNotifier<List<CategoryModel>> _categories;
  ValueNotifier<List<CategoryModel>> get categories => _categories;

  final ValueNotifier<List<TagModel>> _tags;
  ValueNotifier<List<TagModel>> get tags => _tags;

  /// 購入先リストを更新(async)
  void updateShopList() async {
    _shops.value = await _shopRepository.getAllShopList().then(
      (list) => list.map(
        (shop) => ShopModel(
          id: shop.id, 
          name: shop.name
        )
      ).toList()
    );
  }

  /// 購入先を追加
  /// 
  /// 追加後にリストを更新する
  void onRequestAddShopName(String name) async {
    bool result = await _shopRepository.addShop(name: name);
    if (result) {
      updateShopList();
    }
  }

  /// 購入先の名称を更新
  /// 
  /// 更新後にリストを更新する
  void onRequestUpdateShopName(int id, String name) async {
    bool result = await _shopRepository.updateShopName(id: id, name: name);
    if (result) {
      updateShopList();
    }
  }

  /// 購入先を削除
  /// 
  /// 削除後にリストを更新する
  void onRequestDeleteShopName(int id) async {
    await _shopRepository.deleteShop(id: id);
    updateShopList();
  }

  /// カテゴリーリストを更新(async)
  void updateCategoryList() async {
    _categories.value = await _categoryRepository.getAllCategoryList().then(
      (list) => list.map(
        (category) => CategoryModel(
          id: category.id,
          name: category.name,
        )
      ).toList()
    );
  }

  /// カテゴリーの追加
  /// 
  /// 追加後にリストを更新する
  void onRequestAddCategoryName(String name) async {
    bool result = await _categoryRepository.addCategory(name: name);
    if (result) {
      updateCategoryList();
    }
  }

  /// カテゴリーの名称を更新
  /// 
  /// 更新後にリストを更新する
  void onRequestUpdateCategoryName(int id, String name) async {
    bool result = await _categoryRepository.updateCategory(id: id, name: name);
    if (result) {
      updateCategoryList();
    }
  }

  /// カテゴリーを削除
  /// 
  /// 削除後にリストを更新する
  void onRequestDeleteCategoryName(int id) async {
    await _categoryRepository.deleteCategory(id: id);
    updateCategoryList();
  }


  /// タグのリストを更新(async)
  void updateTagList() async {
    _tags.value = await _tagRepository.getAllTags().then(
      (list) => list.map(
        (tag) => TagModel(
          id: tag.id,
          name: tag.name,
        )
      ).toList()
    );
  }

  /// タグの追加
  /// 
  /// 追加後にリストを更新する
  void onRequestAddTagName(String name) async {
    bool result = await _tagRepository.addTag(name: name);
    if (result) {
      updateTagList();
    }
  }

  /// タグの名称を更新
  /// 
  /// 更新後にリストを更新する
  void onRequestUpdateTagName(int id, String name) async {
    bool result = await _tagRepository.updateTag(id: id, name: name);
    if (result) {
      updateTagList();
    }
  }

  /// タグを削除
  /// 
  /// 削除後にリストを更新する
  void onRequestDeleteTagName(int id) async {
    await _tagRepository.deleteTag(id: id);
    updateTagList();
  }

}