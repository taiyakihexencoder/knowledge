import 'package:budgeting_app/data/db/budgeting_app_database.dart';
import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/expense_tag_entity.dart';
import 'package:budgeting_app/data/services/expense_tag_service.dart';
import 'package:drift/drift.dart';

class LocalExpenseTagService implements ExpenseTagService {
  LocalExpenseTagService({
    required BudgetingAppDatabase database,
  }): _database = database;

  final BudgetingAppDatabase _database;

  @override
  Future<List<ExpenseTagEntity>> getAllExpenseTagList() {
    return _database.select(_database.expenseTag).get()
      .then(
        (records) => records.map(
          (record) => convert(record),
        ).toList()
      );
  }

  @override
  Future<List<ExpenseHistoryTagEntity>> getExpenseTagList(Iterable<int> ids) {
    $ExpenseTagTable tTag = _database.expenseTag;
    $ExpenseHistoryTagTable tHistoryTag = _database.expenseHistoryTag;

    return (
      _database.select(tHistoryTag)
        .join([
            leftOuterJoin(
              tTag, 
              tTag.id.equalsExp(tHistoryTag.tagId),
            ),
        ])
        ..where(tHistoryTag.historyId.isIn(ids.map((id) => BigInt.from(id))))
    ).get().then(
      (records) => records.map(
          (record) {
            ExpenseTagData tagData = record.readTable(tTag);
            ExpenseHistoryTagData historyData = record.readTable(tHistoryTag);
            return ExpenseHistoryTagEntity(
              id: historyData.tagId,
              historyId: historyData.historyId.toInt(),
              name: tagData.name,
            );
          }
        ).toList()
      );
  }

  
  @override
  Future<bool> addTag({
    required String name,
  }) async {
    return (_database.select(_database.expenseTag)..where((column) => column.name.equals(name))).getSingleOrNull()
      .then(
        (record) async {
          if (record == null) {
            return _database.into(_database.expenseTag).insert(
              ExpenseTagCompanion(
                name: Value(name),
              )  
            ).then( (_) => true, );
          } else {
            return false;
          }
        },
      );
  }

  @override
  Future<bool> updateTagName({
    required int id,
    required String name,
  }) async {
    return (_database.select(_database.expenseTag)..where((column) => column.name.equals(name))).getSingleOrNull()
      .then(
        (record) async {
          if (record == null) {
            return (_database.update(_database.expenseTag)
              ..where((column) => column.id.equals(id))
            ).write(
              ExpenseTagCompanion(
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
  Future<void> deleteTag({
    required int id,
  }) async {
    await (
      _database.delete(_database.expenseTag)
        ..where((column) => column.id.equals(id))
    ).go();

    await (
      _database.delete(_database.expenseHistoryTag)
        ..where((column) => column.tagId.equals(id))
    ).go();
  }

  ExpenseTagEntity convert(ExpenseTagData record) {
    return ExpenseTagEntity(
      id: record.id, 
      name: record.name,
    );
  }
}