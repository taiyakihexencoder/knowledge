import 'package:budgeting_app/data/services/expense_category_service.dart';
import 'package:budgeting_app/data/services/expense_history_service.dart';
import 'package:budgeting_app/data/services/expense_tag_service.dart';
import 'package:budgeting_app/data/services/shop_service.dart';
import 'package:budgeting_app/domain/repositories/expense_category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_history_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_tag_repository.dart';
import 'package:budgeting_app/domain/repositories/shop_repository.dart';
import 'package:budgeting_app/ui/history/view_models/history_list_view_model.dart';
import 'package:budgeting_app/ui/history/widgets/history_list/history_list.dart';
import 'package:flutter/material.dart';

import 'package:budgeting_app/res/string/l10n.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    const ExpenseHistoryService historyService = ExpenseHistoryService();
    const ExpenseHistoryRepository historyRepository = ExpenseHistoryRepository(
      historyService: historyService,
    );

    const ExpenseCategoryService expenseCategoryService = ExpenseCategoryService();
    const ExpenseCategoryRepository categoryRepository = ExpenseCategoryRepository(
      expenseCategoryService: expenseCategoryService,
    );

    const ExpenseTagService expenseTagService = ExpenseTagService();
    const ExpenseTagRepository tagRepository = ExpenseTagRepository(
      expenseTagService: expenseTagService,
    );

    const ShopService shopService = ShopService();
    const ShopRepository shopRepository = ShopRepository(
      shopService: shopService,
    );

    HistoryListViewModel historyListViewModel = HistoryListViewModel(
      historyRepository: historyRepository, 
      categoryRepository: categoryRepository,
      tagRepository: tagRepository, 
      shopRepository: shopRepository
    );

    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: HistoryList(
        viewModel: historyListViewModel,
      ),
    );
  }
}
