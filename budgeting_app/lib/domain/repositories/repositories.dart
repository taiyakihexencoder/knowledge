import 'package:budgeting_app/data/services/services.dart';
import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_history_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';

const ExpenseHistoryRepository historyRepository = ExpenseHistoryRepository(historyService: historyService);
const ExpenseCategoryRepository categoryRepository = ExpenseCategoryRepository(expenseCategoryService: expenseCategoryService);
const ExpenseTagRepository tagRepository = ExpenseTagRepository(expenseTagService: expenseTagService);
const ShopRepository shopRepository = ShopRepository(shopService: shopService);
