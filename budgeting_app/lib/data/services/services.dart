import 'package:budgeting_app/data/services/expense_category_service.dart';
import 'package:budgeting_app/data/services/expense_history_service.dart';
import 'package:budgeting_app/data/services/expense_tag_service.dart';
import 'package:budgeting_app/data/services/mock/mock_expense_category_service.dart';
import 'package:budgeting_app/data/services/mock/mock_expense_history_service.dart';
import 'package:budgeting_app/data/services/mock/mock_expense_tag_service.dart';
import 'package:budgeting_app/data/services/mock/mock_shop_service.dart';
import 'package:budgeting_app/data/services/shop_service.dart';

const ExpenseHistoryService historyService = MockExpenseHistoryService();
const ExpenseCategoryService expenseCategoryService = MockExpenseCategoryService();
const ExpenseTagService expenseTagService = MockExpenseTagService();
const ShopService shopService = MockShopService();
