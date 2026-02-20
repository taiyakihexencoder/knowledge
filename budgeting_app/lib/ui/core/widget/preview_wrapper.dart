import 'package:budgeting_app/res/string/l10n.dart';
import 'package:flutter/material.dart';

/// flutter-localizationsをPreview内で使えるようにするために、
/// Preview用の親Widgetのカスタム定義。
Widget previewWrapper(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: L10n.localizationsDelegates,
    supportedLocales: L10n.supportedLocales,
    theme: ThemeData(useMaterial3: true),
    home: Material(
      child: child,
    ),
  );
}