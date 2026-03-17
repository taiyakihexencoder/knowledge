import 'package:flutter/material.dart';

final ProjectNavigator navigator = ProjectNavigator();

class ProjectNavigator {
  ProjectNavigator(): 
    _navigatorKey = GlobalKey<NavigatorState>(),
    _overridePop = null;

  final GlobalKey<NavigatorState> _navigatorKey;
  /// MaterialAppでnavigatorKeyにセットする
  GlobalKey<NavigatorState> get key => _navigatorKey;

  /// AppBarによるback処理の上書き
  /// 画面を離れる場合に破棄が必要
  Function()? _overridePop;

  /// Navigatorのコンテキスト
  BuildContext get context => _navigatorKey.currentState!.context;

  /// 過去画面を削除して遷移
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Route<T> newRoute,
    bool Function(Route<dynamic>) predicate,
  ) {
    return _navigatorKey.currentState!.pushAndRemoveUntil(newRoute, predicate);
  }

  /// 単純な画面遷移
  Future<T?> push<T extends Object?>(
    Route<T> route,
  ) {
    return _navigatorKey.currentState!.push(route);
  }

  /// back処理
  void pop<T extends Object?>([T? result]) {
    _navigatorKey.currentState!.pop(result);
  }

  /// AppBarの戻るボタン
  Widget? leading() {
    return _navigatorKey.currentState?.canPop() == true
      ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (_overridePop == null) {
            pop();
          } else {
            _overridePop!();
          }
        }
      ) : null;
  }

  /// AppBarによるpop処理を上書きする
  void overrideAppBarPop(Function() popFunction) {
    _overridePop = popFunction;
  }

  /// 上書きしたpop処理を消す
  void disposeOverrideAppBarPop() {
    _overridePop = null;
  }
}