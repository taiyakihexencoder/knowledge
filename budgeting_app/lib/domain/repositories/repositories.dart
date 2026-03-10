import 'package:budgeting_app/data/services/services.dart';
import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_history_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';

ExpenseHistoryRepository historyRepository = ExpenseHistoryRepository(
  historyService: services.historyService,
  tagService: services.expenseTagService,
);
ExpenseCategoryRepository categoryRepository = ExpenseCategoryRepository(expenseCategoryService: services.expenseCategoryService);
ExpenseTagRepository tagRepository = ExpenseTagRepository(expenseTagService: services.expenseTagService);
ShopRepository shopRepository = ShopRepository(shopService: services.shopService);
