import 'package:budgeting_app/data/db/budgeting_app_database.dart';
import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_log_entity.dart';
import 'package:budgeting_app/data/services/expense_history_service.dart';
import 'package:drift/drift.dart';

class LocalExpenseHistoryService implements ExpenseHistoryService {
  const LocalExpenseHistoryService({
    required BudgetingAppDatabase database,
  }): _database = database;

  final BudgetingAppDatabase _database;

  SimpleSelectStatement<$ExpenseHistoryTable, ExpenseHistoryData> get _select 
    => _database.select(_database.expenseHistory);

  @override
  Future<int> createLog({required ExpenseLogEntity log}) async {
    int historyId = await _database
      .into(_database.expenseHistory)
      .insert(
        ExpenseHistoryCompanion.insert(
          amount: log.amount,
          categoryId: log.category.id,
          shopId: log.shop.id,
          usedAt: log.usedAt,
        )
      );
    
    // Content
    Future insertContents = _database
      .insertAll(
        table: _database.expenseContent, 
        records: log.contents.map(
          (content) => ExpenseContentCompanion(
            historyId: Value(BigInt.from(historyId)),
            title: Value(content.title),
            description: Value(content.description),
          ),
        )
      );
    
    // Tag
    Future insertTags = _database
      .insertAll(
        table: _database.expenseHistoryTag,
        records: log.tags.map(
          (tag) => ExpenseHistoryTagCompanion(
            historyId: Value(BigInt.from(historyId)),
            tagId: Value(tag.id),
          ),
        )
      );

    await Future.wait([insertContents, insertTags]);

    return historyId;
  }

  @override
  Future<List<ExpenseHistoryEntity>> getHistoryList() {
    return _select.get().then(
      (list) => list.map(
        (data) => convert(data)
      ).toList()
    );
  }

  ExpenseHistoryEntity convert(ExpenseHistoryData data) {
    return ExpenseHistoryEntity(
      id: data.id.toInt(), 
      categoryId: data.categoryId, 
      shopId: data.shopId, 
      amount: data.amount, 
      usedAt: data.usedAt
    );
  }

}