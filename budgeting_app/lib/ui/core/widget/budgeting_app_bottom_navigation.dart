import 'package:budgeting_app/ui/core/widget/project_navigator.dart';
import 'package:flutter/material.dart';

// アイコンの順番情報
const int _bottomNavigationIndexDashboard = 0;
const int _bottomNavigationIndexHistoryList = 1;
const int _bottomNavigationIndexSettings = 2;

// アイコンに設定するラベル
const String _bottomNavigationLabelDashboard = "Dashboard";
const String _bottomNavigationLabelHistoryList = "History";
const String _bottomNavigationLabelSettings = "Settings";

late BudgetingAppBottomNavigation bottomNavigationBar;

/// 共通のボトムナビゲーションバー。
/// 
/// 遷移履歴をクリアして移動する。
/// 
/// 0: ダッシュボード
/// 
/// 1: 履歴リスト
/// 
/// 2: 設定
class BudgetingAppBottomNavigation extends StatelessWidget {

  const BudgetingAppBottomNavigation({
    super.key,
    required Function(BuildContext) navigateToDashboard,
    required Function(BuildContext) navigateToHitoryList,
    required Function(BuildContext) navigateToSettings
  }) : 
  _navigateToDashboard = navigateToDashboard,
  _navigateToHitoryList = navigateToHitoryList,
  _navigateToSettings = navigateToSettings;

  final Function(BuildContext) _navigateToDashboard;
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
            Icons.dashboard,
          ),
          label: _bottomNavigationLabelDashboard,
        ),
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

  Future? _onTapIcon(BuildContext context, int index) {
    switch(index) {
      case _bottomNavigationIndexDashboard:
        return navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => _navigateToDashboard(context),
          ), 
          (_) => false,
        );
      case _bottomNavigationIndexHistoryList:
        return navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => _navigateToHitoryList(context),
          ),
          (_) => false,
        );
      case _bottomNavigationIndexSettings:
        return navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => _navigateToSettings(context),
          ),
          (_) => false,
        );
      default:
        return null;
    }
  }
}
