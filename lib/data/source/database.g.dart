// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CategoryData extends DataClass implements Insertable<CategoryData> {
  final int id;
  final String title;
  CategoryData({required this.id, required this.title});
  factory CategoryData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CategoryData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  CategoryCompanion toCompanion(bool nullToAbsent) {
    return CategoryCompanion(
      id: Value(id),
      title: Value(title),
    );
  }

  factory CategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  CategoryData copyWith({int? id, String? title}) => CategoryData(
        id: id ?? this.id,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryData(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryData &&
          other.id == this.id &&
          other.title == this.title);
}

class CategoryCompanion extends UpdateCompanion<CategoryData> {
  final Value<int> id;
  final Value<String> title;
  const CategoryCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
  });
  CategoryCompanion.insert({
    this.id = const Value.absent(),
    required String title,
  }) : title = Value(title);
  static Insertable<CategoryData> custom({
    Expression<int>? id,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
    });
  }

  CategoryCompanion copyWith({Value<int>? id, Value<String>? title}) {
    return CategoryCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCompanion(')
          ..write('id: $id, ')
          ..write('title: $title')
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
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title];
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
  final String title;
  final String? content;
  final DateTime createdAt;
  final int color;
  final int priority;
  final int? category;
  NoteData(
      {required this.id,
      required this.title,
      this.content,
      required this.createdAt,
      required this.color,
      required this.priority,
      this.category});
  factory NoteData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NoteData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}body']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
      priority: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}priority'])!,
      category: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || content != null) {
      map['body'] = Variable<String?>(content);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['color'] = Variable<int>(color);
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int?>(category);
    }
    return map;
  }

  NoteCompanion toCompanion(bool nullToAbsent) {
    return NoteCompanion(
      id: Value(id),
      title: Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      createdAt: Value(createdAt),
      color: Value(color),
      priority: Value(priority),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory NoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      color: serializer.fromJson<int>(json['color']),
      priority: serializer.fromJson<int>(json['priority']),
      category: serializer.fromJson<int?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String?>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'color': serializer.toJson<int>(color),
      'priority': serializer.toJson<int>(priority),
      'category': serializer.toJson<int?>(category),
    };
  }

  NoteData copyWith(
          {int? id,
          String? title,
          String? content,
          DateTime? createdAt,
          int? color,
          int? priority,
          int? category}) =>
      NoteData(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        color: color ?? this.color,
        priority: priority ?? this.priority,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('NoteData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('color: $color, ')
          ..write('priority: $priority, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, content, createdAt, color, priority, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteData &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.color == this.color &&
          other.priority == this.priority &&
          other.category == this.category);
}

class NoteCompanion extends UpdateCompanion<NoteData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> content;
  final Value<DateTime> createdAt;
  final Value<int> color;
  final Value<int> priority;
  final Value<int?> category;
  const NoteCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.color = const Value.absent(),
    this.priority = const Value.absent(),
    this.category = const Value.absent(),
  });
  NoteCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.content = const Value.absent(),
    required DateTime createdAt,
    required int color,
    required int priority,
    this.category = const Value.absent(),
  })  : title = Value(title),
        createdAt = Value(createdAt),
        color = Value(color),
        priority = Value(priority);
  static Insertable<NoteData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String?>? content,
    Expression<DateTime>? createdAt,
    Expression<int>? color,
    Expression<int>? priority,
    Expression<int?>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'body': content,
      if (createdAt != null) 'created_at': createdAt,
      if (color != null) 'color': color,
      if (priority != null) 'priority': priority,
      if (category != null) 'category': category,
    });
  }

  NoteCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? content,
      Value<DateTime>? createdAt,
      Value<int>? color,
      Value<int>? priority,
      Value<int?>? category}) {
    return NoteCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      color: color ?? this.color,
      priority: priority ?? this.priority,
      category: category ?? this.category,
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
    if (content.present) {
      map['body'] = Variable<String?>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (category.present) {
      map['category'] = Variable<int?>(category.value);
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
          ..write('color: $color, ')
          ..write('priority: $priority, ')
          ..write('category: $category')
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
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'body', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
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
  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int?> priority = GeneratedColumn<int?>(
      'priority', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<int?> category = GeneratedColumn<int?>(
      'category', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints:
          'REFERENCES category (id) ON UPDATE CASCADE ON DELETE SET DEFAULT',
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, createdAt, color, priority, category];
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
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['body']!, _contentMeta));
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
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
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
