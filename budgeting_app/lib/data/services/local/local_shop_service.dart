import 'package:budgeting_app/data/db/budgeting_app_database.dart';
import 'package:budgeting_app/data/entities/shop_entity.dart';
import 'package:budgeting_app/data/services/shop_service.dart';
import 'package:drift/drift.dart';

class LocalShopService implements ShopService {
  const LocalShopService({
    required BudgetingAppDatabase database,
  }): _database = database;

  final BudgetingAppDatabase _database;  

  SimpleSelectStatement<$ShopTable, ShopData> get select
    => _database.select(_database.shop);

  @override
  Future<List<ShopEntity>> getAllShopList() {
    return select.get().then(
      (records) => records.map(
        (record) => convert(record),
      ).toList(),
    );
  }

  @override
  Future<ShopEntity> getShop(int id) {
    return (
      select
        ..where((column) => column.id.equals(id))
    ).getSingle().then(
      (record) => convert(record),
    );
  }

  ShopEntity convert(ShopData record) {
    return ShopEntity(
      id: record.id, 
      name: record.name
    );
  }
}