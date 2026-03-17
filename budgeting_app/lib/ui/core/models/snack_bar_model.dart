/// スナックバー表示用のデータ
class SnackBarModel {
  const SnackBarModel({
    required this.label,
    required this.text,
    required this.type,
  });

  /// 通常スナックバー
  SnackBarModel.confirm(String text) : this(
    label: 'confirm',
    text: text,
    type: SnackBarType.confirm,
  );

  /// 警告スナックバー
  SnackBarModel.alert(String text) : this(
    label: 'alert',
    text: text,
    type: SnackBarType.alert,
  );

  /// ラベル（必須）
  final String label;

  /// 表示テキスト
  final String text;

  /// スナックバーの種類
  final SnackBarType type;
}

enum SnackBarType {
  confirm,
  alert;
}