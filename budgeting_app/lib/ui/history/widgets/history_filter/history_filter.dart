import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/history/view_models/history_filter_view_model.dart';
import 'package:flutter/material.dart';

class HistoryFilter extends StatelessWidget{
  const HistoryFilter({
    super.key,
    required HistoryFilterViewModel viewModel,
    required Function(BuildContext) navigateOnSubmit,
  }): 
    _viewModel = viewModel,
    _navigateOnSubmit = navigateOnSubmit;

  final HistoryFilterViewModel _viewModel;
  final Function(BuildContext) _navigateOnSubmit;

  @override
  Widget build(BuildContext context) {
    _viewModel.loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.expenseHistoryFilter),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: CustomScrollView(
          slivers: [
            SliverList.list(
              children: [
                // 金額
                ..._amountFilterWidget(context),

                // 日付
                ..._usedAtFilterWidget(context),
              ],
            ),
            
            SliverPadding(
              padding: EdgeInsets.only(bottom: 16.0),
            ),

            // カテゴリー
            _categoryFilterWidget(context),

            SliverPadding(
              padding: EdgeInsets.only(bottom: 16.0),
            ),

            // 店舗
            _shopFilterWidget(context),

            SliverPadding(
              padding: EdgeInsets.only(bottom: 16.0),
            ),

            // タグ
            _tagFilterWidget(context),

            SliverPadding(
              padding: EdgeInsets.only(bottom: 16.0),
            ),

            SliverList.list(
              children: [
                _applyButton(context),
              ],
            )
          ]
        ),
      ),
    );
  }

  /// 金額範囲のフィルタ
  List<Widget> _amountFilterWidget(BuildContext context) {
    return [
      ValueListenableBuilder(
        valueListenable: _viewModel.amount, 
        builder: (_, amountFilter, _) => Container(),
      ),
    ];
  }

  /// 日付範囲のフィルタ
  List<Widget> _usedAtFilterWidget(BuildContext context) {
    return [
      ValueListenableBuilder(
        valueListenable: _viewModel.usedAt, 
        builder: (_, dateTimeRange, _) => Container(),
      ),
    ];
  }

  /// カテゴリー選択
  Widget _categoryFilterWidget(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverHeader(title: L10n.of(context)!.expenseHistoryFilterCategory),
        ),

        ValueListenableBuilder(
          valueListenable: _viewModel.categories,
          builder: (_, tags, _) => SliverList.list(
            children:[]
          ),
        ),
      ],
    );
  }

  /// 購入先選択
  Widget _shopFilterWidget(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverHeader(title: L10n.of(context)!.expenseHistoryFilterShop),
        ),

        ValueListenableBuilder(
          valueListenable: _viewModel.shops,
          builder: (_, tags, _) => SliverList.list(
            children:[]
          ),
        ),
      ],
    );
  }

  /// タグ選択
  Widget _tagFilterWidget(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverHeader(title: L10n.of(context)!.expenseHistoryFilterTag),
        ),

        ValueListenableBuilder(
          valueListenable: _viewModel.tags,
          builder: (_, tags, _) => SliverList.list(
            children:[]
          ),
        ),
      ],
    );
  }

  /// 適用ボタン
  Widget _applyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _navigateOnSubmit(context), 
        child: Text(
          L10n.of(context)!.expenseHistoryFilterApply,
        ),
      ),
    );
  }
}

/// グループ内スクロールはSticky、それ以外はスクロールアウトする共通のヘッダー
class _SliverHeader extends SliverPersistentHeaderDelegate {
  const _SliverHeader({
    required String title,
  }): _title = title;

  final String _title;

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(),
        )
      ),
      padding: EdgeInsets.fromLTRB(
        0.0, 8.0, 0.0, 8.0
      ),
      child: Text(
        _title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return minExtent != oldDelegate.minExtent ||
      maxExtent != oldDelegate.maxExtent;
  }
}
