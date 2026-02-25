import 'package:budgeting_app/domain/repositories/repositories.dart';
import 'package:budgeting_app/ui/history/view_models/history_list_view_model.dart';
import 'package:budgeting_app/ui/history/widgets/history_list/history_list.dart';
import 'package:budgeting_app/ui/new_log/widgets/new_log.dart';
import 'package:flutter/material.dart';

import 'package:budgeting_app/res/string/l10n.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: HistoryListPage(),
    );
  }
}

class HistoryListPage extends StatelessWidget {
  HistoryListPage({
    super.key
  }): _viewModel = HistoryListViewModel(
    historyRepository: historyRepository, 
    categoryRepository: categoryRepository, 
    tagRepository: tagRepository, 
    shopRepository: shopRepository
  );

  final HistoryListViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return HistoryList(
      viewModel: _viewModel,
      navigateToNewLog: _navigateToNewLog,
    );
  }

  void _navigateToNewLog(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewLogPage(),
      )
    );
  }
}

class NewLogPage extends StatelessWidget {
  const NewLogPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NewLog();
  }
}
