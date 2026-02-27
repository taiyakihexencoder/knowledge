import 'package:budgeting_app/data/entities/shop_entity.dart';
import 'package:budgeting_app/data/services/shop_service.dart';

/// 購入先のデータソース
class MockShopService implements ShopService {
  const MockShopService();

  @override
  Future<ShopEntity> getShop(int id) {
    return Future.value(ShopEntity.fromJson(_mockShop(id)));
  }

  String _mockShop(int id) {
    return switch (id) {
      1 => '{"id": $id, "name":"AEON"}',
      2 => '{"id": $id, "name":"東京電力"}',
      3 => '{"id": $id, "name":"Amazon"}',
      _ => '{"id": $id, "name":"JR"}',
    };
  }

  @override
  Future<List<ShopEntity>> getAllShopList() {
    return Future.value(ShopEntity.fromListJson(_mockAllShopList()));
  }

  String _mockAllShopList() {
    return '''
[
  {"id": 1, "name":"AEON"},
  {"id": 2, "name":"東京電力"},
  {"id": 3, "name":"Amazon"}
]
''';
  }
}