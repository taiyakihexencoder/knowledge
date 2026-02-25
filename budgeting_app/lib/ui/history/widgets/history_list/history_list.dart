import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/history/view_models/history_list_view_model.dart';
import 'package:budgeting_app/ui/history/widgets/history_list/history_list_element.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  HistoryList({
    super.key,
    required HistoryListViewModel viewModel,
    required Function(BuildContext context) navigateToNewLog,
  }) : 
  _viewModel = viewModel,
  _navigateToNewLog = navigateToNewLog;

  final HistoryListViewModel _viewModel;
  final Function(BuildContext) _navigateToNewLog;

  @override
  Widget build(BuildContext context) {
    _viewModel.refreshList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNewLog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 48.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(L10n.of(context)!.expenseHistory),
            ),
          ),
          SliverList.list(
            children: [
              ..._viewModel.models.map(
                (model) => HistoryListElement(
                  model: model,
                )
              ),
            ],
          ),
        ],
      )
    );
  }
}
