import 'package:budgeting_app/ui/core/models/app_bar_model.dart';
import 'package:budgeting_app/ui/core/models/floating_action_button_model.dart';
import 'package:budgeting_app/ui/core/models/snack_bar_model.dart';
import 'package:flutter/material.dart';

final MainFrameViewModel mainFrameViewModel = MainFrameViewModel();

class MainFrameViewModel {
  MainFrameViewModel():
    _topBar = ValueNotifier(null),
    _navigatorState = ValueNotifier(false),
    _floatingActionButton = ValueNotifier([]),
    _selectedBottomNavigationItem = ValueNotifier(0),
    _snackBarModel = ValueNotifier(null);

  final ValueNotifier<AppBarModel?> _topBar;
  /// トップバーの状態
  ValueNotifier<AppBarModel?> get topBar => _topBar;

  final ValueNotifier<bool> _navigatorState;
  /// ナビゲーションの表示状態
  ValueNotifier<bool> get navigatorState => _navigatorState;

  final ValueNotifier<List<FloatingActionButtonModel>> _floatingActionButton;
  /// FloatingActionButton
  ValueNotifier<List<FloatingActionButtonModel>> get floatingActionButton => _floatingActionButton; 

  final ValueNotifier<int> _selectedBottomNavigationItem;
  /// Bottom Navigationの選択状態
  ValueNotifier<int> get selectedBottomNavigationItem => _selectedBottomNavigationItem;

  final ValueNotifier<SnackBarModel?> _snackBarModel;
  /// スナックバー表示
  ValueNotifier<SnackBarModel?> get snackBarModel => _snackBarModel;

  late EdgeInsets _edgeInsets;
  /// システムバー領域のデフォルトの大きさ
  EdgeInsets get edgeInsets => _edgeInsets;

  void dispose() {
    _topBar.dispose();
    _navigatorState.dispose();
    _floatingActionButton.dispose();
    _selectedBottomNavigationItem.dispose();
    _snackBarModel.dispose();
  }

  void showTopBar({
    String title = "",
    List<AppBarActionModel>? actions,
  }) {
    // build(BuildContext)中にValueNotifierを変更すると例外を生じる。
    // addPostFrameCallbackでbuild()終了を待機する
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _topBar.value = AppBarModel(
          title: title,
          actions: actions,
        );
      }
    );
  }

  void hideTopBar() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _topBar.value = null;
      }
    );
  }

  void showNavigator() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _navigatorState.value = true;
      }
    );
  }

  void hideNavigator() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _navigatorState.value = false;
      }
    );
  }

  void setFloatingActionButton([
    List<FloatingActionButtonModel> buttons = const []
  ]) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _floatingActionButton.value = buttons;
      }
    );
  }

  void selectBottomNavigationItem(int index) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _selectedBottomNavigationItem.value = index;
      }
    );
  }

  void showSnackBar(SnackBarModel model) {
    _snackBarModel.value = model;
  }

  /// アプリケーションの開始時にセーフエリアの大きさ情報を保持する
  /// Scaffold計算時点で上書きされてしまうので、都度metricsから取得してはいけない
  void setEdgeInsets(EdgeInsets insets) {
    _edgeInsets = insets;
  }
}