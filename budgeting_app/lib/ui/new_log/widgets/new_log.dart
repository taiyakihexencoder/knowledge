import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/models/edit/log_model.dart';
import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:budgeting_app/ui/new_log/view_models/new_log_view_model.dart';
import 'package:budgeting_app/ui/core/widget/expense_log_form.dart';
import 'package:flutter/material.dart';

class NewLog extends StatelessWidget {
  const NewLog({
    super.key,
    required NewLogViewModel viewModel,
    String? startDate,
    required Function() navigateOnSubmit,
  }): 
    _viewModel = viewModel,
    _startDate = startDate,
    _navigateOnSubmit = navigateOnSubmit;

  final NewLogViewModel _viewModel;
  final String? _startDate;
  final Function() _navigateOnSubmit;

  void _updateScaffold(BuildContext context) {
    mainFrameViewModel.showTopBar(title: L10n.of(context)!.newLog);
    mainFrameViewModel.hideNavigator();
    mainFrameViewModel.setFloatingActionButton();    
  }

  @override
  Widget build(BuildContext context) {
    _updateScaffold(context);    
    _viewModel.refreshCategoryList();
    _viewModel.refreshTagList();
    _viewModel.refreshShopList();

    return Material(
      child: Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: ExpenseLogForm(
          initialValue: LogModel(
            usedAt: _startDate ?? '',
            amount: 0,
            shop: null,
            category: null,
            tags: [],
            contents: [],
          ),
          onSubmit: (model) {
            _viewModel.onRequestAddLog(model);
            // 本来は追加失敗をチェックするがここでは省略
            return Future.value(true);
          },
          navigateOnSubmit: _navigateOnSubmit,
          shopEntries: _viewModel.shopSelections,
          categoryEntries: _viewModel.categorySelections,
          tagEntries: _viewModel.tagSelections,
          onRequestAddShopName: _viewModel.onRequestAddShopName,
          onRequestAddCategoryName: _viewModel.onRequestAddCategoryName,
          onRequestAddTagName: _viewModel.onRequestAddTagName,
        ),
      ),
    );
  }
}
