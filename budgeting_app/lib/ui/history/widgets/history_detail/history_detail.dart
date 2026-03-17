import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/models/floating_action_button_model.dart';
import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:budgeting_app/ui/core/widget/project_navigator.dart';
import 'package:budgeting_app/ui/history/view_models/history_detail_view_model.dart';
import 'package:budgeting_app/ui/history/widgets/history_detail/history_detail_amount.dart';
import 'package:budgeting_app/ui/history/widgets/history_detail/history_detail_category.dart';
import 'package:budgeting_app/ui/history/widgets/history_detail/history_detail_content.dart';
import 'package:budgeting_app/ui/history/widgets/history_detail/history_detail_shop.dart';
import 'package:budgeting_app/ui/history/widgets/history_detail/history_detail_tag.dart';
import 'package:budgeting_app/ui/history/widgets/history_detail/history_detail_used_at.dart';
import 'package:flutter/material.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({
    super.key,
    required HistoryDetailViewModel viewModel,
    required Future<bool> Function() navigateToHistoryEdit,
    required Function(bool) popScreen,
  }) : 
    _viewModel = viewModel,
    _navigateToHistoryEdit = navigateToHistoryEdit,
    _popScreen = popScreen;

  final HistoryDetailViewModel _viewModel;
  final Future<bool> Function() _navigateToHistoryEdit;
  final Function(bool) _popScreen;

  @override
  HistoryDetailState createState() {
    return HistoryDetailState();
  }
}

class HistoryDetailState extends State<HistoryDetail> {
  @override
  void initState() {
    super.initState();
    navigator.overrideAppBarPop(_pop);
  }

  @override
  void dispose() {
    navigator.disposeOverrideAppBarPop();
    super.dispose();
  }

  void _updateScaffold() {
    mainFrameViewModel.showTopBar(title: L10n.of(context)!.expenseHistoryDetail);
    mainFrameViewModel.showNavigator();
    mainFrameViewModel.setFloatingActionButton([
      FloatingActionButtonModel(
        icon: Icons.edit, 
        heroTag: 'edit', 
        onPressed: () async { 
          bool updateLog = await widget._navigateToHistoryEdit(); 
          _updateScaffold();

          if (updateLog) {
            widget._viewModel.init();
            widget._viewModel.onHistoryEdited();
          }
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _updateScaffold();
    widget._viewModel.init();

    return Material(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) { _pop(); }
        },
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 32.0, 24.0, 32.0),
          child: ValueListenableBuilder(
            valueListenable: widget._viewModel.model, 
            builder: (_, history, _) {
              if (history != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 32.0,
                  children: [
                    HistoryDetailUsedAt(
                      usedAt: history.usedAt,
                    ),
                    HistoryDetailAmount(
                      amount: history.amount,
                    ),
                    HistoryDetailShop(shop: history.shop),
                    HistoryDetailCategory(category: history.category),
                    HistoryDetailTag(tags: history.tags),
                    HistoryDetailContent(models: history.contents),
                  ],
                );
              }
              else {
                return Text(
                  L10n.of(context)!.expenseHistoryDetailFailed,
                );
              } 
            },
          ),
        ),

      )
    );
  }

  void _pop() {
    widget._popScreen(widget._viewModel.historyEdited);
  }
}
