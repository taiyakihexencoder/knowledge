/// 購入履歴詳細モデル
/// 
class ContentModel{
  const ContentModel({
    required this.title,
    required this.description,
  });

  /// 購入タイトル
  final String title;

  /// 購入概要
  final String description;
}