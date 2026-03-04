import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/budgeting_app_bottom_navigation.dart';
import 'package:budgeting_app/ui/history/view_models/history_detail_view_model.dart';
import 'package:flutter/material.dart';

class HistoryDetail extends StatefulWidget{
  const HistoryDetail({
    super.key,
    required HistoryDetailViewModel viewModel,
  }) : _viewModel = viewModel;

  final HistoryDetailViewModel _viewModel;

  @override
  HistoryDetailState createState() {
    return HistoryDetailState();
  }
}

class HistoryDetailState extends State<HistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.expenseHistoryDetail),
      ),
      bottomNavigationBar: bottomNavigationBar,
      body: Container(),
    );
  }
}