import 'package:flutter/material.dart';

// アイコンの順番情報
const int _bottomNavigationIndexHistoryList = 0;
const int _bottomNavigationIndexSettings = 1;

// アイコンに設定するラベル
const String _bottomNavigationLabelHistoryList = "History";
const String _bottomNavigationLabelSettings = "Settings";

enum BottomNavigationIcon {
  historyList(label: "History"),
  settings(label: "Settings");

  const BottomNavigationIcon({
    required this.label,
  });

  final String label;
}

late BudgetingAppBottomNavigation bottomNavigationBar;

/// 共通のボトムナビゲーションバー。
/// 
/// 遷移履歴をクリアして移動する。
/// 
/// 0: 履歴リスト
/// 
/// 1: 設定
class BudgetingAppBottomNavigation extends StatelessWidget {

  const BudgetingAppBottomNavigation({
    super.key,
    required Function(BuildContext) navigateToHitoryList,
    required Function(BuildContext) navigateToSettings
  }) : 
  _navigateToHitoryList = navigateToHitoryList,
  _navigateToSettings = navigateToSettings;

  final Function(BuildContext) _navigateToHitoryList;
  final Function(BuildContext) _navigateToSettings;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        _onTapIcon(context, index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
          ),
          label: _bottomNavigationLabelHistoryList,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: _bottomNavigationLabelSettings,
        )
      ]
    );
  }

  void _onTapIcon(BuildContext context, int index) {
    switch(index) {
      case _bottomNavigationIndexHistoryList:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => _navigateToHitoryList(context),
          ),
          (_) => false,
        );
        break;
      case _bottomNavigationIndexSettings:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => _navigateToSettings(context),
          ),
          (_) => false,
        );
        break;
    }
  }
}
