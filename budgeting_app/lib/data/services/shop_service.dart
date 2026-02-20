/// 購入先のデータソース
class ShopService {
  const ShopService();

  String getShop(int id) {
    return switch (id) {
      1 => '{"id": $id, "name":"AEON"}',
      2 => '{"id": $id, "name":"東京電力"}',
      3 => '{"id": $id, "name":"Amazon"}',
      _ => '{"id": $id, "name":"JR"}',
    };
  }
}