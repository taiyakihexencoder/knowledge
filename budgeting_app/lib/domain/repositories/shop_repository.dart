import 'package:budgeting_app/data/services/shop_service.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';

/// 購入先情報Repository
class ShopRepository {

  const ShopRepository({
    required ShopService shopService,
  }): _shopService = shopService;

  final ShopService _shopService;

  /// 指定した購入先情報を取得する
  Future<ShopEntity?> getShop(int shopId) {
    return _shopService.getShop(shopId);
  }

  /// 指定した購入先情報を取得する
  Future<List<ShopEntity>> getShops(Iterable<int> shopIds) {
    return _shopService.getShops(shopIds);
  }

  /// 登録済のすべての購入先をリストとして取得する
  Future<List<ShopEntity>> getAllShopList() {
    return _shopService.getAllShopList();
  }

  /// 購入先を追加する。
  /// 
  /// すでにあるものと重複している場合は追加できずfalse, 
  /// それ以外はtrue
  Future<bool> addShop({
    required String name,
  }) {
    return _shopService.addShop(name: name);
  }

  /// 購入先を上書きする。
  /// 
  /// すでにあるものと重複している場合は追加できずfalse, 
  /// それ以外はtrue
  Future<bool> updateShopName({
    required int id, 
    required String name,
  }) {
    return _shopService.updateShopName(id: id, name: name);
  }

  /// 購入先を削除する
  Future<void> deleteShop({
    required int id
  }) {
    return _shopService.deleteShop(id: id);
  }
}