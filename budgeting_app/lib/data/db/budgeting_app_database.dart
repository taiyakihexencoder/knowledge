import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'budgeting_app_database.g.dart';

@DriftDatabase(
  tables: [
    ExpenseCategory,
    ExpenseContent,
    ExpenseHistory,
    ExpenseHistoryTag,
    ExpenseTag,
    Shop,
  ]
)
final class BudgetingAppDatabase extends _$BudgetingAppDatabase {
  BudgetingAppDatabase([
    QueryExecutor? executor
  ]): super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name:'budgeting_app_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'), 
        driftWorker: Uri.parse('drift_worker.js'),
      )
    );
  }

  /// insert all (バッチ処理)
  /// batchの分でinsertAll構文のネストが深くなりすぎるので、ここで定義しておく
  Future<void> insertAll<T extends TableInfo<T, D>, D>({
    required T table, 
    required Iterable<Insertable<D>> records
  }) async {
    await batch(
      (batch){
        batch.insertAll(
          table,
          records,
        );
      }
    );
  }
}

/// 消費カテゴリーテーブル
class ExpenseCategory extends Table {
  @override
  String get tableName => 'expense_category';

  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get name => text().named('name').withLength(min: 0, max: 50)();
}

/// 消費詳細テーブル
class ExpenseContent extends Table {
  @override
  String get tableName => 'expense_content';

  Int64Column get historyId => int64().named('history_id').autoIncrement()();
  TextColumn get title => text().named('title').withLength(min: 0, max: 50)();
  TextColumn get description => text().named('description').withLength(min: 0, max: 300)();
}

/// 消費履歴テーブル
class ExpenseHistory extends Table {
  @override
  String get tableName => 'expense_history';

  Int64Column get id => int64().named('id').autoIncrement()();
  IntColumn get categoryId => integer().named('category_id')();
  IntColumn get shopId => integer().named('shop_id')();
  IntColumn get amount => integer().named('amount')();
  TextColumn get usedAt => text().named('used_at')();
}

/// 消費履歴に設定されたタグを管理するテーブル
class ExpenseHistoryTag extends Table {
  @override
  String get tableName => 'expense_history_tag';

  Int64Column get historyId => int64().named('history_id')();
  IntColumn get tagId => integer().named('tag_id')();
}

/// 登録済のタグ情報テーブル
class ExpenseTag extends Table {
  @override
  String get tableName => 'expense_tag';

  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get name => text().named('name').withLength(min: 0, max: 50)();
}

/// 購入先テーブル
class Shop extends Table {
  @override
  String get tableName => 'shop';

  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get name => text().named('name').withLength(min: 0, max: 50)();
}
