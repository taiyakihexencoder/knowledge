import 'package:budgeting_app/data/entities/expense_history_entity.dart';
import 'package:budgeting_app/data/entities/expense_log_entity.dart';

abstract interface class ExpenseHistoryService {
  Future<List<ExpenseHistoryEntity>> getHistoryList();

  Future<int> createLog({
    required ExpenseLogEntity log,
  });
}