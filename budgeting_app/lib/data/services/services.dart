import 'package:budgeting_app/data/db/budgeting_app_database.dart';
import 'package:budgeting_app/data/services/expense_category_service.dart';
import 'package:budgeting_app/data/services/expense_history_service.dart';
import 'package:budgeting_app/data/services/expense_tag_service.dart';
import 'package:budgeting_app/data/services/local/local_expense_category_service.dart';
import 'package:budgeting_app/data/services/local/local_expense_history_service.dart';
import 'package:budgeting_app/data/services/local/local_expense_tag_service.dart';
import 'package:budgeting_app/data/services/local/local_shop_service.dart';
import 'package:budgeting_app/data/services/mock/mock_expense_category_service.dart';
import 'package:budgeting_app/data/services/mock/mock_expense_history_service.dart';
import 'package:budgeting_app/data/services/mock/mock_expense_tag_service.dart';
import 'package:budgeting_app/data/services/mock/mock_shop_service.dart';
import 'package:budgeting_app/data/services/shop_service.dart';
import 'package:flutter/material.dart';

final Services services = LocalServices();

abstract interface class Services {
   ExpenseHistoryService get historyService;
   ExpenseCategoryService get expenseCategoryService;
   ExpenseTagService get expenseTagService;
   ShopService get shopService;
}

class MockServices implements Services {
  const MockServices():
    _historyService = const MockExpenseHistoryService(),
    _expenseCategoryService = const MockExpenseCategoryService(),
    _expenseTagService = const MockExpenseTagService(),
    _shopService = const MockShopService();

  final ExpenseHistoryService _historyService;
  @override
  ExpenseHistoryService get historyService => _historyService;

  final ExpenseCategoryService _expenseCategoryService;
  @override
  ExpenseCategoryService get expenseCategoryService => _expenseCategoryService;

  final ExpenseTagService _expenseTagService;
  @override
  ExpenseTagService get expenseTagService => _expenseTagService;

  final ShopService _shopService;
  @override
  ShopService get shopService => _shopService;
}

class LocalServices implements Services {
  LocalServices() {
    // initialize drift DB
    WidgetsFlutterBinding.ensureInitialized();

    database = BudgetingAppDatabase();
    _historyService = LocalExpenseHistoryService(database: database);
    _expenseCategoryService = LocalExpenseCategoryService(database: database);
    _expenseTagService = LocalExpenseTagService(database: database);
    _shopService = LocalShopService(database: database);
  }

  late BudgetingAppDatabase database;

  late ExpenseHistoryService _historyService;
  @override
  ExpenseHistoryService get historyService => _historyService;

  late ExpenseCategoryService _expenseCategoryService;
  @override
  ExpenseCategoryService get expenseCategoryService => _expenseCategoryService;

  late ExpenseTagService _expenseTagService;
  @override
  ExpenseTagService get expenseTagService => _expenseTagService;

  late ShopService _shopService;
  @override
  ShopService get shopService => _shopService;
}