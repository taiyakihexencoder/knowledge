import 'package:budgeting_app/res/string/l10n.dart';
import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:budgeting_app/ui/settings/widgets/settings_top/settings_top_element.dart';
import 'package:flutter/material.dart';

class SettingsTop extends StatelessWidget {
  const SettingsTop({
    super.key,
    required Future Function() navigateToSettingsAttributes,
  }): _navigateToSettingsAttributes = navigateToSettingsAttributes;

  final Future Function() _navigateToSettingsAttributes;

  void _updateScaffold({
    required String title
  }) {
    mainFrameViewModel.showTopBar(title: title);
    mainFrameViewModel.showNavigator();
    mainFrameViewModel.setFloatingActionButton();
  }

  @override
  Widget build(BuildContext context) {
    _updateScaffold(title: L10n.of(context)!.settingsTop);
    return Material(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
        child: Column(
          spacing: 12.0,
          children: [
            SettingsTopListElement(
              label: L10n.of(context)!.settingsAttributes,
              onClick: () async {
                await _navigateToSettingsAttributes();
                // context.mounted: 非同期処理中にcontextがWidgetから外れていないかチェックする
                if (context.mounted) {
                  _updateScaffold(title: L10n.of(context)!.settingsTop);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
