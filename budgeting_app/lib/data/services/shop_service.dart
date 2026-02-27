import 'package:budgeting_app/data/entities/shop_entity.dart';

abstract interface class ShopService {
  Future<ShopEntity> getShop(int id);
  Future<List<ShopEntity>> getAllShopList();
}