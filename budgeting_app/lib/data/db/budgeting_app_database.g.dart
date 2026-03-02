// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budgeting_app_database.dart';

// ignore_for_file: type=lint
class $ExpenseCategoryTable extends ExpenseCategory
    with TableInfo<$ExpenseCategoryTable, ExpenseCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseCategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_category';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseCategoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseCategoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ExpenseCategoryTable createAlias(String alias) {
    return $ExpenseCategoryTable(attachedDatabase, alias);
  }
}

class ExpenseCategoryData extends DataClass
    implements Insertable<ExpenseCategoryData> {
  final int id;
  final String name;
  const ExpenseCategoryData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ExpenseCategoryCompanion toCompanion(bool nullToAbsent) {
    return ExpenseCategoryCompanion(id: Value(id), name: Value(name));
  }

  factory ExpenseCategoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseCategoryData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ExpenseCategoryData copyWith({int? id, String? name}) =>
      ExpenseCategoryData(id: id ?? this.id, name: name ?? this.name);
  ExpenseCategoryData copyWithCompanion(ExpenseCategoryCompanion data) {
    return ExpenseCategoryData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoryData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseCategoryData &&
          other.id == this.id &&
          other.name == this.name);
}

class ExpenseCategoryCompanion extends UpdateCompanion<ExpenseCategoryData> {
  final Value<int> id;
  final Value<String> name;
  const ExpenseCategoryCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ExpenseCategoryCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<ExpenseCategoryData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ExpenseCategoryCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ExpenseCategoryCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoryCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ExpenseContentTable extends ExpenseContent
    with TableInfo<$ExpenseContentTable, ExpenseContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseContentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _historyIdMeta = const VerificationMeta(
    'historyId',
  );
  @override
  late final GeneratedColumn<BigInt> historyId = GeneratedColumn<BigInt>(
    'history_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 300,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [historyId, title, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_content';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseContentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('history_id')) {
      context.handle(
        _historyIdMeta,
        historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {historyId};
  @override
  ExpenseContentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseContentData(
      historyId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}history_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $ExpenseContentTable createAlias(String alias) {
    return $ExpenseContentTable(attachedDatabase, alias);
  }
}

class ExpenseContentData extends DataClass
    implements Insertable<ExpenseContentData> {
  final BigInt historyId;
  final String title;
  final String description;
  const ExpenseContentData({
    required this.historyId,
    required this.title,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['history_id'] = Variable<BigInt>(historyId);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    return map;
  }

  ExpenseContentCompanion toCompanion(bool nullToAbsent) {
    return ExpenseContentCompanion(
      historyId: Value(historyId),
      title: Value(title),
      description: Value(description),
    );
  }

  factory ExpenseContentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseContentData(
      historyId: serializer.fromJson<BigInt>(json['historyId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'historyId': serializer.toJson<BigInt>(historyId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
    };
  }

  ExpenseContentData copyWith({
    BigInt? historyId,
    String? title,
    String? description,
  }) => ExpenseContentData(
    historyId: historyId ?? this.historyId,
    title: title ?? this.title,
    description: description ?? this.description,
  );
  ExpenseContentData copyWithCompanion(ExpenseContentCompanion data) {
    return ExpenseContentData(
      historyId: data.historyId.present ? data.historyId.value : this.historyId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseContentData(')
          ..write('historyId: $historyId, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(historyId, title, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseContentData &&
          other.historyId == this.historyId &&
          other.title == this.title &&
          other.description == this.description);
}

class ExpenseContentCompanion extends UpdateCompanion<ExpenseContentData> {
  final Value<BigInt> historyId;
  final Value<String> title;
  final Value<String> description;
  const ExpenseContentCompanion({
    this.historyId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
  });
  ExpenseContentCompanion.insert({
    this.historyId = const Value.absent(),
    required String title,
    required String description,
  }) : title = Value(title),
       description = Value(description);
  static Insertable<ExpenseContentData> custom({
    Expression<BigInt>? historyId,
    Expression<String>? title,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (historyId != null) 'history_id': historyId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
    });
  }

  ExpenseContentCompanion copyWith({
    Value<BigInt>? historyId,
    Value<String>? title,
    Value<String>? description,
  }) {
    return ExpenseContentCompanion(
      historyId: historyId ?? this.historyId,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (historyId.present) {
      map['history_id'] = Variable<BigInt>(historyId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseContentCompanion(')
          ..write('historyId: $historyId, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $ExpenseHistoryTable extends ExpenseHistory
    with TableInfo<$ExpenseHistoryTable, ExpenseHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<int> shopId = GeneratedColumn<int>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usedAtMeta = const VerificationMeta('usedAt');
  @override
  late final GeneratedColumn<String> usedAt = GeneratedColumn<String>(
    'used_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    shopId,
    amount,
    usedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('used_at')) {
      context.handle(
        _usedAtMeta,
        usedAt.isAcceptableOrUnknown(data['used_at']!, _usedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_usedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shop_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      usedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}used_at'],
      )!,
    );
  }

  @override
  $ExpenseHistoryTable createAlias(String alias) {
    return $ExpenseHistoryTable(attachedDatabase, alias);
  }
}

class ExpenseHistoryData extends DataClass
    implements Insertable<ExpenseHistoryData> {
  final BigInt id;
  final int categoryId;
  final int shopId;
  final int amount;
  final String usedAt;
  const ExpenseHistoryData({
    required this.id,
    required this.categoryId,
    required this.shopId,
    required this.amount,
    required this.usedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['shop_id'] = Variable<int>(shopId);
    map['amount'] = Variable<int>(amount);
    map['used_at'] = Variable<String>(usedAt);
    return map;
  }

  ExpenseHistoryCompanion toCompanion(bool nullToAbsent) {
    return ExpenseHistoryCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      shopId: Value(shopId),
      amount: Value(amount),
      usedAt: Value(usedAt),
    );
  }

  factory ExpenseHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseHistoryData(
      id: serializer.fromJson<BigInt>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      shopId: serializer.fromJson<int>(json['shopId']),
      amount: serializer.fromJson<int>(json['amount']),
      usedAt: serializer.fromJson<String>(json['usedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'shopId': serializer.toJson<int>(shopId),
      'amount': serializer.toJson<int>(amount),
      'usedAt': serializer.toJson<String>(usedAt),
    };
  }

  ExpenseHistoryData copyWith({
    BigInt? id,
    int? categoryId,
    int? shopId,
    int? amount,
    String? usedAt,
  }) => ExpenseHistoryData(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    shopId: shopId ?? this.shopId,
    amount: amount ?? this.amount,
    usedAt: usedAt ?? this.usedAt,
  );
  ExpenseHistoryData copyWithCompanion(ExpenseHistoryCompanion data) {
    return ExpenseHistoryData(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      amount: data.amount.present ? data.amount.value : this.amount,
      usedAt: data.usedAt.present ? data.usedAt.value : this.usedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseHistoryData(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('shopId: $shopId, ')
          ..write('amount: $amount, ')
          ..write('usedAt: $usedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryId, shopId, amount, usedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseHistoryData &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.shopId == this.shopId &&
          other.amount == this.amount &&
          other.usedAt == this.usedAt);
}

class ExpenseHistoryCompanion extends UpdateCompanion<ExpenseHistoryData> {
  final Value<BigInt> id;
  final Value<int> categoryId;
  final Value<int> shopId;
  final Value<int> amount;
  final Value<String> usedAt;
  const ExpenseHistoryCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.shopId = const Value.absent(),
    this.amount = const Value.absent(),
    this.usedAt = const Value.absent(),
  });
  ExpenseHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required int shopId,
    required int amount,
    required String usedAt,
  }) : categoryId = Value(categoryId),
       shopId = Value(shopId),
       amount = Value(amount),
       usedAt = Value(usedAt);
  static Insertable<ExpenseHistoryData> custom({
    Expression<BigInt>? id,
    Expression<int>? categoryId,
    Expression<int>? shopId,
    Expression<int>? amount,
    Expression<String>? usedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (shopId != null) 'shop_id': shopId,
      if (amount != null) 'amount': amount,
      if (usedAt != null) 'used_at': usedAt,
    });
  }

  ExpenseHistoryCompanion copyWith({
    Value<BigInt>? id,
    Value<int>? categoryId,
    Value<int>? shopId,
    Value<int>? amount,
    Value<String>? usedAt,
  }) {
    return ExpenseHistoryCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      shopId: shopId ?? this.shopId,
      amount: amount ?? this.amount,
      usedAt: usedAt ?? this.usedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<int>(shopId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (usedAt.present) {
      map['used_at'] = Variable<String>(usedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseHistoryCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('shopId: $shopId, ')
          ..write('amount: $amount, ')
          ..write('usedAt: $usedAt')
          ..write(')'))
        .toString();
  }
}

class $ExpenseHistoryTagTable extends ExpenseHistoryTag
    with TableInfo<$ExpenseHistoryTagTable, ExpenseHistoryTagData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseHistoryTagTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _historyIdMeta = const VerificationMeta(
    'historyId',
  );
  @override
  late final GeneratedColumn<BigInt> historyId = GeneratedColumn<BigInt>(
    'history_id',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [historyId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_history_tag';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseHistoryTagData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('history_id')) {
      context.handle(
        _historyIdMeta,
        historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_historyIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ExpenseHistoryTagData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseHistoryTagData(
      historyId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}history_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $ExpenseHistoryTagTable createAlias(String alias) {
    return $ExpenseHistoryTagTable(attachedDatabase, alias);
  }
}

class ExpenseHistoryTagData extends DataClass
    implements Insertable<ExpenseHistoryTagData> {
  final BigInt historyId;
  final int tagId;
  const ExpenseHistoryTagData({required this.historyId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['history_id'] = Variable<BigInt>(historyId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  ExpenseHistoryTagCompanion toCompanion(bool nullToAbsent) {
    return ExpenseHistoryTagCompanion(
      historyId: Value(historyId),
      tagId: Value(tagId),
    );
  }

  factory ExpenseHistoryTagData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseHistoryTagData(
      historyId: serializer.fromJson<BigInt>(json['historyId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'historyId': serializer.toJson<BigInt>(historyId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  ExpenseHistoryTagData copyWith({BigInt? historyId, int? tagId}) =>
      ExpenseHistoryTagData(
        historyId: historyId ?? this.historyId,
        tagId: tagId ?? this.tagId,
      );
  ExpenseHistoryTagData copyWithCompanion(ExpenseHistoryTagCompanion data) {
    return ExpenseHistoryTagData(
      historyId: data.historyId.present ? data.historyId.value : this.historyId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseHistoryTagData(')
          ..write('historyId: $historyId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(historyId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseHistoryTagData &&
          other.historyId == this.historyId &&
          other.tagId == this.tagId);
}

class ExpenseHistoryTagCompanion
    extends UpdateCompanion<ExpenseHistoryTagData> {
  final Value<BigInt> historyId;
  final Value<int> tagId;
  final Value<int> rowid;
  const ExpenseHistoryTagCompanion({
    this.historyId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpenseHistoryTagCompanion.insert({
    required BigInt historyId,
    required int tagId,
    this.rowid = const Value.absent(),
  }) : historyId = Value(historyId),
       tagId = Value(tagId);
  static Insertable<ExpenseHistoryTagData> custom({
    Expression<BigInt>? historyId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (historyId != null) 'history_id': historyId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpenseHistoryTagCompanion copyWith({
    Value<BigInt>? historyId,
    Value<int>? tagId,
    Value<int>? rowid,
  }) {
    return ExpenseHistoryTagCompanion(
      historyId: historyId ?? this.historyId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (historyId.present) {
      map['history_id'] = Variable<BigInt>(historyId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseHistoryTagCompanion(')
          ..write('historyId: $historyId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpenseTagTable extends ExpenseTag
    with TableInfo<$ExpenseTagTable, ExpenseTagData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseTagTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_tag';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseTagData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseTagData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseTagData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ExpenseTagTable createAlias(String alias) {
    return $ExpenseTagTable(attachedDatabase, alias);
  }
}

class ExpenseTagData extends DataClass implements Insertable<ExpenseTagData> {
  final int id;
  final String name;
  const ExpenseTagData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ExpenseTagCompanion toCompanion(bool nullToAbsent) {
    return ExpenseTagCompanion(id: Value(id), name: Value(name));
  }

  factory ExpenseTagData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseTagData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ExpenseTagData copyWith({int? id, String? name}) =>
      ExpenseTagData(id: id ?? this.id, name: name ?? this.name);
  ExpenseTagData copyWithCompanion(ExpenseTagCompanion data) {
    return ExpenseTagData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseTagData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseTagData &&
          other.id == this.id &&
          other.name == this.name);
}

class ExpenseTagCompanion extends UpdateCompanion<ExpenseTagData> {
  final Value<int> id;
  final Value<String> name;
  const ExpenseTagCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ExpenseTagCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<ExpenseTagData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ExpenseTagCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ExpenseTagCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseTagCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ShopTable extends Shop with TableInfo<$ShopTable, ShopData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shop';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ShopTable createAlias(String alias) {
    return $ShopTable(attachedDatabase, alias);
  }
}

class ShopData extends DataClass implements Insertable<ShopData> {
  final int id;
  final String name;
  const ShopData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ShopCompanion toCompanion(bool nullToAbsent) {
    return ShopCompanion(id: Value(id), name: Value(name));
  }

  factory ShopData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ShopData copyWith({int? id, String? name}) =>
      ShopData(id: id ?? this.id, name: name ?? this.name);
  ShopData copyWithCompanion(ShopCompanion data) {
    return ShopData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopData && other.id == this.id && other.name == this.name);
}

class ShopCompanion extends UpdateCompanion<ShopData> {
  final Value<int> id;
  final Value<String> name;
  const ShopCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ShopCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<ShopData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ShopCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ShopCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

abstract class _$BudgetingAppDatabase extends GeneratedDatabase {
  _$BudgetingAppDatabase(QueryExecutor e) : super(e);
  $BudgetingAppDatabaseManager get managers =>
      $BudgetingAppDatabaseManager(this);
  late final $ExpenseCategoryTable expenseCategory = $ExpenseCategoryTable(
    this,
  );
  late final $ExpenseContentTable expenseContent = $ExpenseContentTable(this);
  late final $ExpenseHistoryTable expenseHistory = $ExpenseHistoryTable(this);
  late final $ExpenseHistoryTagTable expenseHistoryTag =
      $ExpenseHistoryTagTable(this);
  late final $ExpenseTagTable expenseTag = $ExpenseTagTable(this);
  late final $ShopTable shop = $ShopTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    expenseCategory,
    expenseContent,
    expenseHistory,
    expenseHistoryTag,
    expenseTag,
    shop,
  ];
}

typedef $$ExpenseCategoryTableCreateCompanionBuilder =
    ExpenseCategoryCompanion Function({Value<int> id, required String name});
typedef $$ExpenseCategoryTableUpdateCompanionBuilder =
    ExpenseCategoryCompanion Function({Value<int> id, Value<String> name});

class $$ExpenseCategoryTableFilterComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseCategoryTable> {
  $$ExpenseCategoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseCategoryTableOrderingComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseCategoryTable> {
  $$ExpenseCategoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseCategoryTableAnnotationComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseCategoryTable> {
  $$ExpenseCategoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$ExpenseCategoryTableTableManager
    extends
        RootTableManager<
          _$BudgetingAppDatabase,
          $ExpenseCategoryTable,
          ExpenseCategoryData,
          $$ExpenseCategoryTableFilterComposer,
          $$ExpenseCategoryTableOrderingComposer,
          $$ExpenseCategoryTableAnnotationComposer,
          $$ExpenseCategoryTableCreateCompanionBuilder,
          $$ExpenseCategoryTableUpdateCompanionBuilder,
          (
            ExpenseCategoryData,
            BaseReferences<
              _$BudgetingAppDatabase,
              $ExpenseCategoryTable,
              ExpenseCategoryData
            >,
          ),
          ExpenseCategoryData,
          PrefetchHooks Function()
        > {
  $$ExpenseCategoryTableTableManager(
    _$BudgetingAppDatabase db,
    $ExpenseCategoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseCategoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseCategoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseCategoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => ExpenseCategoryCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  ExpenseCategoryCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseCategoryTableProcessedTableManager =
    ProcessedTableManager<
      _$BudgetingAppDatabase,
      $ExpenseCategoryTable,
      ExpenseCategoryData,
      $$ExpenseCategoryTableFilterComposer,
      $$ExpenseCategoryTableOrderingComposer,
      $$ExpenseCategoryTableAnnotationComposer,
      $$ExpenseCategoryTableCreateCompanionBuilder,
      $$ExpenseCategoryTableUpdateCompanionBuilder,
      (
        ExpenseCategoryData,
        BaseReferences<
          _$BudgetingAppDatabase,
          $ExpenseCategoryTable,
          ExpenseCategoryData
        >,
      ),
      ExpenseCategoryData,
      PrefetchHooks Function()
    >;
typedef $$ExpenseContentTableCreateCompanionBuilder =
    ExpenseContentCompanion Function({
      Value<BigInt> historyId,
      required String title,
      required String description,
    });
typedef $$ExpenseContentTableUpdateCompanionBuilder =
    ExpenseContentCompanion Function({
      Value<BigInt> historyId,
      Value<String> title,
      Value<String> description,
    });

class $$ExpenseContentTableFilterComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseContentTable> {
  $$ExpenseContentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseContentTableOrderingComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseContentTable> {
  $$ExpenseContentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseContentTableAnnotationComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseContentTable> {
  $$ExpenseContentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get historyId =>
      $composableBuilder(column: $table.historyId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$ExpenseContentTableTableManager
    extends
        RootTableManager<
          _$BudgetingAppDatabase,
          $ExpenseContentTable,
          ExpenseContentData,
          $$ExpenseContentTableFilterComposer,
          $$ExpenseContentTableOrderingComposer,
          $$ExpenseContentTableAnnotationComposer,
          $$ExpenseContentTableCreateCompanionBuilder,
          $$ExpenseContentTableUpdateCompanionBuilder,
          (
            ExpenseContentData,
            BaseReferences<
              _$BudgetingAppDatabase,
              $ExpenseContentTable,
              ExpenseContentData
            >,
          ),
          ExpenseContentData,
          PrefetchHooks Function()
        > {
  $$ExpenseContentTableTableManager(
    _$BudgetingAppDatabase db,
    $ExpenseContentTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseContentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseContentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseContentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> historyId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
              }) => ExpenseContentCompanion(
                historyId: historyId,
                title: title,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> historyId = const Value.absent(),
                required String title,
                required String description,
              }) => ExpenseContentCompanion.insert(
                historyId: historyId,
                title: title,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseContentTableProcessedTableManager =
    ProcessedTableManager<
      _$BudgetingAppDatabase,
      $ExpenseContentTable,
      ExpenseContentData,
      $$ExpenseContentTableFilterComposer,
      $$ExpenseContentTableOrderingComposer,
      $$ExpenseContentTableAnnotationComposer,
      $$ExpenseContentTableCreateCompanionBuilder,
      $$ExpenseContentTableUpdateCompanionBuilder,
      (
        ExpenseContentData,
        BaseReferences<
          _$BudgetingAppDatabase,
          $ExpenseContentTable,
          ExpenseContentData
        >,
      ),
      ExpenseContentData,
      PrefetchHooks Function()
    >;
typedef $$ExpenseHistoryTableCreateCompanionBuilder =
    ExpenseHistoryCompanion Function({
      Value<BigInt> id,
      required int categoryId,
      required int shopId,
      required int amount,
      required String usedAt,
    });
typedef $$ExpenseHistoryTableUpdateCompanionBuilder =
    ExpenseHistoryCompanion Function({
      Value<BigInt> id,
      Value<int> categoryId,
      Value<int> shopId,
      Value<int> amount,
      Value<String> usedAt,
    });

class $$ExpenseHistoryTableFilterComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseHistoryTable> {
  $$ExpenseHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseHistoryTableOrderingComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseHistoryTable> {
  $$ExpenseHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseHistoryTableAnnotationComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseHistoryTable> {
  $$ExpenseHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get usedAt =>
      $composableBuilder(column: $table.usedAt, builder: (column) => column);
}

class $$ExpenseHistoryTableTableManager
    extends
        RootTableManager<
          _$BudgetingAppDatabase,
          $ExpenseHistoryTable,
          ExpenseHistoryData,
          $$ExpenseHistoryTableFilterComposer,
          $$ExpenseHistoryTableOrderingComposer,
          $$ExpenseHistoryTableAnnotationComposer,
          $$ExpenseHistoryTableCreateCompanionBuilder,
          $$ExpenseHistoryTableUpdateCompanionBuilder,
          (
            ExpenseHistoryData,
            BaseReferences<
              _$BudgetingAppDatabase,
              $ExpenseHistoryTable,
              ExpenseHistoryData
            >,
          ),
          ExpenseHistoryData,
          PrefetchHooks Function()
        > {
  $$ExpenseHistoryTableTableManager(
    _$BudgetingAppDatabase db,
    $ExpenseHistoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<int> shopId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> usedAt = const Value.absent(),
              }) => ExpenseHistoryCompanion(
                id: id,
                categoryId: categoryId,
                shopId: shopId,
                amount: amount,
                usedAt: usedAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required int categoryId,
                required int shopId,
                required int amount,
                required String usedAt,
              }) => ExpenseHistoryCompanion.insert(
                id: id,
                categoryId: categoryId,
                shopId: shopId,
                amount: amount,
                usedAt: usedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$BudgetingAppDatabase,
      $ExpenseHistoryTable,
      ExpenseHistoryData,
      $$ExpenseHistoryTableFilterComposer,
      $$ExpenseHistoryTableOrderingComposer,
      $$ExpenseHistoryTableAnnotationComposer,
      $$ExpenseHistoryTableCreateCompanionBuilder,
      $$ExpenseHistoryTableUpdateCompanionBuilder,
      (
        ExpenseHistoryData,
        BaseReferences<
          _$BudgetingAppDatabase,
          $ExpenseHistoryTable,
          ExpenseHistoryData
        >,
      ),
      ExpenseHistoryData,
      PrefetchHooks Function()
    >;
typedef $$ExpenseHistoryTagTableCreateCompanionBuilder =
    ExpenseHistoryTagCompanion Function({
      required BigInt historyId,
      required int tagId,
      Value<int> rowid,
    });
typedef $$ExpenseHistoryTagTableUpdateCompanionBuilder =
    ExpenseHistoryTagCompanion Function({
      Value<BigInt> historyId,
      Value<int> tagId,
      Value<int> rowid,
    });

class $$ExpenseHistoryTagTableFilterComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseHistoryTagTable> {
  $$ExpenseHistoryTagTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseHistoryTagTableOrderingComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseHistoryTagTable> {
  $$ExpenseHistoryTagTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseHistoryTagTableAnnotationComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseHistoryTagTable> {
  $$ExpenseHistoryTagTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get historyId =>
      $composableBuilder(column: $table.historyId, builder: (column) => column);

  GeneratedColumn<int> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);
}

class $$ExpenseHistoryTagTableTableManager
    extends
        RootTableManager<
          _$BudgetingAppDatabase,
          $ExpenseHistoryTagTable,
          ExpenseHistoryTagData,
          $$ExpenseHistoryTagTableFilterComposer,
          $$ExpenseHistoryTagTableOrderingComposer,
          $$ExpenseHistoryTagTableAnnotationComposer,
          $$ExpenseHistoryTagTableCreateCompanionBuilder,
          $$ExpenseHistoryTagTableUpdateCompanionBuilder,
          (
            ExpenseHistoryTagData,
            BaseReferences<
              _$BudgetingAppDatabase,
              $ExpenseHistoryTagTable,
              ExpenseHistoryTagData
            >,
          ),
          ExpenseHistoryTagData,
          PrefetchHooks Function()
        > {
  $$ExpenseHistoryTagTableTableManager(
    _$BudgetingAppDatabase db,
    $ExpenseHistoryTagTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseHistoryTagTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseHistoryTagTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseHistoryTagTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<BigInt> historyId = const Value.absent(),
                Value<int> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpenseHistoryTagCompanion(
                historyId: historyId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required BigInt historyId,
                required int tagId,
                Value<int> rowid = const Value.absent(),
              }) => ExpenseHistoryTagCompanion.insert(
                historyId: historyId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseHistoryTagTableProcessedTableManager =
    ProcessedTableManager<
      _$BudgetingAppDatabase,
      $ExpenseHistoryTagTable,
      ExpenseHistoryTagData,
      $$ExpenseHistoryTagTableFilterComposer,
      $$ExpenseHistoryTagTableOrderingComposer,
      $$ExpenseHistoryTagTableAnnotationComposer,
      $$ExpenseHistoryTagTableCreateCompanionBuilder,
      $$ExpenseHistoryTagTableUpdateCompanionBuilder,
      (
        ExpenseHistoryTagData,
        BaseReferences<
          _$BudgetingAppDatabase,
          $ExpenseHistoryTagTable,
          ExpenseHistoryTagData
        >,
      ),
      ExpenseHistoryTagData,
      PrefetchHooks Function()
    >;
typedef $$ExpenseTagTableCreateCompanionBuilder =
    ExpenseTagCompanion Function({Value<int> id, required String name});
typedef $$ExpenseTagTableUpdateCompanionBuilder =
    ExpenseTagCompanion Function({Value<int> id, Value<String> name});

class $$ExpenseTagTableFilterComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseTagTable> {
  $$ExpenseTagTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseTagTableOrderingComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseTagTable> {
  $$ExpenseTagTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseTagTableAnnotationComposer
    extends Composer<_$BudgetingAppDatabase, $ExpenseTagTable> {
  $$ExpenseTagTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$ExpenseTagTableTableManager
    extends
        RootTableManager<
          _$BudgetingAppDatabase,
          $ExpenseTagTable,
          ExpenseTagData,
          $$ExpenseTagTableFilterComposer,
          $$ExpenseTagTableOrderingComposer,
          $$ExpenseTagTableAnnotationComposer,
          $$ExpenseTagTableCreateCompanionBuilder,
          $$ExpenseTagTableUpdateCompanionBuilder,
          (
            ExpenseTagData,
            BaseReferences<
              _$BudgetingAppDatabase,
              $ExpenseTagTable,
              ExpenseTagData
            >,
          ),
          ExpenseTagData,
          PrefetchHooks Function()
        > {
  $$ExpenseTagTableTableManager(
    _$BudgetingAppDatabase db,
    $ExpenseTagTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseTagTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseTagTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseTagTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => ExpenseTagCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  ExpenseTagCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseTagTableProcessedTableManager =
    ProcessedTableManager<
      _$BudgetingAppDatabase,
      $ExpenseTagTable,
      ExpenseTagData,
      $$ExpenseTagTableFilterComposer,
      $$ExpenseTagTableOrderingComposer,
      $$ExpenseTagTableAnnotationComposer,
      $$ExpenseTagTableCreateCompanionBuilder,
      $$ExpenseTagTableUpdateCompanionBuilder,
      (
        ExpenseTagData,
        BaseReferences<
          _$BudgetingAppDatabase,
          $ExpenseTagTable,
          ExpenseTagData
        >,
      ),
      ExpenseTagData,
      PrefetchHooks Function()
    >;
typedef $$ShopTableCreateCompanionBuilder =
    ShopCompanion Function({Value<int> id, required String name});
typedef $$ShopTableUpdateCompanionBuilder =
    ShopCompanion Function({Value<int> id, Value<String> name});

class $$ShopTableFilterComposer
    extends Composer<_$BudgetingAppDatabase, $ShopTable> {
  $$ShopTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopTableOrderingComposer
    extends Composer<_$BudgetingAppDatabase, $ShopTable> {
  $$ShopTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopTableAnnotationComposer
    extends Composer<_$BudgetingAppDatabase, $ShopTable> {
  $$ShopTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$ShopTableTableManager
    extends
        RootTableManager<
          _$BudgetingAppDatabase,
          $ShopTable,
          ShopData,
          $$ShopTableFilterComposer,
          $$ShopTableOrderingComposer,
          $$ShopTableAnnotationComposer,
          $$ShopTableCreateCompanionBuilder,
          $$ShopTableUpdateCompanionBuilder,
          (
            ShopData,
            BaseReferences<_$BudgetingAppDatabase, $ShopTable, ShopData>,
          ),
          ShopData,
          PrefetchHooks Function()
        > {
  $$ShopTableTableManager(_$BudgetingAppDatabase db, $ShopTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => ShopCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  ShopCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopTableProcessedTableManager =
    ProcessedTableManager<
      _$BudgetingAppDatabase,
      $ShopTable,
      ShopData,
      $$ShopTableFilterComposer,
      $$ShopTableOrderingComposer,
      $$ShopTableAnnotationComposer,
      $$ShopTableCreateCompanionBuilder,
      $$ShopTableUpdateCompanionBuilder,
      (ShopData, BaseReferences<_$BudgetingAppDatabase, $ShopTable, ShopData>),
      ShopData,
      PrefetchHooks Function()
    >;

class $BudgetingAppDatabaseManager {
  final _$BudgetingAppDatabase _db;
  $BudgetingAppDatabaseManager(this._db);
  $$ExpenseCategoryTableTableManager get expenseCategory =>
      $$ExpenseCategoryTableTableManager(_db, _db.expenseCategory);
  $$ExpenseContentTableTableManager get expenseContent =>
      $$ExpenseContentTableTableManager(_db, _db.expenseContent);
  $$ExpenseHistoryTableTableManager get expenseHistory =>
      $$ExpenseHistoryTableTableManager(_db, _db.expenseHistory);
  $$ExpenseHistoryTagTableTableManager get expenseHistoryTag =>
      $$ExpenseHistoryTagTableTableManager(_db, _db.expenseHistoryTag);
  $$ExpenseTagTableTableManager get expenseTag =>
      $$ExpenseTagTableTableManager(_db, _db.expenseTag);
  $$ShopTableTableManager get shop => $$ShopTableTableManager(_db, _db.shop);
}
