import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/budgeting_app_bottom_navigation.dart';
import 'package:budgeting_app/ui/core/widget/ok_cancel_dialog.dart';
import 'package:budgeting_app/ui/core/widget/text_field_dialog.dart';
import 'package:budgeting_app/ui/settings/models/category_model.dart';
import 'package:budgeting_app/ui/settings/models/shop_model.dart';
import 'package:budgeting_app/ui/settings/models/tag_model.dart';
import 'package:budgeting_app/ui/settings/view_models/settings_attributes_view_model.dart';
import 'package:budgeting_app/ui/settings/widgets/settings_attributes/settings_attributes_category.dart';
import 'package:budgeting_app/ui/settings/widgets/settings_attributes/settings_attributes_shop.dart';
import 'package:budgeting_app/ui/settings/widgets/settings_attributes/settings_attributes_tag.dart';
import 'package:flutter/material.dart';

class SettingsAttributes extends StatefulWidget {
  SettingsAttributes({
    super.key,
    required SettingsAttributesViewModel viewModel,
  }): 
    _viewModel = viewModel,
    _onRequestAddShop = viewModel.onRequestAddShopName,
    _onRequestEditShop = viewModel.onRequestUpdateShopName,
    _onRequestDeleteShop = viewModel.onRequestDeleteShopName,
    _onRequestAddCategory = viewModel.onRequestAddCategoryName,
    _onRequestEditCategory = viewModel.onRequestUpdateCategoryName,
    _onRequestDeleteCategory = viewModel.onRequestDeleteCategoryName,
    _onRequestAddTag = viewModel.onRequestAddTagName,
    _onRequestEditTag = viewModel.onRequestUpdateTagName,
    _onRequestDeleteTag = viewModel.onRequestDeleteTagName;

  final SettingsAttributesViewModel _viewModel;

  final Function(String) _onRequestAddShop;
  final Function(int, String) _onRequestEditShop;
  final Function(int) _onRequestDeleteShop;

  final Function(String) _onRequestAddCategory;
  final Function(int, String) _onRequestEditCategory;
  final Function(int) _onRequestDeleteCategory;

  final Function(String) _onRequestAddTag;
  final Function(int, String) _onRequestEditTag;
  final Function(int) _onRequestDeleteTag;

  @override
  SettingsAttributesState createState() {
    return SettingsAttributesState();
  }
}

class SettingsAttributesState extends State<SettingsAttributes> {
  @override
  Widget build(BuildContext context) {
    widget._viewModel.updateShopList();
    widget._viewModel.updateCategoryList();
    widget._viewModel.updateTagList();

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.settingsAttributes),
      ),
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
        child: CustomScrollView(
          slivers: [
            _shopWidgetGroup(),
            _categoryWidgetGroup(),
            _tagWidgetGroup(),
          ],
        ),
      ),
    );
  }

  Widget _addButton({
    required Function() onClick,
  }) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton.filled(
        onPressed: onClick,
        icon: Icon(
          Icons.add,
        )
      ),
    );
  }

  /// 購入先リストビュー
  SliverMainAxisGroup _shopWidgetGroup() {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverHeader(
            title: L10n.of(context)!.settingsAttributesShop,
          ),
        ),

        ValueListenableBuilder(
          valueListenable: widget._viewModel.shops, 
          builder: (_, shops, _) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SettingsAttributesShopListElement(
                model: shops[index],
                onClickEdit: _onClickEditShop,
                onClickDelete: _onClickDeleteShop,
              ),
              childCount: shops.length,
            ),
          )
        ),
        SliverList.list(
          children: [
            SizedBox(height: 24.0),
            _addButton(onClick: _onClickAddShop),
            SizedBox(height: 48.0),
          ],
        ),
      ],
    );
  }

  /// リスト末尾の+ボタンを押したときの挙動
  /// 
  /// 追加ダイアログを開き、入力したテキストで購入先を追加する
  void _onClickAddShop() async {
    await TextFieldDialog.show(
      context: context,
      onCancel: (){
        Navigator.pop(context);
      },
      onDone: (text) {
        Navigator.pop(context);
        widget._onRequestAddShop(text);
      },
      title: L10n.of(context)!.settingsAttributesAddShop,
      description: L10n.of(context)!.settingsAttributesEditShopDescription,
      barrierDismissible: false,
    );
  }

  /// リストのeditボタンを押したときの挙動
  /// 
  /// 編集ダイアログを開き、入力したテキストに変更があれば購入先の名称を更新する
  void _onClickEditShop(ShopModel model) async {
    await TextFieldDialog.show(
      context: context, 
      onCancel: () {
        Navigator.pop(context);
      }, 
      onDone: (text){
        Navigator.pop(context);
        if (model.name != text) {
          widget._onRequestEditShop(model.id, text);
        }
      },
      title: L10n.of(context)!.settingsAttributesEditShop,
      description: L10n.of(context)!.settingsAttributesEditShopDescription,
      barrierDismissible: false,
      defaultText: model.name
    );
  }

  /// リストのdeleteボタンを押したときの挙動
  /// 
  /// 確認ダイアログを開き、OKで削除
  void _onClickDeleteShop(ShopModel model) async {
    await OkCancelDialog.show(
      context: context,
      onCancel: () {
        Navigator.pop(context);
      },
      onOk: () {
        Navigator.pop(context);
        widget._onRequestDeleteShop(model.id);
      },
      description: L10n.of(context)!.settingsAttributesDeleteShop(model.name),
    );
  } 

  /// 購入カテゴリーリストビュー
  SliverMainAxisGroup _categoryWidgetGroup() {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverHeader(
            title: L10n.of(context)!.settingsAttributesCategory,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget._viewModel.categories,
          builder: (_, categories, _) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SettingsAttributesCategoryListElement(
                model: categories[index], 
                onClickEdit: _onClickEditCategory, 
                onClickDelete: _onClickDeleteCategory,
              ),
              childCount: categories.length,
            )
          ),
        ),
        SliverList.list(
          children: [
            SizedBox(height:24.0),
            _addButton(onClick: _onClickAddCategory),
            SizedBox(height: 48.0),
          ],
        ),
      ],
    );
  }

  /// リスト末尾の+ボタンを押したときの挙動
  /// 
  /// 追加ダイアログを開き、入力したテキストで購入先を追加する
  void _onClickAddCategory() async {
    await TextFieldDialog.show(
      context: context,
      onCancel: (){
        Navigator.pop(context);
      },
      onDone: (text) {
        Navigator.pop(context);
        widget._onRequestAddCategory(text);
      },
      title: L10n.of(context)!.settingsAttributesAddCategory,
      description: L10n.of(context)!.settingsAttributesEditCategoryDescription,
      barrierDismissible: false,
    );
  }

  /// リストのeditボタンを押したときの挙動
  /// 
  /// 編集ダイアログを開き、入力したテキストに変更があれば購入先の名称を更新する
  void _onClickEditCategory(CategoryModel model) async {
    await TextFieldDialog.show(
      context: context, 
      onCancel: () {
        Navigator.pop(context);
      }, 
      onDone: (text){
        Navigator.pop(context);
        if (model.name != text) {
          widget._onRequestEditCategory(model.id, text);
        }
      },
      title: L10n.of(context)!.settingsAttributesEditCategory,
      description: L10n.of(context)!.settingsAttributesEditCategoryDescription,
      barrierDismissible: false,
      defaultText: model.name
    );
  }

  /// リストのdeleteボタンを押したときの挙動
  /// 
  /// 確認ダイアログを開き、OKで削除
  void _onClickDeleteCategory(CategoryModel model) async {
    await OkCancelDialog.show(
      context: context,
      onCancel: () {
        Navigator.pop(context);
      },
      onOk: () {
        Navigator.pop(context);
        widget._onRequestDeleteCategory(model.id);
      },
      description: L10n.of(context)!.settingsAttributesDeleteCategory(model.name),
    );
  }

  SliverMainAxisGroup _tagWidgetGroup() {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverHeader(
            title: L10n.of(context)!.settingsAttributesTag,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget._viewModel.tags, 
          builder: (_, tags, _) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SettingsAttributesTagListElement(
                model: tags[index], 
                onClickEdit: _onClickEditTag, 
                onClickDelete: _onClickDeleteTag,
              ),
              childCount: tags.length,
            ),
          ),
        ),
        SliverList.list(
          children: [
            SizedBox(height:24.0),
            _addButton(onClick: _onClickAddTag),
            SizedBox(height: 48.0),
          ],
        )
      ]
    );
  }

  /// リスト末尾の+ボタンを押したときの挙動
  /// 
  /// 追加ダイアログを開き、入力したテキストで購入先を追加する
  void _onClickAddTag() async {
    await TextFieldDialog.show(
      context: context,
      onCancel: (){
        Navigator.pop(context);
      },
      onDone: (text) {
        Navigator.pop(context);
        widget._onRequestAddTag(text);
      },
      title: L10n.of(context)!.settingsAttributesAddTag,
      description: L10n.of(context)!.settingsAttributesEditTagDescription,
      barrierDismissible: false,
    );
  }

  /// リストのeditボタンを押したときの挙動
  /// 
  /// 編集ダイアログを開き、入力したテキストに変更があれば購入先の名称を更新する
  void _onClickEditTag(TagModel model) async {
    await TextFieldDialog.show(
      context: context, 
      onCancel: () {
        Navigator.pop(context);
      }, 
      onDone: (text){
        Navigator.pop(context);
        if (model.name != text) {
          widget._onRequestEditTag(model.id, text);
        }
      },
      title: L10n.of(context)!.settingsAttributesEditTag,
      description: L10n.of(context)!.settingsAttributesEditTagDescription,
      barrierDismissible: false,
      defaultText: model.name
    );
  }

  /// リストのdeleteボタンを押したときの挙動
  /// 
  /// 確認ダイアログを開き、OKで削除
  void _onClickDeleteTag(TagModel model) async {
    await OkCancelDialog.show(
      context: context,
      onCancel: () {
        Navigator.pop(context);
      },
      onOk: () {
        Navigator.pop(context);
        widget._onRequestDeleteTag(model.id);
      },
      description: L10n.of(context)!.settingsAttributesDeleteTag(model.name),
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
