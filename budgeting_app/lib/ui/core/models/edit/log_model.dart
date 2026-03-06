import 'package:budgeting_app/ui/core/models/edit/category_model.dart';
import 'package:budgeting_app/ui/core/models/edit/content_model.dart';
import 'package:budgeting_app/ui/core/models/edit/shop_model.dart';
import 'package:budgeting_app/ui/core/models/edit/tag_model.dart';

/// 入力した購入履歴モデル
class LogModel {
  const LogModel({
    required this.usedAt,
    required this.amount,
    required this.shop,
    required this.category,
    required this.tags,
    required this.contents,
  });

  /// 日付
  final String usedAt;

  /// 購入総額
  final int amount;

  /// 購入先
  final ShopModel? shop;

  /// 購入カテゴリー
  final CategoryModel? category;

  /// 購入履歴追加時のタグ
  final List<TagModel?> tags;

  /// 購入履歴詳細
  final List<ContentModel> contents;
}