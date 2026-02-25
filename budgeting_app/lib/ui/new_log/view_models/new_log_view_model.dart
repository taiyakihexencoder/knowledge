import 'package:budgeting_app/domain/entities/expense_category_entity.dart';
import 'package:budgeting_app/domain/entities/expense_tag_entity.dart';
import 'package:budgeting_app/domain/entities/shop_entity.dart';
import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/new_log/models/category_model.dart';
import 'package:budgeting_app/ui/new_log/models/shop_model.dart';
import 'package:budgeting_app/ui/new_log/models/tag_model.dart';

class NewLogViewModel {
  NewLogViewModel({
    required ExpenseCategoryRepository categoryRepository,
    required ExpenseTagRepository tagRepository,
    required ShopRepository shopRepository,
  }):
  _categoryRepository = categoryRepository,
  _tagRepository = tagRepository,
  _shopRepository = shopRepository,
  _categorySelections = const [],
  _tagSelections = const [],
  _shopSelections = const [];

  /// 購入カテゴリーReposiotry
  final ExpenseCategoryRepository _categoryRepository;
  
  /// 購入履歴タグRepository
  final ExpenseTagRepository _tagRepository;

  /// 購入先Repository
  final ShopRepository _shopRepository;

  /// カテゴリーの選択肢
  List<CategoryModel> _categorySelections;
  List<CategoryModel> get categorySelections => _categorySelections;

  /// タグの選択肢
  List<TagModel> _tagSelections;
  List<TagModel> get tagSelections => _tagSelections;

  /// 購入先の選択肢
  List<ShopModel> _shopSelections;
  List<ShopModel> get shopSelections => _shopSelections;

  /// カテゴリーリストを更新する
  void refreshCategoryList() {
    List<ExpenseCategoryEntity> categoryList = _categoryRepository.getAllCategoryList();
    _categorySelections = categoryList.map(
      (category) => CategoryModel(
        id: category.id, 
        name: category.name,
      ),
    ).toList();
  }

  /// タグリストを更新する
  void refreshTagList() {
    List<ExpenseTagEntity> tagList = _tagRepository.getAllTags();
    _tagSelections = tagList.map(
      (tag)=> TagModel(
        id: tag.id, 
        name: tag.name,
      ),
    ).toList();
  }

  /// 購入先リストを更新する
  void refreshShopList() {
    List<ShopEntity> shopList = _shopRepository.getAllShopList();
    _shopSelections = shopList.map(
      (shop) => ShopModel(
        id: shop.id,
        name: shop.name,
      ),
    ).toList();
  }
}