/// スナックバー表示用のデータ
class SnackBarModel {
  const SnackBarModel({
    required this.label,
    required this.text,
  });

  /// ラベル（必須）
  final String label;

  /// 表示テキスト
  final String text;
}