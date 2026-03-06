import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/comment_field.dart';
import 'package:budgeting_app/ui/core/widget/date_selector_field.dart';
import 'package:budgeting_app/ui/core/widget/extendable_selector_field.dart';
import 'package:budgeting_app/ui/core/widget/price_edit_field.dart';
import 'package:budgeting_app/ui/new_log/models/content_model.dart';
import 'package:budgeting_app/ui/new_log/models/log_model.dart';
import 'package:budgeting_app/ui/new_log/models/tag_model.dart';
import 'package:budgeting_app/ui/new_log/view_models/new_log_view_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class NewLog extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  NewLog({
    super.key,
    required NewLogViewModel viewModel,
    required Function(BuildContext) navigateOnSubmit,
  }): 
    _viewModel = viewModel,
    _navigateOnSubmit = navigateOnSubmit;

  final NewLogViewModel _viewModel;
  final Function(BuildContext) _navigateOnSubmit;

  @override
  NewLogState createState() {
    return NewLogState();
  }
}

class NewLogState extends State<NewLog> {
  static const _tagCount = 8;
  static const _contentCount = 4;

  final TextEditingController _usedAtEditingController = TextEditingController();
  final TextEditingController _amountEditingController = TextEditingController();
  final TextEditingController _shopEditingController = TextEditingController();
  final TextEditingController _categoryEditingController = TextEditingController();
  final List<TextEditingController> _tagEditingControllers = List.generate(_tagCount, (_) => TextEditingController());
  final List<TextEditingController> _contentTitleEditingControllers = List.generate(_contentCount, (_) => TextEditingController());
  final List<TextEditingController> _contentDescriptionEditingControllers = List.generate(_contentCount, (_) => TextEditingController());

  @override
  void dispose() {
    _usedAtEditingController.dispose();
    _amountEditingController.dispose();
    _shopEditingController.dispose();
    _categoryEditingController.dispose();
    for (TextEditingController controller in _tagEditingControllers) {
      controller.dispose();
    }
    for (TextEditingController controller in _contentTitleEditingControllers) {
      controller.dispose();
    }
    for (TextEditingController controller in _contentDescriptionEditingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget._viewModel.refreshCategoryList();
    widget._viewModel.refreshTagList();
    widget._viewModel.refreshShopList();

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.newLog),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),

              // 日付
              Row(
                children: [
                  _Header(title: L10n.of(context)!.newLogUsedAt,),
                  SizedBox(width:60.0),
                  DateSelectorField(
                    controller: _usedAtEditingController,
                  ),
                ],
              ),

              // 購入金額
              Row(
                children: [
                  _Header(title: L10n.of(context)!.newLogAmount,),
                  Spacer(),
                  SizedBox(
                    width: 200.0,
                    child: PriceEditField(
                      controller: _amountEditingController,
                      maxLength: 8,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),

              // 購入先
              Row(
                children: [
                  _Header(title: L10n.of(context)!.newLogShop,),
                  Spacer(),
                  SizedBox(
                    width: 200.0,
                    child: ExtendableSelectorField(
                      entries: widget._viewModel.shopSelections,
                      controller: _shopEditingController,
                      display: (model) => model.name,
                      onRequestAdd: widget._viewModel.onRequestAddShopName,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24.0),

              // 購入カテゴリー
              Row(
                children: [
                  _Header(title: L10n.of(context)!.newLogCategory,),
                  Spacer(),
                  SizedBox(
                    width:200.0,
                    child: ExtendableSelectorField(
                      entries: widget._viewModel.categorySelections, 
                      controller: _categoryEditingController,
                      display: (model) => model.name, 
                      onRequestAdd: widget._viewModel.onRequestAddCategoryName,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),

              // タグ
              _Header(title: L10n.of(context)!.newLogTag),
              for (int i = 0; i < _tagCount; ++i)
                ...[
                  ExtendableSelectorField(
                    entries: widget._viewModel.tagSelections,
                    controller: _tagEditingControllers[i],
                    display: (model) => model.name,
                    onRequestAdd: widget._viewModel.onRequestAddTagName,
                  ),
                  const SizedBox(height: 8.0),
                ],
              
              const SizedBox(height: 24.0),

              // 詳細
              _Header(title: L10n.of(context)!.newLogContent),
              for (int i = 0; i < _contentCount; ++i)
                ...[
                  _SubHeader(title: L10n.of(context)!.newLogContentIndex(i+1)),

                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(8.0, 12.0, 8.0, 12.0),
                    child: CommentField(
                      titleController: _contentTitleEditingControllers[i], 
                      descriptionContoller: _contentDescriptionEditingControllers[i],
                    ),
                  ),
                ],

              const SizedBox(height: 24.0),

              // 追加ボタン
              _submitButton(context),
              const SizedBox(height: 16.0),           
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          widget._viewModel.onRequestAddLog(_createLogModel());
          widget._navigateOnSubmit(context);
        }, 
        child: Text(
          L10n.of(context)!.newLogAdd,
        ),
      ),
    );
  }

  LogModel _createLogModel() {
    Map<String, TagModel> tagMap = { for (var tag in widget._viewModel.tagSelections.value) tag.name : tag };
    List<ContentModel> contents = [];
    for (int i = 0; i < _contentCount; ++i) {
      contents.add(
        ContentModel(
          title: _contentTitleEditingControllers[i].text, 
          description: _contentDescriptionEditingControllers[i].text
        )
      );
    }

    return LogModel(
      usedAt: _usedAtEditingController.text.replaceAll('-', ''),
      amount: int.tryParse(_amountEditingController.text) ?? 0,
      shop: widget._viewModel.shopSelections.value.firstWhereOrNull(
        (shop) => shop.name == _shopEditingController.text,
      ),
      category: widget._viewModel.categorySelections.value.firstWhereOrNull(
        (category) => category.name == _categoryEditingController.text,
      ),
      tags: _tagEditingControllers.map(
        (controller) => tagMap[controller.text]
      ).toList(),
      contents: contents,
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
