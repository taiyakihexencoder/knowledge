import 'package:budgeting_app/domain/repositories/repositories.dart';
import 'package:budgeting_app/ui/core/widget/budgeting_app_bottom_navigation.dart';
import 'package:budgeting_app/ui/history/view_models/history_list_view_model.dart';
import 'package:budgeting_app/ui/history/widgets/history_list/history_list.dart';
import 'package:budgeting_app/ui/new_log/view_models/new_log_view_model.dart';
import 'package:budgeting_app/ui/new_log/widgets/new_log.dart';
import 'package:budgeting_app/ui/settings/view_models/settings_attributes_view_model.dart';
import 'package:budgeting_app/ui/settings/widgets/settings_attributes/settings_attributes.dart';
import 'package:budgeting_app/ui/settings/widgets/settings_top/settings_top.dart';
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
    // budgeting_app_bottom_navigation.dart
    bottomNavigationBar = BudgetingAppBottomNavigation(
      navigateToHitoryList: (_) => HistoryListPage(), 
      navigateToSettings: (_) => SettingsPage(),
    );

    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: HistoryListPage(),
    );
  }
}

class HistoryListPage extends StatefulWidget {
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
  HistoryListPageState createState() {
    return HistoryListPageState();
  }
}

class HistoryListPageState extends State<HistoryListPage> {
  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HistoryList(
      viewModel: widget._viewModel,
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

class NewLogPage extends StatefulWidget {
  NewLogPage({
    super.key,
  }): _viewModel = NewLogViewModel(
    historyRepository: historyRepository,
    categoryRepository: categoryRepository,
    tagRepository: tagRepository,
    shopRepository: shopRepository
  );

  final NewLogViewModel _viewModel;

  @override
  NewLogPageState createState() {
    return NewLogPageState();
  }
}

class NewLogPageState extends State<NewLogPage> {
  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NewLog(
      viewModel: widget._viewModel
    );
  }
}

class SettingsPage extends StatelessWidget {
  SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTop(
      navigateToSettingsAttributes: _navigateToSettingsAttributes,
    );
  }

  void _navigateToSettingsAttributes(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsAttributesPage(),
      )
    );
  }
}

class SettingsAttributesPage extends StatelessWidget {
  SettingsAttributesPage({
    super.key,
  }): _viewModel = SettingsAttributesViewModel(
    shopRepository: shopRepository,
    categoryRepository: categoryRepository,
    tagRepository: tagRepository,
  );

  final SettingsAttributesViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return SettingsAttributes(
      viewModel: _viewModel,
    );
  }
}