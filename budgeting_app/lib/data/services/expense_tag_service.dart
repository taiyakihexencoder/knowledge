import 'package:budgeting_app/data/entities/expense_history_tag_entity.dart';
import 'package:budgeting_app/data/entities/expense_tag_entity.dart';

abstract interface class ExpenseTagService {
  Future<List<ExpenseHistoryTagEntity>> getExpenseTagList(Iterable<int> ids);
  Future<List<ExpenseTagEntity>> getAllExpenseTagList();
}