import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/budgeting_app_bottom_navigation.dart';
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
    required Function(BuildContext) navigateToHistoryEdit,
  }) : 
    _viewModel = viewModel,
    _navigateToHistoryEdit = navigateToHistoryEdit;

  final HistoryDetailViewModel _viewModel;
  final Function(BuildContext) _navigateToHistoryEdit;

  @override
  HistoryDetailState createState() {
    return HistoryDetailState();
  }
}

class HistoryDetailState extends State<HistoryDetail> {
  @override
  Widget build(BuildContext context) {
    widget._viewModel.init();

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.expenseHistoryDetail),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget._navigateToHistoryEdit(context);
        },
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: bottomNavigationBar,
      body: SingleChildScrollView(
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
    );
  }
}
