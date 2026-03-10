import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/models/filter/amount_filter_model.dart';
import 'package:budgeting_app/ui/core/models/filter/date_filter_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 履歴リストのフィルタ情報部分
class HistoryListFilter extends StatelessWidget{
  /// amount: 金額範囲。検索に含まれていなければnull
  /// 
  /// usedAt: 対象期間。検索に含まれていなければnull
  ///
  /// categories: 検索条件に指定したカテゴリーの名前リスト
  /// 
  /// shops: 検索条件に指定した購入先の名前リスト
  /// 
  /// tags: 検索条件に指定したタグの名前リスト
  const HistoryListFilter({
    super.key,
    required AmountFilterModel? amount,
    required DateFilterModel? usedAt,
    required ValueListenable<List<String>> categories,
    required ValueListenable<List<String>> shops,
    required ValueListenable<List<String>> tags,
  }): 
    _amount = amount,
    _usedAt = usedAt,
    _categories = categories,
    _shops = shops,
    _tags = tags;

  final AmountFilterModel? _amount;
  final DateFilterModel? _usedAt;
  final ValueListenable<List<String>> _categories;
  final ValueListenable<List<String>> _shops;
  final ValueListenable<List<String>> _tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children:[
            Text(
              L10n.of(context)!.expenseHistoryListFilter,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width:8),
            Icon(
              Icons.check_box,
              size: 16.0,
            ),
          ]
        ),

        if (_amount != null) 
          _amountFilterWidget(
            context: context,
            model: _amount
          ),

        if (_usedAt != null)
          _usedAtFilterWidget(
            context: context, 
            model: _usedAt,
          ),

        ValueListenableBuilder(
          valueListenable: _categories, 
          builder: (_, categories, _) => _listFilterWidget(
            title: L10n.of(context)!.expenseHistoryListFilterCategory, 
            filter: categories
          ),
        ),

        ValueListenableBuilder(
          valueListenable: _shops,
          builder: (_, shops, _) => _listFilterWidget(
            title: L10n.of(context)!.expenseHistoryListFilterShop,
            filter: shops
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _tags, 
          builder: (_, tags, _) => _listFilterWidget(
            title: L10n.of(context)!.expenseHistoryListFilterTag,
            filter: tags),
        ),
      ],
    );
  }

  /// 金額範囲の表示
  Widget _amountFilterWidget({
    required BuildContext context, 
    required AmountFilterModel model,
  }) {
    return Text(
      '${L10n.of(context)!.expenseHistoryFilterAmount} : '
      '${L10n.of(context)!.commonPrice(model.min)} – ${L10n.of(context)!.commonPrice(model.max)}',
    );
  }

  /// 対象期間の表示
  Widget _usedAtFilterWidget({
    required BuildContext context, 
    required DateFilterModel model,
  }) {
    final DateFormat viewFormat = DateFormat(L10n.of(context)!.commonFullDateFormat);
    return Text(
      '${L10n.of(context)!.expenseHistoryFilterUsedAt} : '
      '${viewFormat.format(model.range!.start)} – ${viewFormat.format(model.range!.end)}'
    );
  }

  /// カテゴリー・購入先・タグの表示
  Widget _listFilterWidget({
    required String title, 
    required List<String> filter,
  }) {
    if (filter.isNotEmpty) {
      return Text('$title : ${filter.join(', ')}');
    } else {
      return Container();
    }
  }
}