// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get applicationTitle => '家計簿アプリ';

  @override
  String get expenseHistory => '消費履歴';

  @override
  String get expenseHistoryDetail => '消費の詳細';

  @override
  String get expenseHistoryDetailFailed => '履歴の情報が取得できませんでした';

  @override
  String get expenseHisotryDetailDateTimeFormat => 'yyyy/MM/dd (E)';

  @override
  String get expenseHistoryDetailAmount => '消費金額';

  @override
  String get expenseHistoryDetailShop => '購入先';

  @override
  String get expenseHistoryDetailCategory => 'カテゴリー';

  @override
  String get expenseHistoryDetailTag => '設定されているタグ';

  @override
  String get expenseHistoryDetailTagEmpty => 'タグが設定されていません';

  @override
  String get expenseHistoryDetailContent => '詳細情報';

  @override
  String get expenseHistoryDetailContentEmpty => '詳細の情報は設定されていません';

  @override
  String get newLog => '購入情報の追加';

  @override
  String get newLogAmount => '購入金額';

  @override
  String get newLogAmountHint => '金額を入力...';

  @override
  String get newLogShop => '購入先';

  @override
  String get newLogCategory => 'カテゴリー';

  @override
  String get newLogTag => 'タグ';

  @override
  String get newLogContent => '購入詳細';

  @override
  String newLogContentIndex(Object index) {
    return 'No.$index';
  }

  @override
  String get newLogContentTitle => 'タイトル';

  @override
  String get newLogContentDescription => '概要';

  @override
  String get newLogAdd => '新規追加';

  @override
  String get newLogErrorEmptyShop => '購入先が未設定';

  @override
  String get newLogErrorEmptyCategory => '購入カテゴリーが未設定';

  @override
  String get settingsTop => '設定';

  @override
  String get settingsAttributes => '履歴の項目を編集';

  @override
  String get settingsAttributesCategory => 'カテゴリー一覧';

  @override
  String get settingsAttributesEditCategory => 'カテゴリーの編集';

  @override
  String get settingsAttributesAddCategory => 'カテゴリーの追加';

  @override
  String get settingsAttributesEditCategoryDescription => 'カテゴリーを入力';

  @override
  String settingsAttributesDeleteCategory(Object name) {
    return 'カテゴリー \"$name\" を削除しますか？';
  }

  @override
  String get settingsAttributesShop => '購入先一覧';

  @override
  String get settingsAttributesEditShop => '購入先の編集';

  @override
  String get settingsAttributesAddShop => '購入先の追加';

  @override
  String get settingsAttributesEditShopDescription => '購入先を入力';

  @override
  String settingsAttributesDeleteShop(Object name) {
    return '購入先 \"$name\" を削除しますか？';
  }

  @override
  String get settingsAttributesTag => 'タグ一覧';

  @override
  String get settingsAttributesEditTag => 'タグの編集';

  @override
  String get settingsAttributesAddTag => 'タグの追加';

  @override
  String get settingsAttributesEditTagDescription => 'タグを入力';

  @override
  String settingsAttributesDeleteTag(Object name) {
    return 'タグ \"$name\" を削除しますか？';
  }

  @override
  String commonPrice(Object price) {
    return '$price円';
  }

  @override
  String get commonPriceSuffix => '円';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonEmpty => '未設定';
}
