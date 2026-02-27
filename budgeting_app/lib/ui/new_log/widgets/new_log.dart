import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/new_log/models/category_model.dart';
import 'package:budgeting_app/ui/new_log/models/content_model.dart';
import 'package:budgeting_app/ui/new_log/models/log_model.dart';
import 'package:budgeting_app/ui/new_log/models/shop_model.dart';
import 'package:budgeting_app/ui/new_log/models/tag_model.dart';
import 'package:budgeting_app/ui/new_log/view_models/new_log_view_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';

class NewLog extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  NewLog({
    super.key,
    required NewLogViewModel viewModel,
  }): _viewModel = viewModel;

  final NewLogViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel.refreshCategoryList();
    _viewModel.refreshTagList();
    _viewModel.refreshShopList();

    final _AmountField amountField = _AmountField();
    final _ShopField shopField = _ShopField(shops: _viewModel.shopSelections);
    final _CategoryField categoryField = _CategoryField(categories: _viewModel.categorySelections);
    final _TagField tagField = _TagField(tags: _viewModel.tagSelections);
    final _ContentField contentField = _ContentField();

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.newLog),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 24.0,
            children: [
              SizedBox(height: 16.0),
              amountField,
              shopField,
              categoryField,
              tagField,
              contentField,

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _viewModel.onRequestAddLog(
                      LogModel(
                        amount: amountField.getInput(),
                        shop: shopField.getInput(),
                        category: categoryField.getInput(),
                        tags: tagField.getInput(),
                        contents: contentField.getInput(),
                      )
                    );
                  }, 
                  child: Text(
                    L10n.of(context)!.newLogAdd,
                  ),
                ),
              ),
              SizedBox(height: 16.0),           
            ],
          ),
        ),
      ),
    );
  }
}

/// 購入金額の入力UI
/// 
/// 入力の最大値は99,999,999とする
class _AmountField extends StatefulWidget {
  static const int _maxLength = 8;

  @override
  _AmountState createState() => _AmountState();

  final _amountController = TextEditingController();

  /// 入力されている値を取得
  int getInput() {
    return int.tryParse(_amountController.text) ?? 0;
  }
}

class _AmountState extends State<_AmountField> {

  @override
  void dispose() {
    widget._amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String pattern = '^[0-9.]+';
    final TextInputFormatter digitFormatter = FilteringTextInputFormatter.allow(RegExp(pattern));
      
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(title: L10n.of(context)!.newLogAmount),
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(12.0, 0, 12.0, 0),
          child: TextField(
            controller: widget._amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              digitFormatter,
            ],
            textAlign: TextAlign.right,
            maxLength: _AmountField._maxLength,
            onSubmitted: (String input) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffix: Text(
                L10n.of(context)!.commonPriceSuffix,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 8.0,
                ),
              ),
              hint: Text(
                L10n.of(context)!.newLogAmountHint,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 購入店舗の入力UI
class _ShopField extends StatefulWidget {
  _ShopField({
    required List<ShopModel> shops,
  }): _shops = shops;

  final List<ShopModel> _shops;

  final TextEditingController _shopEditingController = TextEditingController();

  @override
  _ShopState createState() => _ShopState();

  ShopModel? getInput() {
    return _shops.firstWhereOrNull(
      (shop) => shop.name == _shopEditingController.text,
    );
  }
}

class _ShopState extends State<_ShopField> {
  late List<ShopModel> _shops; 

  @override
  void initState() {
    super.initState();
    _shops = widget._shops;
  }

  @override
  void dispose() {
    widget._shopEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(title: L10n.of(context)!.newLogShop),
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(12.0, 0, 12.0, 0),
          child: _dropdown(context),
        ),
      ],
    );
  }

  Widget _dropdown(BuildContext context) {
    return DropdownMenu(
      controller: widget._shopEditingController,
      width: double.infinity,
      enableFilter: true,
      dropdownMenuEntries: [
        ..._shops.map(
          (category) => DropdownMenuEntry(
            value: category.id, 
            label: category.name,
          )
        ),
      ],
      onSelected: (value) => {},
    );
  }
}

/// 購入カテゴリーの入力UI
class _CategoryField extends StatefulWidget {
  _CategoryField({
    required List<CategoryModel> categories,
  }) : _categories = categories;
  
  final List<CategoryModel> _categories;
  List<CategoryModel> get categories => _categories;

  final TextEditingController _categoryEditingController = TextEditingController();

  @override
  _CategoryState createState() => _CategoryState();

  CategoryModel? getInput() {
    return _categories.firstWhereOrNull(
      (category) => category.name == _categoryEditingController.text,
    );
  }
}

class _CategoryState extends State<_CategoryField> {
  _CategoryState();

  late List<CategoryModel> _categories;

  @override
  void initState() {
    super.initState();
    _categories = widget.categories;
  }

  @override
  void dispose() {
    widget._categoryEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(title: L10n.of(context)!.newLogCategory),
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(12.0, 0, 12.0, 0),
          child: _dropdown(context),
        ),
      ],
    );
  }

  Widget _dropdown(BuildContext context) {
    return DropdownMenu(
      controller: widget._categoryEditingController,
      width: double.infinity,
      enableFilter: true,
      dropdownMenuEntries: [
        ..._categories.map(
          (category) => DropdownMenuEntry(
            value: category.id, 
            label: category.name,
          )
        ),
      ],
      onSelected: (value) {},
    );
  }
}

/// 購入タグの入力UI
/// タグは[_maxCount]個まで設定可能
class _TagField extends StatefulWidget {
  static const int _maxCount = 8;

  _TagField({
    required List<TagModel> tags,
  }): _tags = tags;

  final List<TagModel> _tags;

  final List<TextEditingController> _tagControllers = List.generate(_maxCount, (_) => TextEditingController());

  @override
  State<StatefulWidget> createState() => _TagState();

  List<TagModel?> getInput() {
    Map<String, TagModel> tagMap = { for (var tag in _tags) tag.name : tag };
    return _tagControllers.map(
      (controller) => tagMap[controller.text],
    ).toList();
  }
}

class _TagState extends State<_TagField> {
  late List<TagModel> _tags;

  @override
  void initState() {
    super.initState();
    _tags = widget._tags;
  }

  @override
  void dispose() {
    for (int i = 0; i < _TagField._maxCount; ++i) {
      widget._tagControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(title: L10n.of(context)!.newLogTag),
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(12.0, 0, 12.0, 0),
          child: Column(
            spacing: 12.0,
            children: [
              for(int i = 0; i < _TagField._maxCount; ++i) _dropdown(context, i),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dropdown(BuildContext context, int index) {
    return DropdownMenu(
      controller: widget._tagControllers[index],
      width: double.infinity,
      enableFilter: true,
      dropdownMenuEntries: [
        ..._tags.map(
          (tag) => DropdownMenuEntry(
            value: tag.id, 
            label: tag.name,
          )
        ),
      ],
      onSelected: (value) => {},
    );
  }
}

/// 購入詳細の入力UI
/// 
/// 購入詳細は[_maxCount]個まで入力可能
/// 
/// タイトルは最大[_titleMaxLength]文字まで
/// 
/// 概要は最大[_descriptionMaxLength]文字まで
class _ContentField extends StatefulWidget {
  static const int _maxCount = 4;
  static const int _titleMaxLength = 50;
  static const int _descriptionMaxLength = 300;

  @override
  _ContentState createState() => _ContentState();

  final List<TextEditingController> _titleEditingControllers = List.generate(_maxCount, (_) => TextEditingController());
  final List<TextEditingController> _descriptionEditingControllers = List.generate(_maxCount, (_) => TextEditingController());

  List<ContentModel> getInput() {
    List<ContentModel> list = [];

    for (int i = 0; i < _ContentField._maxCount; ++i) {
      list.add(
        ContentModel(
          title: _titleEditingControllers[i].text, 
          description: _descriptionEditingControllers[i].text
        )
      );
    }
    return list;
  }
}

class _ContentState extends State<_ContentField> {

  @override 
  void dispose() {
    for (int i = 0; i < _ContentField._maxCount; ++i) {
      widget._titleEditingControllers[i].dispose();
      widget._descriptionEditingControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    final String title = l10n.newLogContentTitle;
    final String description = l10n.newLogContentDescription;
    final InputBorder border = OutlineInputBorder();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(title: L10n.of(context)!.newLogContent),
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(12.0, 0, 12.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < _ContentField._maxCount; ++i) 
                ..._contentWidgets(
                  indexDescription: l10n.newLogContentIndex(i+1),
                  title: title, 
                  description: description, 
                  border: border,
                  titleEditingController: widget._titleEditingControllers[i],
                  descriptionEditingController: widget._descriptionEditingControllers[i],
                )
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _contentWidgets({
    required String indexDescription,
    required String title,
    required String description,
    required InputBorder border,
    required TextEditingController titleEditingController,
    required TextEditingController descriptionEditingController,
  }) {
    final FocusNode descriptionFocus = FocusNode();

    return [
      _SubHeader(title: indexDescription),

      SizedBox(
        height:12.0,
      ),

      // タイトル
      TextField(
        controller: titleEditingController,
        maxLength: _ContentField._titleMaxLength,
        onSubmitted: (value) => {
          descriptionFocus.requestFocus(),
        },
        decoration: InputDecoration(
          labelText: title,
          border: border,
        ),
      ),

      SizedBox(
        height: 12.0,
      ),

      // 概要
      TextField(
        controller: descriptionEditingController,
        focusNode: descriptionFocus,
        keyboardType: TextInputType.multiline,
        maxLength: _ContentField._descriptionMaxLength,
        minLines: 3,
        maxLines: 5,
        onSubmitted: (value) => {},
        decoration: InputDecoration(
          labelText: description,
          alignLabelWithHint: true,
          border: border,
        ),
      ),

      SizedBox(
        height:16.0,
      ),
    ];
  }
}

/// 共通の入力UIヘッダー
class _Header extends StatelessWidget {
  const _Header({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.fromLTRB(
        0.0, 8.0, 0.0, 8.0
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// サブヘッダー
class _SubHeader extends StatelessWidget {
  const _SubHeader({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

@Preview(
  name: 'Amount Field',
  wrapper: previewWrapper,
)
Widget previewAmountField() {
  return _AmountField();
}

@Preview(
  name: 'Shop Field',
  wrapper: previewWrapper,
)
Widget previewShopField() {
  return _ShopField(
    shops: [
      ShopModel(id: 0, name: 'A', ),
      ShopModel(id: 1, name: 'B', ),
      ShopModel(id: 2, name: 'C', ),
      ShopModel(id: 3, name: 'D', ),
      ShopModel(id: 4, name: 'E', ),
      ShopModel(id: 5, name: 'F', ),
      ShopModel(id: 6, name: 'G', ),
    ]
  );
}

@Preview(
  name: 'Category Field',
  wrapper: previewWrapper,
)
Widget previewCategoryField() {
  return _CategoryField(
    categories:[
      CategoryModel(id: 0, name: 'A', ),
      CategoryModel(id: 1, name: 'B', ),
      CategoryModel(id: 2, name: 'C', ),
      CategoryModel(id: 3, name: 'D', ),
      CategoryModel(id: 4, name: 'E', ),
      CategoryModel(id: 5, name: 'F', ),
      CategoryModel(id: 6, name: 'G', ),
    ]
  );
}

@Preview(
  name: 'Tag Field',
  wrapper: previewWrapper,
)
Widget perviewTagField() {
  return _TagField(
    tags: [
      TagModel(id: 0, name: 'A', ),
      TagModel(id: 1, name: 'B', ),
      TagModel(id: 2, name: 'C', ),
      TagModel(id: 3, name: 'D', ),
      TagModel(id: 4, name: 'E', ),
      TagModel(id: 5, name: 'F', ),
      TagModel(id: 6, name: 'G', ),
    ],
  );
}

@Preview(
  name: 'Content Field',
  wrapper: previewWrapper,
)
Widget previewContent() {
  return _ContentField();
}