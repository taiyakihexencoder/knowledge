import 'dart:convert';

/// Jsonを単体のエンティティに変換する。
/// fromMapはstatic関数を各エンティティクラスで定義。
T commonDecodeFromJson<T>(String json, T Function(Map<String, Object?>) fromMap) {
  try {
    return fromMap(jsonDecode(json) as Map<String, Object?>);
  } on FormatException {
    throw FormatException('Could not decode to $T, json=$json');
  }
}

/// Jsonを複数のエンティティに変換する。
/// fromMapはstatic関数を各エンティティクラスで定義。
List<T> commonDecodeFromListJson<T>(String json, T Function(Map<String, Object?>) fromMap) {
  try {
    List list = jsonDecode(json) as List;
    return list.map(
      (data) => fromMap(data as Map<String, Object?>)
    ).toList();
  } on FormatException {
    throw FormatException('Could not decode to List<$T>, json=$json');
  }
}