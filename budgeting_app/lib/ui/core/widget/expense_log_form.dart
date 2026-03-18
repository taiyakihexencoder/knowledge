import 'dart:math';

import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/models/edit/category_model.dart';
import 'package:budgeting_app/ui/core/models/edit/content_model.dart';
import 'package:budgeting_app/ui/core/models/edit/log_model.dart';
import 'package:budgeting_app/ui/core/models/edit/shop_model.dart';
import 'package:budgeting_app/ui/core/models/edit/tag_model.dart';
import 'package:budgeting_app/ui/core/models/snack_bar_model.dart';
import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:budgeting_app/ui/core/widget/comment_form.dart';
import 'package:budgeting_app/ui/core/widget/date_selector_form.dart';
import 'package:budgeting_app/ui/core/widget/extendable_selector_form.dart';
import 'package:budgeting_app/ui/core/widget/price_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 共通の履歴入力フォーム
class ExpenseLogForm extends StatefulWidget{
  const ExpenseLogForm({
    super.key,
    required Future<bool> Function(LogModel) onSubmit,
    required ValueListenable<List<ShopModel>> shopEntries,
    required ValueListenable<List<CategoryModel>> categoryEntries,
    required ValueListenable<List<TagModel>> tagEntries,
    required Future<ShopModel?> Function(String) onRequestAddShopName,
    required Future<CategoryModel?> Function(String) onRequestAddCategoryName,
    required Future<TagModel?> Function(String) onRequestAddTagName,
    required Function() navigateOnSubmit,
    required LogModel initialValue,
  }):
    _onSubmit = onSubmit,
    _shopEntries = shopEntries,
    _categoryEntries = categoryEntries,
    _tagEntries = tagEntries,
    _onRequestAddShopName = onRequestAddShopName,
    _onRequestAddCategoryName = onRequestAddCategoryName,
    _onRequestAddTagName = onRequestAddTagName,
    _navigateOnSubmit = navigateOnSubmit,
    _initialValue = initialValue;

  final Future<bool> Function(LogModel) _onSubmit;
  final Function() _navigateOnSubmit;

  final ValueListenable<List<ShopModel>> _shopEntries;
  final ValueListenable<List<CategoryModel>> _categoryEntries;
  final ValueListenable<List<TagModel>> _tagEntries;

  final Future<ShopModel?> Function(String) _onRequestAddShopName;
  final Future<CategoryModel?> Function(String) _onRequestAddCategoryName;
  final Future<TagModel?> Function(String) _onRequestAddTagName;

  final LogModel _initialValue;

  @override
  ExpenseLogFormState createState() {
    return ExpenseLogFormState();
  }
}

class ExpenseLogFormState extends State<ExpenseLogForm> {
  static const _amountLength = 8;
  static const _tagCount = 8;
  static const _contentCount = 4;
  static const _contentTitleLength = 30;
  static const _contentDescriptionLength = 200;

  final _formKey = GlobalKey<FormState>();

  late String _validationUsedAtEmpty;
  late String _validationAmountEmpty;
  late String _validationAmountNotNumber;
  late String _validationAmountOutOfBounds;
  late String _validationShopEmpty;
  late String _validationCategoryEmpty;
  late String _validationContentTitleEmpty;
  late String _validationContentTitleOutOfBounds;
  late String _validationContentDescriptionOutOfBounds;

  final TextEditingController _shopEditingController = TextEditingController();
  final TextEditingController _categoryEditingController = TextEditingController();
  final TextEditingController _tagEditingController = TextEditingController();

  String _usedAt = '';
  int _amount = 0;
  ShopModel? _shop;
  CategoryModel? _category;

  final ValueNotifier<List<TagModel>> _tags = ValueNotifier([]);
  final ValueNotifier<List<ContentModel>> _contents = ValueNotifier([]);

  @override
  void initState() {
    super.initState();

    final dateFormat = DateFormat('yyyy-MM-dd');
    String initialUsedAt = widget._initialValue.usedAt;
    _usedAt = dateFormat.tryParse(initialUsedAt) != null ? initialUsedAt : dateFormat.format(DateTime.now());
    _amount = widget._initialValue.amount;

    _shop = widget._initialValue.shop;
    _category = widget._initialValue.category;
    _tags.value = widget._initialValue.tags.nonNulls.toList();
    _contents.value = widget._initialValue.contents.toList();
  }

  @override
  void dispose() {
    _shopEditingController.dispose();
    _categoryEditingController.dispose();
    _tagEditingController.dispose();

    _tags.dispose();
    _contents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _validationUsedAtEmpty = L10n.of(context)!.inputValidationUsedAtEmpty;
    _validationAmountEmpty = L10n.of(context)!.inputValidationAmountEmpty;
    _validationAmountNotNumber = L10n.of(context)!.inputValidationAmountNotNumber;
    _validationAmountOutOfBounds = L10n.of(context)!.inputValidationAmountOutOfBounds(pow(10,_amountLength)-1, 1);
    _validationShopEmpty = L10n.of(context)!.inputValidationShopEmpty;
    _validationCategoryEmpty = L10n.of(context)!.inputValidationCategoryEmpty;
    _validationContentTitleEmpty = L10n.of(context)!.inputValidationContentTitleEmpty;
    _validationContentTitleOutOfBounds = L10n.of(context)!.inputValidationContentTitleOutOfBounds(_contentTitleLength);
    _validationContentDescriptionOutOfBounds = L10n.of(context)!.inputValidationContentDescriptionOutOfBounds(_contentDescriptionLength);

    _shopEditingController.text = _shop?.name ?? '';
    _categoryEditingController.text = _category?.name ?? '';
    _tagEditingController.text = '';

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 日付
            _Header(title: L10n.of(context)!.newLogUsedAt,),
            DateSelectorForm(
              initialValue: _usedAt,
              onSaved: _onSavedUsedAt,
              validator: _validationUsedAt,
            ),

            const SizedBox(height: 24.0),

            // 購入金額
            _Header(title: L10n.of(context)!.newLogAmount,),
            PriceForm(
              initialValue: _amount,
              maxLength: _amountLength,
              validator: _validationAmount,
              onSaved: _onSavedAmount,
            ),

            const SizedBox(height: 24.0),

            // 購入先
            _Header(title: L10n.of(context)!.newLogShop,),
            ExtendableSelectorForm(
              entries: widget._shopEntries, 
              controller: _shopEditingController, 
              display: (model) => model.name, 
              validator: _validationShop,
              onRequestAdd: widget._onRequestAddShopName, 
              onSaved: _onSavedShop
            ),

            const SizedBox(height: 24.0),

            // 購入カテゴリー
            _Header(title: L10n.of(context)!.newLogCategory,),
            ExtendableSelectorForm(
              entries: widget._categoryEntries, 
              controller: _categoryEditingController, 
              display: (model) => model.name, 
              validator: _validationCategory,
              onRequestAdd: widget._onRequestAddCategoryName, 
              onSaved: _onSavedCategory
            ),

            const SizedBox(height: 24.0),

            // タグ
            _Header(title: L10n.of(context)!.newLogTag),
            ExtendableSelectorForm(
              entries: widget._tagEntries,
              controller: _tagEditingController,
              display: (model) => model.name,
              inputLength: 16,
              validator: _validationTag,
              onRequestAdd: widget._onRequestAddTagName,
              onSaved: _onSavedTag,
              onSelected: (model) {
                if (model != null) {
                  if (_tags.value.length >= _tagCount) {
                    // タグ上限
                    mainFrameViewModel.showSnackBar(
                      SnackBarModel.alert(L10n.of(context)!.inputMaxTagCount(_tagCount)),
                    );
                  } else if(_tags.value.any((tag) => tag.name == model.name)) {
                    // 重複
                    mainFrameViewModel.showSnackBar(
                      SnackBarModel.alert(L10n.of(context)!.inputTagDuplicate),
                    );
                  } else {
                    _tags.value = [..._tags.value, model];
                  }
                }
                _tagEditingController.clear();
              },
            ),

            SizedBox(height: 4.0,),

            ValueListenableBuilder(
              valueListenable: _tags, 
              builder: (_, tags, _) => Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: tags.map(
                  (tag) => _tagElement(context, tag),
                ).toList(),
              )
            ),

            const SizedBox(height: 24.0),

            // 詳細
            _Header(title: L10n.of(context)!.newLogContent),

            for (int i = 0; i < _contentCount; ++i)
              () {
                int index = i;
                return ValueListenableBuilder(
                  valueListenable: _contents,
                  builder: (_, contents, _) => Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: index < _contents.value.length ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Row(
                          children: [
                            Text(L10n.of(context)!.newLogContentIndex(i+1)),
                            SizedBox(width: 48.0,),

                            // 削除ボタン
                            IconButton(
                              onPressed: () => _contents.value = [..._contents.value..removeAt(index)],
                              icon: Icon(Icons.remove),
                              iconSize: 16.0,
                              constraints: BoxConstraints.tight(Size(32.0, 32.0)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.fromLTRB(8.0, 4.0, 8.0, 4.0),
                          child: CommentForm(
                            initialTitle: contents[i].title,
                            titleLength: _contentTitleLength,
                            titleValidator: _validationContentTitle,
                            titleSaved: (value) => _onSavedContentTitle(index, value),
                            initialDescription: contents[i].description,
                            descriptionLength: _contentDescriptionLength,
                            descriptionValidator: _validationContentDescription,
                            descriptionSaved: (value) => _onSavedContentDescription(index, value),
                          ),
                        ),
                      ],
                    ) : null,
                  ),
                );
              }(),

              SizedBox(height: 8.0),

              // 追加ボタン
              ValueListenableBuilder(
                valueListenable: _contents, 
                builder: (_, contents, _) => Row(
                  children: [
                    IconButton(
                      onPressed: contents.length < _contentCount ? () {
                        _contents.value = [..._contents.value,ContentModel(title: '', description: '')];
                      } : null,
                      icon: Icon(Icons.add),
                      iconSize: 16.0,
                      constraints: BoxConstraints.tight(Size(32.0, 32.0)),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 48.0),

            // 追加ボタン
            _submitButton(context),

            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  Widget _tagElement(BuildContext context, TagModel tag) {
    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(
            side: BorderSide(),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(8.0, 2.0, 8.0, 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tag.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            IconButton(
              onPressed: () {
                _tags.value = [..._tags.value]..remove(tag);
              },
              icon: Icon(Icons.close),
              iconSize: 16.0,
              constraints: BoxConstraints.tight(Size(32.0, 32.0)),
            )
          ], 
        )
      )
    );
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // バリデーション成功
            _formKey.currentState!.save();

            bool result = await widget._onSubmit(
              LogModel(
                amount: _amount,
                usedAt: _usedAt.replaceAll('-', ''),
                category: _category,
                shop: _shop,
                tags: _tags.value,
                contents: _contents.value,
              )
            );

            if (result) {
              // 保存成功
              mainFrameViewModel.showSnackBar(
                SnackBarModel.confirm(L10n.of(context)!.newLogCompleted),
              );
            } else {
              // 保存失敗
              mainFrameViewModel.showSnackBar(
                SnackBarModel.alert(L10n.of(context)!.commonUnknownError),
              );
            }

            widget._navigateOnSubmit();
          } else {
            // バリデーション失敗
            mainFrameViewModel.showSnackBar(
              SnackBarModel.alert(L10n.of(context)!.inputValidationExistsError),
            );
          }
        },
        child: Text(
          L10n.of(context)!.newLogAdd,
        )
      )
    );
  }

  /// 日付バリデーション
  /// 
  /// * 空白禁止: おそらく起きないが念のため。
  String? _validationUsedAt(String? value) {
    if (value == null || value.isEmpty) {
      return _validationUsedAtEmpty;
    }
    return null;
  }

  /// 金額バリデーション
  /// 
  /// * 空白禁止。
  /// 
  /// * 数字パース可能性: フォーム側でブロックされるが念のため。
  /// 
  /// * 範囲制限。
  String? _validationAmount(String? value) {
    if (value == null || value.isEmpty) {
      return _validationAmountEmpty;
    }

    final int? amount = int.tryParse(value);
    if (amount == null) {
      return _validationAmountNotNumber;
    }

    if (amount <= 0 || pow(10, _amountLength) <= amount) {
      return _validationAmountOutOfBounds;
    }

    return null;
  }

  /// 購入先バリデーション
  /// 
  /// * 空白禁止。
  String? _validationShop(ShopModel? value) {
    if (value == null) {
      return _validationShopEmpty;
    }
    return null;
  }

  /// カテゴリーのバリデーション
  /// 
  /// * 空白禁止。
  String? _validationCategory(CategoryModel? value) {
    if (value == null) {
      return _validationCategoryEmpty;
    }
    return null;
  }

  /// タグのバリデーション
  /// 
  /// 設定なし
  String? _validationTag(TagModel? value) {
    return null;
  }

  /// 詳細タイトルのバリデーション
  /// 
  /// * 空白禁止。
  /// 
  /// * 文字数超過:基本的にフォーム側でブロックしてくれるが念のため。
  String? _validationContentTitle(String? value) {
    if (value == null || value.isEmpty) {
      return _validationContentTitleEmpty;
    }

    if (value.length > _contentTitleLength) {
      return _validationContentTitleOutOfBounds;
    }
    return null;
  }

  /// 詳細説明のバリデーション
  /// 
  /// * 文字数超過:基本的にフォーム側でブロックしてくれるが念のため。
  String? _validationContentDescription(String? value) {
    if (value != null) {
      if (value.length > _contentDescriptionLength) {
        return _validationContentDescriptionOutOfBounds;
      }
    }
    return null;
  }

  void _onSavedUsedAt(String? value) {
    _usedAt = value ?? '';
  }

  void _onSavedAmount(String? value) {
    _amount = int.tryParse(value ?? '') ?? 0;
  }

  void _onSavedShop(ShopModel? model) {
    _shop = model;
  }

  void _onSavedCategory(CategoryModel? model) {
    _category = model;
  }

  void _onSavedTag(TagModel? model) {
    // 処理不要
  }

  void _onSavedContentTitle(int index, String? value) {
    _contents.value[index] = ContentModel(
      title: value ?? '',
      description: _contents.value[index].description,
    );
  }

  void _onSavedContentDescription(int index, String? value) {
    _contents.value[index] = ContentModel(
      title: _contents.value[index].title,
      description: value ?? '',
    );
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
        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}