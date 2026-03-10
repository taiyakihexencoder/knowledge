import 'package:budgeting_app/data/db/budgeting_app_database.dart';
import 'package:budgeting_app/data/entities/expense_history_content_entity.dart';
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
  Future<void> updateLog({
    required int id,
    required ExpenseLogEntity log,
  }) async {
    BigInt historyId = BigInt.from(id);

    // コンテンツの更新
    Future updateHistory = (_database.update(_database.expenseHistory)..where(
      (column) => column.id.equals(historyId)
    )).write(
      ExpenseHistoryCompanion(
        amount: Value(log.amount),
        categoryId: Value(log.category.id),
        shopId: Value(log.shop.id),
        usedAt: Value(log.usedAt),
      )
    );
    
    // Content
    // 今あるものを削除
    Future updateContents = (_database.delete(_database.expenseContent)
      ..where(
        (column) => column.historyId.equals(historyId),
      )
    ).go().then(
      // 新たに追加
      (_) => _database.insertAll(
        table: _database.expenseContent, 
        records: log.contents.map(
          (content) => ExpenseContentCompanion(
            historyId: Value(historyId),
            title: Value(content.title),
            description: Value(content.description),
          ),
        )
      )
    );

    // Tag
    // 今あるものを削除
    Future updateTags = (_database.delete(_database.expenseHistoryTag)
      ..where(
        (column) => column.historyId.equals(historyId)
      )
    ).go().then(
      // 新たに追加
      (_) => _database.insertAll(
        table: _database.expenseHistoryTag,
        records: log.tags.map(
          (tag) => ExpenseHistoryTagCompanion(
            historyId: Value(historyId),
            tagId: Value(tag.id),
          ),
        )
      )
    );

    await Future.wait([updateHistory, updateContents, updateTags]);
  }

  @override
  Future<List<ExpenseHistoryEntity>> getHistoryList({
    Iterable<int>? historyIds,
    int? minAmount,
    int? maxAmount,
    String? minUsedAt,
    String? maxUsedAt,
    Iterable<int>? categories,
    Iterable<int>? shops,
  }) {
    return (_select..where(
      (column) {
        List<Expression<bool>> expressionList = [];
        if (minAmount != null && maxAmount != null) {
          expressionList.add(column.amount.isBetweenValues(minAmount, maxAmount));
        }
        if (minUsedAt != null && maxUsedAt != null) {
          expressionList.add(column.usedAt.isBetweenValues(minUsedAt, maxUsedAt));
        }
        if (historyIds != null && historyIds.isNotEmpty) {
          expressionList.add(column.id.isIn(historyIds.map((id) => BigInt.from(id))));
        }
        if (categories != null && categories.isNotEmpty) {
          expressionList.add(column.categoryId.isIn(categories));
        }
        if (shops != null && shops.isNotEmpty) {
          expressionList.add(column.categoryId.isIn(shops));
        }
        return Expression.and(expressionList);
      }
    )).get().then(
      (list) => list.map(
        (data) => _convert(data)
      ).toList()
    );
  }

  @override
  Future<ExpenseHistoryEntity?> getHistory({
    required int historyId,
  }) {
    return (_select..where((column) => column.id.equals(BigInt.from(historyId)))).getSingleOrNull()
      .then(
        (record) => record == null ? null : _convert(record)
      );
  }

  @override
  Future<List<ExpenseHistoryContentEntity>> getHistoryContents({
    required int historyId,
  }) {
    return (_database.select(_database.expenseContent)..where((column) => column.historyId.equals(BigInt.from(historyId)))).get()
      .then(
        (records) => records.map(
          (record) => _convertContent(record),
        ).toList()
      );
  }

  ExpenseHistoryEntity _convert(ExpenseHistoryData data) {
    return ExpenseHistoryEntity(
      id: data.id.toInt(), 
      categoryId: data.categoryId, 
      shopId: data.shopId, 
      amount: data.amount, 
      usedAt: data.usedAt,
    );
  }

  ExpenseHistoryContentEntity _convertContent(ExpenseContentData data) {
    return ExpenseHistoryContentEntity(
      id: data.id.toInt(),
      historyId: data.historyId.toInt(), 
      title: data.title, 
      description: data.description,
    );
  }
}