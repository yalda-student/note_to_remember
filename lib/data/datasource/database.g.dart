// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CategoryData extends DataClass implements Insertable<CategoryData> {
  final int id;
  final String title;
  final DateTime createdAt;
  final int color;
  CategoryData(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.color});
  factory CategoryData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CategoryData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['color'] = Variable<int>(color);
    return map;
  }

  CategoryCompanion toCompanion(bool nullToAbsent) {
    return CategoryCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      color: Value(color),
    );
  }

  factory CategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'color': serializer.toJson<int>(color),
    };
  }

  CategoryData copyWith(
          {int? id, String? title, DateTime? createdAt, int? color}) =>
      CategoryData(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, createdAt, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryData &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.color == this.color);
}

class CategoryCompanion extends UpdateCompanion<CategoryData> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<int> color;
  const CategoryCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.color = const Value.absent(),
  });
  CategoryCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required DateTime createdAt,
    required int color,
  })  : title = Value(title),
        createdAt = Value(createdAt),
        color = Value(color);
  static Insertable<CategoryData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (color != null) 'color': color,
    });
  }

  CategoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<int>? color}) {
    return CategoryCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $CategoryTable extends Category
    with TableInfo<$CategoryTable, CategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int?> color = GeneratedColumn<int?>(
      'color', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, createdAt, color];
  @override
  String get aliasedName => _alias ?? 'category';
  @override
  String get actualTableName => 'category';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CategoryData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CategoryTable createAlias(String alias) {
    return $CategoryTable(attachedDatabase, alias);
  }
}

class NoteData extends DataClass implements Insertable<NoteData> {
  final int id;
  final String? title;
  final String content;
  final DateTime createdAt;
  final int colorIndex;
  final bool isFavorite;
  final int categoryId;
  NoteData(
      {required this.id,
      this.title,
      required this.content,
      required this.createdAt,
      required this.colorIndex,
      required this.isFavorite,
      required this.categoryId});
  factory NoteData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NoteData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}body'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      colorIndex: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color_index'])!,
      isFavorite: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_favorite'])!,
      categoryId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    map['body'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['color_index'] = Variable<int>(colorIndex);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  NoteCompanion toCompanion(bool nullToAbsent) {
    return NoteCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: Value(content),
      createdAt: Value(createdAt),
      colorIndex: Value(colorIndex),
      isFavorite: Value(isFavorite),
      categoryId: Value(categoryId),
    );
  }

  factory NoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      colorIndex: serializer.fromJson<int>(json['colorIndex']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'colorIndex': serializer.toJson<int>(colorIndex),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  NoteData copyWith(
          {int? id,
          String? title,
          String? content,
          DateTime? createdAt,
          int? colorIndex,
          bool? isFavorite,
          int? categoryId}) =>
      NoteData(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        colorIndex: colorIndex ?? this.colorIndex,
        isFavorite: isFavorite ?? this.isFavorite,
        categoryId: categoryId ?? this.categoryId,
      );
  @override
  String toString() {
    return (StringBuffer('NoteData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, content, createdAt, colorIndex, isFavorite, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteData &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.colorIndex == this.colorIndex &&
          other.isFavorite == this.isFavorite &&
          other.categoryId == this.categoryId);
}

class NoteCompanion extends UpdateCompanion<NoteData> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<int> colorIndex;
  final Value<bool> isFavorite;
  final Value<int> categoryId;
  const NoteCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.colorIndex = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.categoryId = const Value.absent(),
  });
  NoteCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    required String content,
    required DateTime createdAt,
    required int colorIndex,
    this.isFavorite = const Value.absent(),
    this.categoryId = const Value.absent(),
  })  : content = Value(content),
        createdAt = Value(createdAt),
        colorIndex = Value(colorIndex);
  static Insertable<NoteData> custom({
    Expression<int>? id,
    Expression<String?>? title,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<int>? colorIndex,
    Expression<bool>? isFavorite,
    Expression<int>? categoryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'body': content,
      if (createdAt != null) 'created_at': createdAt,
      if (colorIndex != null) 'color_index': colorIndex,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (categoryId != null) 'category_id': categoryId,
    });
  }

  NoteCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String>? content,
      Value<DateTime>? createdAt,
      Value<int>? colorIndex,
      Value<bool>? isFavorite,
      Value<int>? categoryId}) {
    return NoteCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      colorIndex: colorIndex ?? this.colorIndex,
      isFavorite: isFavorite ?? this.isFavorite,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (content.present) {
      map['body'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (colorIndex.present) {
      map['color_index'] = Variable<int>(colorIndex.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }
}

class $NoteTable extends Note with TableInfo<$NoteTable, NoteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'body', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _colorIndexMeta = const VerificationMeta('colorIndex');
  @override
  late final GeneratedColumn<int?> colorIndex = GeneratedColumn<int?>(
      'color_index', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool?> isFavorite = GeneratedColumn<bool?>(
      'is_favorite', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_favorite IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int?> categoryId = GeneratedColumn<int?>(
      'category_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints:
          'REFERENCES category (id) ON UPDATE CASCADE ON DELETE SET DEFAULT',
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, createdAt, colorIndex, isFavorite, categoryId];
  @override
  String get aliasedName => _alias ?? 'note';
  @override
  String get actualTableName => 'note';
  @override
  VerificationContext validateIntegrity(Insertable<NoteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('body')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['body']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('color_index')) {
      context.handle(
          _colorIndexMeta,
          colorIndex.isAcceptableOrUnknown(
              data['color_index']!, _colorIndexMeta));
    } else if (isInserting) {
      context.missing(_colorIndexMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NoteData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NoteTable createAlias(String alias) {
    return $NoteTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CategoryTable category = $CategoryTable(this);
  late final $NoteTable note = $NoteTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [category, note];
}
