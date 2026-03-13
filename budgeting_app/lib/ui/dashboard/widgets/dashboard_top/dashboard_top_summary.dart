import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/dashboard/models/dashboard_top_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:intl/intl.dart';

/// サマリー情報を表示する
class DashboardTopSummary extends StatelessWidget {
  const DashboardTopSummary({
    super.key,
    required DashboardTopSummaryModel model,
  })
    : _model = model;

  final DashboardTopSummaryModel _model;

  @override
  Widget build(BuildContext context) {
    final DateFormat inputDateFormat = DateFormat('yyyy-MM-dd');
    final from = '${_model.fromDate.substring(0,4)}-${_model.fromDate.substring(4,6)}-${_model.fromDate.substring(6,8)}';
    final to = '${_model.toDate.substring(0,4)}-${_model.toDate.substring(4,6)}-${_model.toDate.substring(6,8)}';

    final DateTime fromDate = inputDateFormat.parse(from);
    final DateTime toDate = inputDateFormat.parse(to);
    final DateFormat viewFormat = DateFormat(L10n.of(context)!.commonFullDateFormat);

    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${viewFormat.format(fromDate)}–${viewFormat.format(toDate)}',
            textAlign: TextAlign.center,
          ),

          Table(
            columnWidths: {
              0: IntrinsicColumnWidth(),
              1: FixedColumnWidth(32.0),
              2: FlexColumnWidth(1.0),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(L10n.of(context)!.dashboardTopAmountSum),
                  ),
                  
                  /// 最低限32.0の空間を空ける
                  Container(),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Spacer(),
                      Text(
                        _model.amountSum.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      SizedBox(width: 10.0),
                      Text(L10n.of(context)!.commonPriceSuffix),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

@Preview(
  name: 'summary',
  wrapper: previewWrapper,
)
Widget previewSummary() {
  return DashboardTopSummary(
    model: DashboardTopSummaryModel(
      amountSum: 1000000,
      fromDate: '20260101',
      toDate: '20260131',
    ),
  );
}