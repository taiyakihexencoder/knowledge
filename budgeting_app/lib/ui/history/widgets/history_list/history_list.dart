import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/models/filter/search_filter_model.dart';
import 'package:budgeting_app/ui/core/models/floating_action_button_model.dart';
import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:budgeting_app/ui/core/widget/safe_area_padding.dart';
import 'package:budgeting_app/ui/history/view_models/history_list_view_model.dart';
import 'package:budgeting_app/ui/history/widgets/history_list/history_list_element.dart';
import 'package:budgeting_app/ui/history/widgets/history_list/history_list_filter.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  HistoryList({
    super.key,
    required HistoryListViewModel viewModel,
    required Future<bool> Function() navigateToNewLog,
    required Future<bool> Function(int historyId) navigateToDetail, 
    required Future Function(SearchFilterModel?) navigateToHistoryFilter,
  }) : 
    _viewModel = viewModel,
    _navigateToNewLog = navigateToNewLog,
    _navigateToDetail = navigateToDetail,
    _navigateToHistoryFilter = navigateToHistoryFilter;

  final HistoryListViewModel _viewModel;
  final Future<bool> Function() _navigateToNewLog;
  final Future<bool> Function(int) _navigateToDetail;
  final Future Function(SearchFilterModel?) _navigateToHistoryFilter;

  void _updateScaffold() {
    mainFrameViewModel.hideTopBar();
    mainFrameViewModel.showNavigator();
    mainFrameViewModel.setFloatingActionButton([
      FloatingActionButtonModel(
        icon: Icons.add, 
        heroTag: 'add', 
        onPressed: () async {
          bool updated = await _navigateToNewLog(); 
          _updateScaffold();
          if (updated) {
            _viewModel.refreshList();
          }
        }
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _viewModel.refreshList();
    _updateScaffold();

    return Material(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeAreaPadding.top,
          ),

          SliverAppBar(
            primary: false,
            actions: [
              IconButton(
                onPressed: () async {
                  await _navigateToHistoryFilter(_viewModel.searchFilter);
                  _updateScaffold();
                }, 
                icon: Icon(Icons.search),
              ),
            ],
            pinned: true,
            expandedHeight: 48.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(L10n.of(context)!.expenseHistory),
            ),
          ),
          
          if (_viewModel.searchFilter?.valid() ?? false) 
            SliverResizingHeader(
              minExtentPrototype: _collapsedFilter(context),
              maxExtentPrototype: _foldoutFilter(context),
              child: _foldoutFilter(context),
            ),

          ValueListenableBuilder(
            valueListenable: _viewModel.models, 
            builder: (_, models, _) => SliverList.list(
              children: [
                ...models.map(
                  (model) => HistoryListElement(
                    model: model,
                    navigateToDetail: (id) async {
                      bool updated = await _navigateToDetail(id);
                      _updateScaffold();
                      if (updated) {
                        _viewModel.refreshList();
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// SliverResizingHeaderで縮めたときのUI
  /// これを描画するわけではなく、表示の目安に設定する
  Widget _collapsedFilter(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      margin: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                L10n.of(context)!.expenseHistoryListFilter,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.check_box,
                size: 16.0,
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget _foldoutFilter(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      margin: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      // ScrollConfiguration()
      // 内部のScrollViewのスクロールバーを非表示にする
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child:SingleChildScrollView(
          // NeverScrollableScrollPhysics()
          // SliverResizingHeaderによって広がった場合にはすべてのコンテンツを表示するが、
          // 縮めた場合は欠けるようにする
          physics: NeverScrollableScrollPhysics(),
          child: HistoryListFilter(
            amount: _viewModel.searchFilter?.amount.active == true ? _viewModel.searchFilter?.amount : null, 
            usedAt: _viewModel.searchFilter?.usedAt.active == true &&
              _viewModel.searchFilter?.usedAt.range != null ? _viewModel.searchFilter?.usedAt : null, 
            categories: _viewModel.filterCategories, 
            shops: _viewModel.filterShops, 
            tags: _viewModel.filterTags,
          ),
        ),
      ),
    );
  }
}
