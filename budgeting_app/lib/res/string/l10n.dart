import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'string/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ja')];

  /// No description provided for @applicationTitle.
  ///
  /// In ja, this message translates to:
  /// **'家計簿アプリ'**
  String get applicationTitle;

  /// No description provided for @dashboardTopWeekNo.
  ///
  /// In ja, this message translates to:
  /// **'第{number}週'**
  String dashboardTopWeekNo(Object number);

  /// No description provided for @dashboardTopAmountSum.
  ///
  /// In ja, this message translates to:
  /// **'消費総額'**
  String get dashboardTopAmountSum;

  /// No description provided for @dashboardTopWeeklyLogCount.
  ///
  /// In ja, this message translates to:
  /// **'{number}件'**
  String dashboardTopWeeklyLogCount(Object number);

  /// No description provided for @dashboardTopMonthlyLogCount.
  ///
  /// In ja, this message translates to:
  /// **'{number}件の合計'**
  String dashboardTopMonthlyLogCount(Object number);

  /// No description provided for @expenseHistory.
  ///
  /// In ja, this message translates to:
  /// **'消費履歴'**
  String get expenseHistory;

  /// No description provided for @expenseHistoryListFilter.
  ///
  /// In ja, this message translates to:
  /// **'検索条件'**
  String get expenseHistoryListFilter;

  /// No description provided for @expenseHistoryListFilterAmount.
  ///
  /// In ja, this message translates to:
  /// **'金額'**
  String get expenseHistoryListFilterAmount;

  /// No description provided for @expenseHistoryListFilterUsedAt.
  ///
  /// In ja, this message translates to:
  /// **'期間'**
  String get expenseHistoryListFilterUsedAt;

  /// No description provided for @expenseHistoryListFilterShop.
  ///
  /// In ja, this message translates to:
  /// **'購入先'**
  String get expenseHistoryListFilterShop;

  /// No description provided for @expenseHistoryListFilterCategory.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリー'**
  String get expenseHistoryListFilterCategory;

  /// No description provided for @expenseHistoryListFilterTag.
  ///
  /// In ja, this message translates to:
  /// **'以下のいずれかのタグを含む'**
  String get expenseHistoryListFilterTag;

  /// No description provided for @expenseHistoryDetail.
  ///
  /// In ja, this message translates to:
  /// **'消費の詳細'**
  String get expenseHistoryDetail;

  /// No description provided for @expenseHistoryDetailFailed.
  ///
  /// In ja, this message translates to:
  /// **'履歴の情報が取得できませんでした'**
  String get expenseHistoryDetailFailed;

  /// No description provided for @expenseHisotryDetailDateTimeFormat.
  ///
  /// In ja, this message translates to:
  /// **'yyyy/MM/dd (E)'**
  String get expenseHisotryDetailDateTimeFormat;

  /// No description provided for @expenseHistoryDetailAmount.
  ///
  /// In ja, this message translates to:
  /// **'消費金額'**
  String get expenseHistoryDetailAmount;

  /// No description provided for @expenseHistoryDetailShop.
  ///
  /// In ja, this message translates to:
  /// **'購入先'**
  String get expenseHistoryDetailShop;

  /// No description provided for @expenseHistoryDetailCategory.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリー'**
  String get expenseHistoryDetailCategory;

  /// No description provided for @expenseHistoryDetailTag.
  ///
  /// In ja, this message translates to:
  /// **'設定されているタグ'**
  String get expenseHistoryDetailTag;

  /// No description provided for @expenseHistoryDetailTagEmpty.
  ///
  /// In ja, this message translates to:
  /// **'タグが設定されていません'**
  String get expenseHistoryDetailTagEmpty;

  /// No description provided for @expenseHistoryDetailContent.
  ///
  /// In ja, this message translates to:
  /// **'詳細情報'**
  String get expenseHistoryDetailContent;

  /// No description provided for @expenseHistoryDetailContentEmpty.
  ///
  /// In ja, this message translates to:
  /// **'詳細の情報は設定されていません'**
  String get expenseHistoryDetailContentEmpty;

  /// No description provided for @expenseHistoryEdit.
  ///
  /// In ja, this message translates to:
  /// **'購入情報編集'**
  String get expenseHistoryEdit;

  /// No description provided for @expenseHistoryEditUpdate.
  ///
  /// In ja, this message translates to:
  /// **'購入情報を更新'**
  String get expenseHistoryEditUpdate;

  /// No description provided for @expenseHistoryFilter.
  ///
  /// In ja, this message translates to:
  /// **'履歴の検索条件'**
  String get expenseHistoryFilter;

  /// No description provided for @expenseHistoryFilterAmount.
  ///
  /// In ja, this message translates to:
  /// **'金額の範囲'**
  String get expenseHistoryFilterAmount;

  /// No description provided for @expenseHistoryFilterUsedAt.
  ///
  /// In ja, this message translates to:
  /// **'期間'**
  String get expenseHistoryFilterUsedAt;

  /// No description provided for @expenseHistoryFilterCategory.
  ///
  /// In ja, this message translates to:
  /// **'表示するカテゴリー'**
  String get expenseHistoryFilterCategory;

  /// No description provided for @expenseHistoryFilterShop.
  ///
  /// In ja, this message translates to:
  /// **'表示する購入先'**
  String get expenseHistoryFilterShop;

  /// No description provided for @expenseHistoryFilterTag.
  ///
  /// In ja, this message translates to:
  /// **'表示するタグ'**
  String get expenseHistoryFilterTag;

  /// No description provided for @expenseHistoryFilterApply.
  ///
  /// In ja, this message translates to:
  /// **'指定した内容で検索'**
  String get expenseHistoryFilterApply;

  /// No description provided for @expenseHistoryFilterActive.
  ///
  /// In ja, this message translates to:
  /// **'条件に含める'**
  String get expenseHistoryFilterActive;

  /// No description provided for @newLog.
  ///
  /// In ja, this message translates to:
  /// **'購入情報の追加'**
  String get newLog;

  /// No description provided for @newLogUsedAt.
  ///
  /// In ja, this message translates to:
  /// **'購入日'**
  String get newLogUsedAt;

  /// No description provided for @newLogAmount.
  ///
  /// In ja, this message translates to:
  /// **'購入金額'**
  String get newLogAmount;

  /// No description provided for @newLogAmountHint.
  ///
  /// In ja, this message translates to:
  /// **'金額を入力...'**
  String get newLogAmountHint;

  /// No description provided for @newLogShop.
  ///
  /// In ja, this message translates to:
  /// **'購入先'**
  String get newLogShop;

  /// No description provided for @newLogCategory.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリー'**
  String get newLogCategory;

  /// No description provided for @newLogTag.
  ///
  /// In ja, this message translates to:
  /// **'タグ'**
  String get newLogTag;

  /// No description provided for @newLogContent.
  ///
  /// In ja, this message translates to:
  /// **'購入詳細'**
  String get newLogContent;

  /// No description provided for @newLogContentIndex.
  ///
  /// In ja, this message translates to:
  /// **'No.{index}'**
  String newLogContentIndex(Object index);

  /// No description provided for @newLogContentTitle.
  ///
  /// In ja, this message translates to:
  /// **'タイトル'**
  String get newLogContentTitle;

  /// No description provided for @newLogContentDescription.
  ///
  /// In ja, this message translates to:
  /// **'概要'**
  String get newLogContentDescription;

  /// No description provided for @newLogAdd.
  ///
  /// In ja, this message translates to:
  /// **'新規追加'**
  String get newLogAdd;

  /// No description provided for @newLogErrorEmptyShop.
  ///
  /// In ja, this message translates to:
  /// **'購入先が未設定'**
  String get newLogErrorEmptyShop;

  /// No description provided for @newLogErrorEmptyCategory.
  ///
  /// In ja, this message translates to:
  /// **'購入カテゴリーが未設定'**
  String get newLogErrorEmptyCategory;

  /// No description provided for @settingsTop.
  ///
  /// In ja, this message translates to:
  /// **'設定'**
  String get settingsTop;

  /// No description provided for @settingsAttributes.
  ///
  /// In ja, this message translates to:
  /// **'履歴の項目を編集'**
  String get settingsAttributes;

  /// No description provided for @settingsAttributesCategory.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリー一覧'**
  String get settingsAttributesCategory;

  /// No description provided for @settingsAttributesEditCategory.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリーの編集'**
  String get settingsAttributesEditCategory;

  /// No description provided for @settingsAttributesAddCategory.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリーの追加'**
  String get settingsAttributesAddCategory;

  /// No description provided for @settingsAttributesEditCategoryDescription.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリーを入力'**
  String get settingsAttributesEditCategoryDescription;

  /// No description provided for @settingsAttributesDeleteCategory.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリー \"{name}\" を削除しますか？'**
  String settingsAttributesDeleteCategory(Object name);

  /// No description provided for @settingsAttributesShop.
  ///
  /// In ja, this message translates to:
  /// **'購入先一覧'**
  String get settingsAttributesShop;

  /// No description provided for @settingsAttributesEditShop.
  ///
  /// In ja, this message translates to:
  /// **'購入先の編集'**
  String get settingsAttributesEditShop;

  /// No description provided for @settingsAttributesAddShop.
  ///
  /// In ja, this message translates to:
  /// **'購入先の追加'**
  String get settingsAttributesAddShop;

  /// No description provided for @settingsAttributesEditShopDescription.
  ///
  /// In ja, this message translates to:
  /// **'購入先を入力'**
  String get settingsAttributesEditShopDescription;

  /// No description provided for @settingsAttributesDeleteShop.
  ///
  /// In ja, this message translates to:
  /// **'購入先 \"{name}\" を削除しますか？'**
  String settingsAttributesDeleteShop(Object name);

  /// No description provided for @settingsAttributesTag.
  ///
  /// In ja, this message translates to:
  /// **'タグ一覧'**
  String get settingsAttributesTag;

  /// No description provided for @settingsAttributesEditTag.
  ///
  /// In ja, this message translates to:
  /// **'タグの編集'**
  String get settingsAttributesEditTag;

  /// No description provided for @settingsAttributesAddTag.
  ///
  /// In ja, this message translates to:
  /// **'タグの追加'**
  String get settingsAttributesAddTag;

  /// No description provided for @settingsAttributesEditTagDescription.
  ///
  /// In ja, this message translates to:
  /// **'タグを入力'**
  String get settingsAttributesEditTagDescription;

  /// No description provided for @settingsAttributesDeleteTag.
  ///
  /// In ja, this message translates to:
  /// **'タグ \"{name}\" を削除しますか？'**
  String settingsAttributesDeleteTag(Object name);

  /// No description provided for @commonAbbrSunDay.
  ///
  /// In ja, this message translates to:
  /// **'日'**
  String get commonAbbrSunDay;

  /// No description provided for @commonAbbrMonDay.
  ///
  /// In ja, this message translates to:
  /// **'月'**
  String get commonAbbrMonDay;

  /// No description provided for @commonAbbrTuesDay.
  ///
  /// In ja, this message translates to:
  /// **'火'**
  String get commonAbbrTuesDay;

  /// No description provided for @commonAbbrWednesDay.
  ///
  /// In ja, this message translates to:
  /// **'水'**
  String get commonAbbrWednesDay;

  /// No description provided for @commonAbbrThursDay.
  ///
  /// In ja, this message translates to:
  /// **'木'**
  String get commonAbbrThursDay;

  /// No description provided for @commonAbbrFriDay.
  ///
  /// In ja, this message translates to:
  /// **'金'**
  String get commonAbbrFriDay;

  /// No description provided for @commonAbbrSaturDay.
  ///
  /// In ja, this message translates to:
  /// **'土'**
  String get commonAbbrSaturDay;

  /// No description provided for @commonPrice.
  ///
  /// In ja, this message translates to:
  /// **'{price}円'**
  String commonPrice(Object price);

  /// No description provided for @commonPriceSuffix.
  ///
  /// In ja, this message translates to:
  /// **'円'**
  String get commonPriceSuffix;

  /// No description provided for @commonOk.
  ///
  /// In ja, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonCancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get commonCancel;

  /// No description provided for @commonAbbrDateFormat.
  ///
  /// In ja, this message translates to:
  /// **'yyyy/MM/dd(E)'**
  String get commonAbbrDateFormat;

  /// No description provided for @commonFullDateFormat.
  ///
  /// In ja, this message translates to:
  /// **'yyyy年 MM月 dd日 (E)'**
  String get commonFullDateFormat;

  /// No description provided for @commonMonthDate.
  ///
  /// In ja, this message translates to:
  /// **'{month}/{date}'**
  String commonMonthDate(Object date, Object month);

  /// No description provided for @commonYearMonthDate.
  ///
  /// In ja, this message translates to:
  /// **'{year}/{month}/{date}'**
  String commonYearMonthDate(Object date, Object month, Object year);

  /// No description provided for @commonEmpty.
  ///
  /// In ja, this message translates to:
  /// **'未設定'**
  String get commonEmpty;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ja':
      return L10nJa();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
