import 'package:budgeting_app/ui/core/widget/preview_wrapper.dart';
import 'package:budgeting_app/ui/core/widget/price_edit_field.dart';
import 'package:budgeting_app/ui/core/widget/text_editing_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// 金額の範囲を入力するWidget
class HistoryFilterAmountRange extends StatelessWidget {
  const HistoryFilterAmountRange({
    super.key,
    required TextEditingController minFieldController,
    required TextEditingController maxFieldController,
    required bool active,
    required Function(int, int) rangeChanged
  }): 
    _minFieldController = minFieldController,
    _maxFieldController = maxFieldController,
    _active = active,
    _rangeChanged = rangeChanged;

  static const int _maxLength = 8;

  final TextEditingController _minFieldController;
  final TextEditingController _maxFieldController;
  final bool _active;
  final Function(int, int) _rangeChanged;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _active ? 1.0 : 0.5,
      child: AbsorbPointer(
        absorbing: !_active,
        child: Row(
          children: [
            Expanded(
              child: PriceEditField(
                controller: _minFieldController, 
                maxLength: _maxLength,
                onSubmitted: (text) {
                  final int? min = int.tryParse(text);
                  final int max = int.tryParse(_maxFieldController.text) ?? 99999999;

                  if (min != null) {
                    _rangeChanged(min, max);
                  }
                }
              )
            ),
            SizedBox(
              width: 50.0,
              child: Text(
                '–',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: PriceEditField(
                controller: _maxFieldController, 
                maxLength: _maxLength,
                onSubmitted: (text) {
                  final int min = int.tryParse(_maxFieldController.text) ?? 0;
                  final int? max = int.tryParse(text);

                  if (max != null) {
                    _rangeChanged(min, max);
                  }
                }

              ),
            ),
          ],
        ),
      )
    );
  }
}

@Preview(
  name: 'Amount Range Active',
  wrapper: previewWrapper,
)
Widget previewAmountRangeActive() {
  return TextEditingControllerProvider(
    builder: (context, controllers) => HistoryFilterAmountRange(
      minFieldController: controllers[0], 
      maxFieldController: controllers[1],
      active: true,
      rangeChanged: (_, _) {},
    ),
    controllerCount: 2,
  );
}

@Preview(
  name: 'Amount Range Inactive',
  wrapper: previewWrapper,
)
Widget previewAmountRangeInactive() {
  return TextEditingControllerProvider(
    builder: (context, controllers) => HistoryFilterAmountRange(
      minFieldController: controllers[0], 
      maxFieldController: controllers[1],
      active: false,
      rangeChanged: (_, _) {},
    ),
    controllerCount: 2,
  );
}