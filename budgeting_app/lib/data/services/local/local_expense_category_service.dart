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
  Future<ExpenseCategoryEntity> getCategory(int categoryId) {
    return (
      select
        ..where((column) => column.id.equals(categoryId))
    ).getSingle().then(
      (record) => convert(record)
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

  ExpenseCategoryEntity convert(ExpenseCategoryData record) {
    return ExpenseCategoryEntity(
      id: record.id, 
      name: record.name,
    );
  }
}