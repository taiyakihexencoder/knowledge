import 'package:budgeting_app/data/entities/shop_entity.dart';

abstract interface class ShopService {
  Future<ShopEntity?> getShop(int id);
  Future<List<ShopEntity>> getShops(Iterable<int> ids);
  Future<List<ShopEntity>> getAllShopList();

  /// 購入先の追加
  /// 
  /// 他と重複する名称になる場合はfalse
  Future<bool> addShop({
    required String name,
  });

  /// 購入先の名称変更
  /// 
  /// 他と重複する名称になる場合はfalse
  Future<bool> updateShopName({
    required int id, 
    required String name,
  });

  /// 購入先の削除
  Future<void> deleteShop({
    required int id,
  });
}