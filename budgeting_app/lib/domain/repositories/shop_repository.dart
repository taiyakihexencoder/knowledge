import 'package:budgeting_app/data/services/shop_service.dart';
import 'package:budgeting_app/domain/entities/shop_entity.dart';

/// 購入先情報Repository
class ShopRepository {

  const ShopRepository({
    required ShopService shopService,
  }): _shopService = shopService;

  final ShopService _shopService;

  /// 指定した購入先情報を取得する
  ShopEntity getShop(int shopId) {
    String json = _shopService.getShop(shopId);
    return ShopEntity.fromJson(json);
  }

  /// 登録済のすべての購入先をリストとして取得する
  List<ShopEntity> getAllShopList() {
    String json = _shopService.getAllShopList();
    return ShopEntity.fromListJson(json);
  }
}