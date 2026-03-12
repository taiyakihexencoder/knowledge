class DashboardTopCalendarDateModel {
  const DashboardTopCalendarDateModel({
    required this.logList,
  });
  
  final List<DashboardTopCalendarDateExpenseModel> logList;
}

class DashboardTopCalendarDateExpenseModel {
  const DashboardTopCalendarDateExpenseModel({
    required this.amount,
    required this.category,
    required this.shop,
    required this.tags,
  });

  final int amount;
  final String category;
  final String shop;
  final List<String> tags;
}