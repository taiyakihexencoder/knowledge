import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/models/edit/log_model.dart';
import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:budgeting_app/ui/core/widget/expense_log_form.dart';
import 'package:budgeting_app/ui/history/view_models/history_edit_view_model.dart';
import 'package:flutter/material.dart';

class HistoryEdit extends StatefulWidget {
  const HistoryEdit({
    super.key,
    required HistoryEditViewModel viewModel,
    required void Function() navigateOnSubmit,
  }):
    _viewModel = viewModel,
    _navigateOnSubmit = navigateOnSubmit;

  final HistoryEditViewModel _viewModel;
  final void Function() _navigateOnSubmit;

  @override
  HistoryEditState createState() {
    return HistoryEditState();
  }
}

class HistoryEditState extends State<HistoryEdit> {
  void _updateScaffold({ required String topBarTitle}) {
    mainFrameViewModel.showTopBar(title: topBarTitle);
    mainFrameViewModel.hideNavigator();
    mainFrameViewModel.setFloatingActionButton();
  }

  @override
  Widget build(BuildContext context) {
    String topBarTitle = L10n.of(context)!.expenseHistoryEdit;
    _updateScaffold(topBarTitle: topBarTitle);

    widget._viewModel.refreshCategoryList();
    widget._viewModel.refreshTagList();
    widget._viewModel.refreshShopList();

    return Material(
      child: Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: FutureBuilder(
          future: widget._viewModel.getDetail(), 
          builder: (context, logModel) {
            if (logModel.hasData) {
              return ExpenseLogForm(
                initialValue: logModel.data ?? LogModel(usedAt: '', amount: 0, shop: null, category: null, tags: [], contents: []),
                onSubmit: (model) {
                  widget._viewModel.onRequestUpdateLog(model);
                  // 本来は追加失敗をチェックするがここでは省略
                  return Future.value(true);
                },
                navigateOnSubmit: widget._navigateOnSubmit,
                shopEntries: widget._viewModel.shopSelections,
                categoryEntries: widget._viewModel.categorySelections,
                tagEntries: widget._viewModel.tagSelections,
                onRequestAddShopName: widget._viewModel.onRequestAddShopName,
                onRequestAddCategoryName: widget._viewModel.onRequestAddCategoryName,
                onRequestAddTagName: widget._viewModel.onRequestAddTagName,
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
