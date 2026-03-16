import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/widget/budgeting_app_bottom_navigation.dart';
import 'package:budgeting_app/ui/settings/widgets/settings_top/settings_top_element.dart';
import 'package:flutter/material.dart';

class SettingsTop extends StatelessWidget {
  const SettingsTop({
    super.key,
    required Function(BuildContext) navigateToSettingsAttributes,
  }): _navigateToSettingsAttributes = navigateToSettingsAttributes;

  final Function(BuildContext) _navigateToSettingsAttributes;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
        child: Column(
          spacing: 12.0,
          children: [
            SettingsTopListElement(
              label: L10n.of(context)!.settingsAttributes,
              onClick: () => _navigateToSettingsAttributes(context),
            ),
          ],
        ),
      ),
    );
  }
}
