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

  /// No description provided for @expenseHistory.
  ///
  /// In ja, this message translates to:
  /// **'消費履歴'**
  String get expenseHistory;

  /// No description provided for @expenseHistoryDetail.
  ///
  /// In ja, this message translates to:
  /// **'消費の詳細'**
  String get expenseHistoryDetail;

  /// No description provided for @newLog.
  ///
  /// In ja, this message translates to:
  /// **'購入情報の追加'**
  String get newLog;

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
