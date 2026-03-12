/// カレンダー表示のためのデータモデル
/// 
/// year: 対象年
/// 
/// month: 対象月
/// 
/// prevMonthDates: 表示する前月の日付.
/// 日曜日から始まらない場合は前月の日付で埋めるため.
/// 
/// days: この月は何日まであるか
class DashboardTopMonthlyCalendarModel {
  const DashboardTopMonthlyCalendarModel({
    required this.year,
    required this.month,
    required this.prevMonthDates,
    required this.days,
  });

  /// DateTime型から生成
  DashboardTopMonthlyCalendarModel.fromDateTime(DateTime dateTime): this(
    year: dateTime.year,
    month: dateTime.month,
    prevMonthDates: List.generate(
      dateTime.copyWith(day: 1).weekday % 7, 
      (index) {
        final firstDate = DateTime(dateTime.year, dateTime.month, 1);
        final int count = firstDate.weekday % 7;
        final int lastDay = firstDate.add(Duration(days: -1)).day;
        return lastDay - count + index + 1;
      }
    ),
    days: DateTime(dateTime.year, dateTime.month+1, 1).add(Duration(days: -1)).day,
  );

  /// 何年か（西暦）
  final int year;

  /// 何月か
  final int month;

  /// 前の月の表示分
  final List<int> prevMonthDates;

  /// この月は何日あるか
  final int days;
}