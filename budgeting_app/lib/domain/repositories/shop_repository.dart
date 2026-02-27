import 'package:budgeting_app/data/services/shop_service.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';

/// 購入先情報Repository
class ShopRepository {

  const ShopRepository({
    required ShopService shopService,
  }): _shopService = shopService;

  final ShopService _shopService;

  /// 指定した購入先情報を取得する
  Future<ShopEntity> getShop(int shopId) {
    return _shopService.getShop(shopId);
  }

  /// 登録済のすべての購入先をリストとして取得する
  Future<List<ShopEntity>> getAllShopList() {
    return _shopService.getAllShopList();
  }
}