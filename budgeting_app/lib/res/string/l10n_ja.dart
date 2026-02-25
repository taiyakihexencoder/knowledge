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
  String commonPrice(Object price) {
    return '$price円';
  }

  @override
  String get commonPriceSuffix => '円';
}
