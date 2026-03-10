import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/models/filter/search_filter_model.dart';
import 'package:budgeting_app/ui/core/widget/stateful_checkbox.dart';
import 'package:budgeting_app/ui/history/models/history_filter_category_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_shop_model.dart';
import 'package:budgeting_app/ui/history/models/history_filter_tag_model.dart';
import 'package:budgeting_app/ui/history/view_models/history_filter_view_model.dart';
import 'package:budgeting_app/ui/history/widgets/history_filter/history_filter_amount_range.dart';
import 'package:budgeting_app/ui/history/widgets/history_filter/history_filter_selected_element.dart';
import 'package:budgeting_app/ui/history/widgets/history_filter/history_filter_term_range.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class HistoryFilter extends StatefulWidget {
  const HistoryFilter({
    super.key,
    required HistoryFilterViewModel viewModel,
    required Function(BuildContext, SearchFilterModel) navigateOnSubmit,
  }): 
    _viewModel = viewModel,
    _navigateOnSubmit = navigateOnSubmit;

  final HistoryFilterViewModel _viewModel;
  final Function(BuildContext, SearchFilterModel) _navigateOnSubmit;

  @override
  HistoryFilterState createState() {
    return HistoryFilterState();
  }
}

class HistoryFilterState extends State<HistoryFilter> {

  final TextEditingController _amountRangeMinController = TextEditingController();
  final TextEditingController _amountRangeMaxController = TextEditingController();

  @override
  void dispose() {
    _amountRangeMinController.dispose();
    _amountRangeMaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget._viewModel.loadData();

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
      Row(
        children: [
          Text(
            L10n.of(context)!.expenseHistoryFilterAmount,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(width:25.0),
          Text(L10n.of(context)!.expenseHistoryFilterActive),
          StatefulCheckbox(
            notifier: widget._viewModel.amountFilterActive, 
            onChanged: (active) => widget._viewModel.setAmountFilterActive(active ?? false),
          ),
        ],
      ),
      ValueListenableBuilder(
        valueListenable: widget._viewModel.amount, 
        builder: (_, amountFilter, _) {
          _amountRangeMinController.text = amountFilter.min.toString();
          _amountRangeMaxController.text = amountFilter.max.toString();
          return HistoryFilterAmountRange(
            minFieldController: _amountRangeMinController, 
            maxFieldController: _amountRangeMaxController,
            active: amountFilter.active,
            rangeChanged: widget._viewModel.onAmountRangeChanged,
          );
        },
      ),
    ];
  }

  /// 日付範囲のフィルタ
  List<Widget> _usedAtFilterWidget(BuildContext context) {
    return [
      Row(
        children: [
          Text(
            L10n.of(context)!.expenseHistoryFilterUsedAt,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(width:25.0),
          Text(L10n.of(context)!.expenseHistoryFilterActive),
          StatefulCheckbox(
            notifier: widget._viewModel.usedAtFilterActive, 
            onChanged: (active) => widget._viewModel.setDateTimeFilterActive(active ?? false),
          ),
        ],
      ),

      ValueListenableBuilder(
        valueListenable: widget._viewModel.usedAt, 
        builder: (_, dateTimeFilter, _) {
          return HistoryFilterTermRange(
            model: dateTimeFilter, 
            active: dateTimeFilter.active,
            onRangeChanged: widget._viewModel.onDateTimeRangeChanged,
          );
        },
      ),
    ];
  }

  /// カテゴリー選択
  Widget _categoryFilterWidget(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverHeader(
            title: L10n.of(context)!.expenseHistoryFilterCategory,
            contents: (context) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(L10n.of(context)!.expenseHistoryFilterActive),
                StatefulCheckbox(
                  notifier: widget._viewModel.categoriesFilterActive, 
                  onChanged: (active) => widget._viewModel.setCategoryFilterActive(active ?? false),
                ),
              ],
            ),
          ),
        ),

        ValueListenableBuilder(
          valueListenable: widget._viewModel.selectedCategories,
          builder: (_, selectedCategories, _) => SliverList.list(
            children:[
              SizedBox(height: 8.0,),

              Opacity(
                opacity: selectedCategories.active ? 1.0 : 0.5,
                child: AbsorbPointer(
                  absorbing: !selectedCategories.active,
                  child: ValueListenableBuilder(
                    valueListenable: widget._viewModel.categories, 
                    builder: (_, categories, _) => DropdownMenu(
                      dropdownMenuEntries: categories.map(
                        (category) => DropdownMenuEntry(
                          value: category.id, 
                          label: category.name,
                        )
                      ).toList(),
                      onSelected: (id) { 
                        if (id != null) {
                          widget._viewModel.onCategorySelected(id);
                        }
                      },
                    ),
                  ),   
                ),
              ),

              SizedBox(height: 8.0,),

              if (selectedCategories.active)
                ValueListenableBuilder(
                  valueListenable: widget._viewModel.categories,
                  builder: (_, categories, _) {
                    final List<HistoryFilterCategoryModel> modelList = [];
                    for (int selected in selectedCategories.selectedList) {
                      HistoryFilterCategoryModel? model = categories.firstWhereOrNull((model) => model.id == selected);
                      if (model != null) {
                        modelList.add(model);
                      }
                    }
                    
                    return Wrap(
                      children: modelList.map(
                        (model) => HistoryFilterSelectedElement(
                          id: model.id, 
                          name: model.name, 
                          onClickCloseIcon: widget._viewModel.onCategoryDeselect,
                        ),
                      ).toList(),
                    );
                  },
                ),
            ],
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
          delegate: _SliverHeader(
            title: L10n.of(context)!.expenseHistoryFilterShop,
            contents: (context) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(L10n.of(context)!.expenseHistoryFilterActive),
                StatefulCheckbox(
                  notifier: widget._viewModel.shopsFilterActive, 
                  onChanged: (active) => widget._viewModel.setShopFilterActive(active ?? false),
                ),
              ],
            ),
          ),
        ),

        ValueListenableBuilder(
          valueListenable: widget._viewModel.selectedShops,
          builder: (_, selectedShops, _) => SliverList.list(
            children:[
              SizedBox(height: 8.0,),

              Opacity(
                opacity: selectedShops.active ? 1.0 : 0.5,
                child: AbsorbPointer(
                  absorbing: !selectedShops.active,
                  child: ValueListenableBuilder(
                    valueListenable: widget._viewModel.shops, 
                    builder: (_, shops, _) => DropdownMenu(
                      dropdownMenuEntries: shops.map(
                        (shop) => DropdownMenuEntry(
                          value: shop.id, 
                          label: shop.name,
                        )
                      ).toList(),
                      onSelected: (id) { 
                        if (id != null) {
                          widget._viewModel.onShopSelected(id);
                        }
                      },
                    ),
                  ),   
                ),
              ),

              SizedBox(height: 8.0,),

              if (selectedShops.active)
                ValueListenableBuilder(
                  valueListenable: widget._viewModel.shops,
                  builder: (_, shops, _) {
                    final List<HistoryFilterShopModel> modelList = [];
                    for (int selected in selectedShops.selectedList) {
                      HistoryFilterShopModel? model = shops.firstWhereOrNull((model) => model.id == selected);
                      if (model != null) {
                        modelList.add(model);
                      }
                    }
                    
                    return Wrap(
                      children: modelList.map(
                        (model) => HistoryFilterSelectedElement(
                          id: model.id, 
                          name: model.name, 
                          onClickCloseIcon: widget._viewModel.onShopDeselect,
                        ),
                      ).toList(),
                    );
                  },
                ),
            ],
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
          delegate: _SliverHeader(
            title: L10n.of(context)!.expenseHistoryFilterTag,
            contents: (context) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(L10n.of(context)!.expenseHistoryFilterActive),
                StatefulCheckbox(
                  notifier: widget._viewModel.tagsFilterActive, 
                  onChanged: (active) => widget._viewModel.setTagFilterActive(active ?? false),
                ),
              ],
            ),
          ),
        ),

        ValueListenableBuilder(
          valueListenable: widget._viewModel.selectedTags,
          builder: (_, selectedTags, _) => SliverList.list(
            children:[
              SizedBox(height: 8.0,),

              Opacity(
                opacity: selectedTags.active ? 1.0 : 0.5,
                child: AbsorbPointer(
                  absorbing: !selectedTags.active,
                  child: ValueListenableBuilder(
                    valueListenable: widget._viewModel.tags, 
                    builder: (_, tags, _) => DropdownMenu(
                      dropdownMenuEntries: tags.map(
                        (tag) => DropdownMenuEntry(
                          value: tag.id, 
                          label: tag.name,
                        )
                      ).toList(),
                      onSelected: (id) { 
                        if (id != null) {
                          widget._viewModel.onTagSelected(id);
                        }
                      },
                    ),
                  ),   
                ),
              ),

              SizedBox(height: 8.0,),

              if (selectedTags.active)
                ValueListenableBuilder(
                  valueListenable: widget._viewModel.tags,
                  builder: (_, tags, _) {
                    final List<HistoryFilterTagModel> modelList = [];
                    for (int selected in selectedTags.selectedList) {
                      HistoryFilterTagModel? model = tags.firstWhereOrNull((model) => model.id == selected);
                      if (model != null) {
                        modelList.add(model);
                      }
                    }
                    
                    return Wrap(
                      children: modelList.map(
                        (model) => HistoryFilterSelectedElement(
                          id: model.id, 
                          name: model.name, 
                          onClickCloseIcon: widget._viewModel.onTagDeselect,
                        ),
                      ).toList(),
                    );
                  },
                ),
            ],
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
        onPressed: () => widget._navigateOnSubmit(context, widget._viewModel.createSearchFilter()), 
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
    Widget Function(BuildContext)? contents,
  }): 
    _title = title, 
    _contents = contents;

  final String _title;

  final Widget Function(BuildContext)? _contents;

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
      child: Row(
        children:[
          Text(
            _title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),

          SizedBox(width: 25.0),

          if (_contents != null) _contents(context),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return minExtent != oldDelegate.minExtent ||
      maxExtent != oldDelegate.maxExtent;
  }
}
