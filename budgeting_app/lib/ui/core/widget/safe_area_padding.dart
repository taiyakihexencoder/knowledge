import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:flutter/material.dart';

class SafeAreaPadding {
  static Widget get top {
    return SizedBox(width: double.infinity, height: mainFrameViewModel.edgeInsets.top);
  }

  static Widget get bottom {
    return SizedBox(width: double.infinity, height: mainFrameViewModel.edgeInsets.bottom);
  }

  static Widget get left {
    return SizedBox(width: mainFrameViewModel.edgeInsets.left);
  }

  static Widget get right {
    return SizedBox(width: mainFrameViewModel.edgeInsets.right);
  }
}