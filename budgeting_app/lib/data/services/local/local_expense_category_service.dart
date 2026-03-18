import 'package:budgeting_app/data/db/budgeting_app_database.dart';
import 'package:budgeting_app/data/entities/expense_category_entity.dart';
import 'package:budgeting_app/data/services/expense_category_service.dart';
import 'package:drift/drift.dart';

class LocalExpenseCategoryService implements ExpenseCategoryService {
  const LocalExpenseCategoryService({
    required BudgetingAppDatabase database,
  }): _database = database;

  final BudgetingAppDatabase _database;

  SimpleSelectStatement<$ExpenseCategoryTable, ExpenseCategoryData> get select 
    => _database.select(_database.expenseCategory);

  @override
  Future<ExpenseCategoryEntity?> getCategory(int categoryId) {
    return (
      select
        ..where((column) => column.id.equals(categoryId))
    ).getSingleOrNull().then(
      (record) => record == null ? null : convert(record)
    );
  }

  @override
  Future<List<ExpenseCategoryEntity>> getCategories(Iterable<int> categoryIds) {
    return (select..where((column) => column.id.isIn(categoryIds))).get()
      .then(
        (records) => records.map((record) => convert(record)).toList()
      );
  }

  @override
  Future<List<ExpenseCategoryEntity>> getAllCategoryList() {
    return select.get()
      .then(
        (records) => records.map(
          (record) => convert(record)
        ).toList()
      );
  }

  @override
  Future<ExpenseCategoryEntity?> addCategory({
    required String name,
  }) async {
    return (select..where((column) => column.name.equals(name))).getSingleOrNull()
      .then(
        (record) async {
          if (record == null) {
            return _database.into(_database.expenseCategory).insert(
              ExpenseCategoryCompanion(
                name: Value(name),
              )  
            ).then( (id) => ExpenseCategoryEntity(id: id, name: name), );
          } else {
            return null;
          }
        },
      );
  }

  @override
  Future<bool> updateCategoryName({
    required int id,
    required String name,
  }) async {
    return (select..where((column) => column.name.equals(name))).getSingleOrNull()
      .then(
        (record) async {
          if (record == null) {
            return (_database.update(_database.expenseCategory)
              ..where((column) => column.id.equals(id))
            ).write(
              ExpenseCategoryCompanion(
                name: Value(name),
              )
            ).then( (_) => true, );
          } else {
            return false;
          }
        }
      );
  }

  @override
  Future<void> deleteCategory({
    required int id,
  }) async {
    await (
      _database.delete(_database.expenseCategory)
        ..where((column) => column.id.equals(id))
    ).go();
  }

  ExpenseCategoryEntity convert(ExpenseCategoryData record) {
    return ExpenseCategoryEntity(
      id: record.id, 
      name: record.name,
    );
  }
}