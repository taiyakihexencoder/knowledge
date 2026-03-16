import 'package:flutter/material.dart';

final ProjectNavigator navigator = ProjectNavigator();

class ProjectNavigator {
  ProjectNavigator(): 
    _navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _navigatorKey;
  /// MaterialAppでnavigatorKeyにセットする
  GlobalKey<NavigatorState> get key => _navigatorKey;

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
  void pop() {
    _navigatorKey.currentState!.pop();
  }

  /// AppBarの戻るボタン
  Widget? leading() {
    return _navigatorKey.currentState?.canPop() == true
      ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => pop()
      ) : null;
  }
}