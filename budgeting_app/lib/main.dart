import 'package:budgeting_app/domain/repositories/repositories.dart';
import 'package:budgeting_app/main_frame.dart';
import 'package:budgeting_app/ui/core/models/filter/search_filter_model.dart';
import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:budgeting_app/ui/core/widget/budgeting_app_bottom_navigation.dart';
import 'package:budgeting_app/ui/core/widget/project_navigator.dart';
import 'package:budgeting_app/ui/dashboard/view_models/dashboard_top_view_model.dart';
import 'package:budgeting_app/ui/dashboard/widgets/dashboard_top/dashboard_top.dart';
import 'package:budgeting_app/ui/history/view_models/history_detail_view_model.dart';
import 'package:budgeting_app/ui/history/view_models/history_edit_view_model.dart';
import 'package:budgeting_app/ui/history/view_models/history_filter_view_model.dart';
import 'package:budgeting_app/ui/history/view_models/history_list_view_model.dart';
import 'package:budgeting_app/ui/history/widgets/history_detail/history_detail.dart';
import 'package:budgeting_app/ui/history/widgets/history_edit/history_edit.dart';
import 'package:budgeting_app/ui/history/widgets/history_filter/history_filter.dart';
import 'package:budgeting_app/ui/history/widgets/history_list/history_list.dart';
import 'package:budgeting_app/ui/new_log/view_models/new_log_view_model.dart';
import 'package:budgeting_app/ui/new_log/widgets/new_log.dart';
import 'package:budgeting_app/ui/settings/view_models/settings_attributes_view_model.dart';
import 'package:budgeting_app/ui/settings/widgets/settings_attributes/settings_attributes.dart';
import 'package:budgeting_app/ui/settings/widgets/settings_top/settings_top.dart';
import 'package:flutter/material.dart';

import 'package:budgeting_app/res/string/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';

void main() async {
  initializeDateFormatting(await findSystemLocale(), null);
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
      navigateToDashboard: (_) => DashboardTopPage(),
      navigateToHitoryList: (_) => HistoryListPage(), 
      navigateToSettings: (_) => SettingsPage(),
    );

    mainFrameViewModel.setEdgeInsets(MediaQuery.of(context).padding);

    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: DashboardTopPage(),
      navigatorKey: navigator.key,
      builder: (context, child) => MainFrame(
        viewModel: mainFrameViewModel,
        child: child,
      ),
    );
  }
}

class DashboardTopPage extends StatefulWidget {
  DashboardTopPage({
    super.key,
  }):
    _viewModel = DashboardTopViewModel(
      expenseHistoryRepository: historyRepository,
      expenseCategoryRepository: categoryRepository,
      shopRepository: shopRepository,
      expenseTagRepository: tagRepository,
    );

  final DashboardTopViewModel _viewModel;

  @override
  DashboardTopPageState createState() {
    return DashboardTopPageState();
  }
}

class DashboardTopPageState extends State<DashboardTopPage> {
  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardTop(
      viewModel: widget._viewModel,
      onClickNewLog: _navigateToNewLog,
    );
  }

  Future _navigateToNewLog(
    BuildContext context, {
    required int year,
    required int month,
    required int date,
  }) {
    // 注意：NewLogの日付情報はハイフンでつなげる
    final dateString = '$year-${month.toString().padLeft(2,'0')}-${date.toString().padLeft(2,'0')}';

    return navigator.push(
      MaterialPageRoute(
        builder: (context) => NewLogPage(
          startDate: dateString,
        ),
      )
    );
  }
}

class HistoryListPage extends StatefulWidget {
  HistoryListPage({
    super.key,
    SearchFilterModel? searchFilter,
  }): _viewModel = HistoryListViewModel(
    historyRepository: historyRepository, 
    categoryRepository: categoryRepository, 
    tagRepository: tagRepository, 
    shopRepository: shopRepository,
    searchFilter: searchFilter,
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
      navigateToDetail: _navigateToHistoryDetail,
      navigateToHistoryFilter: _navigateToHistoryFilter,
    );
  }

  Future<bool> _navigateToNewLog() async {
    var result = await navigator.push(
      MaterialPageRoute(
        builder: (context) => NewLogPage(),
      )
    );
    return result is bool && result;
  }

  Future<bool> _navigateToHistoryDetail(int historyId) async {
    var result = await navigator.push(
      MaterialPageRoute(
        builder: (context) => HistoryDetailPage(
          historyId: historyId,
        ),
      )
    );
    return result is bool && result;
  }

  Future _navigateToHistoryFilter(SearchFilterModel? searchFilter) {
   return navigator.push(
     MaterialPageRoute(
       builder: (context) => HistoryFilterPage(searchFilter: searchFilter),
     )
   );
 }
}

class HistoryDetailPage extends StatefulWidget {
  HistoryDetailPage({
    super.key,
    required int historyId,
  }):
    _historyId = historyId,
    _viewModel = HistoryDetailViewModel(
      historyId: historyId, 
      historyRepository: historyRepository, 
      categoryRepository: categoryRepository, 
      tagRepository: tagRepository, 
      shopRepository: shopRepository,
    );

  final int _historyId;
  final HistoryDetailViewModel _viewModel;

  @override
  HistoryDetailPageState createState() {
    return HistoryDetailPageState();
  }
}

class HistoryDetailPageState extends State<HistoryDetailPage> {
  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HistoryDetail(
      viewModel: widget._viewModel,
      navigateToHistoryEdit: _navigateToHistoryEdit,
      popScreen: _popHistoryDetail,
    );
  }

  Future<bool> _navigateToHistoryEdit() async {
    var result = await navigator.push(
      MaterialPageRoute(
        builder: (_) => HistoryEditPage(
          historyId: widget._historyId,
        ),
      ),
    );
    return result is bool && result;
  }

  void _popHistoryDetail(bool updated) {
    navigator.pop(updated);
  }
}

class HistoryEditPage extends StatefulWidget {
  HistoryEditPage({
    super.key,
    required int historyId,
  }):
    _viewModel = HistoryEditViewModel(
      id: historyId,
      historyRepository: historyRepository,
      categoryRepository: categoryRepository,
      tagRepository: tagRepository,
      shopRepository: shopRepository
    );

  final HistoryEditViewModel _viewModel;

  @override
  HistoryEditPageState createState() {
    return HistoryEditPageState();
  }
}

class HistoryEditPageState extends State<HistoryEditPage> {
  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HistoryEdit(
      viewModel: widget._viewModel,
      navigateOnSubmit: _navigateOnSubmit,
    );
  }

  void _navigateOnSubmit() {
    navigator.pop(true);
  }
}

class HistoryFilterPage extends StatefulWidget {
  HistoryFilterPage({
    super.key,
    SearchFilterModel? searchFilter,
  }): _viewModel = HistoryFilterViewModel(
    categoryRepository: categoryRepository,
    tagRepository: tagRepository,
    shopRepository: shopRepository,
    searchFilter: searchFilter ?? SearchFilterModel.empty()
  );

  final HistoryFilterViewModel _viewModel;

  @override
  HistoryFilterPageState createState() {
    return HistoryFilterPageState();
  }
}

class HistoryFilterPageState extends State<HistoryFilterPage> {
  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HistoryFilter(
      viewModel: widget._viewModel,
      navigateOnSubmit: _navigateOnSubmit,
    );
  }

  Future _navigateOnSubmit(SearchFilterModel searchFilter) {
    return navigator.push(
      MaterialPageRoute(
        builder: (_) => HistoryListPage(searchFilter: searchFilter),
      )
    );
  }
}

class NewLogPage extends StatefulWidget {
  NewLogPage({
    super.key,
    String? startDate,
  }): _viewModel = NewLogViewModel(
      historyRepository: historyRepository,
      categoryRepository: categoryRepository,
      tagRepository: tagRepository,
      shopRepository: shopRepository,
    ),
    _startDate = startDate;

  final NewLogViewModel _viewModel;
  final String? _startDate;

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
      viewModel: widget._viewModel,
      startDate: widget._startDate,
      navigateOnSubmit: _navigateOnSubmit,
    );
  }

  void _navigateOnSubmit() {
    navigator.pop(true);
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

  Future _navigateToSettingsAttributes() {
    return navigator.push(
      MaterialPageRoute(
        builder: (context) => SettingsAttributesPage(),
      )
    );
  }
}

class SettingsAttributesPage extends StatefulWidget {
  SettingsAttributesPage({
    super.key,
  }): _viewModel = SettingsAttributesViewModel(
    shopRepository: shopRepository,
    categoryRepository: categoryRepository,
    tagRepository: tagRepository,
  );

  final SettingsAttributesViewModel _viewModel;

  @override
  SettingsAttributesPageState createState() {
    return SettingsAttributesPageState();
  }
}

class SettingsAttributesPageState extends State<SettingsAttributesPage>{
  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsAttributes(
      viewModel: widget._viewModel,
    );
  }
}
