// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CartItemsTable extends CartItems
    with TableInfo<$CartItemsTable, CartItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceValueMeta = const VerificationMeta(
    'priceValue',
  );
  @override
  late final GeneratedColumn<String> priceValue = GeneratedColumn<String>(
    'price_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceCurrencyMeta = const VerificationMeta(
    'priceCurrency',
  );
  @override
  late final GeneratedColumn<String> priceCurrency = GeneratedColumn<String>(
    'price_currency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    productId,
    imageUrl,
    description,
    priceValue,
    priceCurrency,
    qty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('price_value')) {
      context.handle(
        _priceValueMeta,
        priceValue.isAcceptableOrUnknown(data['price_value']!, _priceValueMeta),
      );
    }
    if (data.containsKey('price_currency')) {
      context.handle(
        _priceCurrencyMeta,
        priceCurrency.isAcceptableOrUnknown(
          data['price_currency']!,
          _priceCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  CartItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItem(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      priceValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_value'],
      ),
      priceCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_currency'],
      ),
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
    );
  }

  @override
  $CartItemsTable createAlias(String alias) {
    return $CartItemsTable(attachedDatabase, alias);
  }
}

class CartItem extends DataClass implements Insertable<CartItem> {
  final String productId;
  final String? imageUrl;
  final String? description;
  final String? priceValue;
  final String? priceCurrency;
  final int qty;
  const CartItem({
    required this.productId,
    this.imageUrl,
    this.description,
    this.priceValue,
    this.priceCurrency,
    required this.qty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || priceValue != null) {
      map['price_value'] = Variable<String>(priceValue);
    }
    if (!nullToAbsent || priceCurrency != null) {
      map['price_currency'] = Variable<String>(priceCurrency);
    }
    map['qty'] = Variable<int>(qty);
    return map;
  }

  CartItemsCompanion toCompanion(bool nullToAbsent) {
    return CartItemsCompanion(
      productId: Value(productId),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      priceValue: priceValue == null && nullToAbsent
          ? const Value.absent()
          : Value(priceValue),
      priceCurrency: priceCurrency == null && nullToAbsent
          ? const Value.absent()
          : Value(priceCurrency),
      qty: Value(qty),
    );
  }

  factory CartItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItem(
      productId: serializer.fromJson<String>(json['productId']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      description: serializer.fromJson<String?>(json['description']),
      priceValue: serializer.fromJson<String?>(json['priceValue']),
      priceCurrency: serializer.fromJson<String?>(json['priceCurrency']),
      qty: serializer.fromJson<int>(json['qty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'description': serializer.toJson<String?>(description),
      'priceValue': serializer.toJson<String?>(priceValue),
      'priceCurrency': serializer.toJson<String?>(priceCurrency),
      'qty': serializer.toJson<int>(qty),
    };
  }

  CartItem copyWith({
    String? productId,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> priceValue = const Value.absent(),
    Value<String?> priceCurrency = const Value.absent(),
    int? qty,
  }) => CartItem(
    productId: productId ?? this.productId,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    description: description.present ? description.value : this.description,
    priceValue: priceValue.present ? priceValue.value : this.priceValue,
    priceCurrency: priceCurrency.present
        ? priceCurrency.value
        : this.priceCurrency,
    qty: qty ?? this.qty,
  );
  CartItem copyWithCompanion(CartItemsCompanion data) {
    return CartItem(
      productId: data.productId.present ? data.productId.value : this.productId,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      description: data.description.present
          ? data.description.value
          : this.description,
      priceValue: data.priceValue.present
          ? data.priceValue.value
          : this.priceValue,
      priceCurrency: data.priceCurrency.present
          ? data.priceCurrency.value
          : this.priceCurrency,
      qty: data.qty.present ? data.qty.value : this.qty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItem(')
          ..write('productId: $productId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('description: $description, ')
          ..write('priceValue: $priceValue, ')
          ..write('priceCurrency: $priceCurrency, ')
          ..write('qty: $qty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    productId,
    imageUrl,
    description,
    priceValue,
    priceCurrency,
    qty,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItem &&
          other.productId == this.productId &&
          other.imageUrl == this.imageUrl &&
          other.description == this.description &&
          other.priceValue == this.priceValue &&
          other.priceCurrency == this.priceCurrency &&
          other.qty == this.qty);
}

class CartItemsCompanion extends UpdateCompanion<CartItem> {
  final Value<String> productId;
  final Value<String?> imageUrl;
  final Value<String?> description;
  final Value<String?> priceValue;
  final Value<String?> priceCurrency;
  final Value<int> qty;
  final Value<int> rowid;
  const CartItemsCompanion({
    this.productId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.priceValue = const Value.absent(),
    this.priceCurrency = const Value.absent(),
    this.qty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CartItemsCompanion.insert({
    required String productId,
    this.imageUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.priceValue = const Value.absent(),
    this.priceCurrency = const Value.absent(),
    this.qty = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : productId = Value(productId);
  static Insertable<CartItem> custom({
    Expression<String>? productId,
    Expression<String>? imageUrl,
    Expression<String>? description,
    Expression<String>? priceValue,
    Expression<String>? priceCurrency,
    Expression<int>? qty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (imageUrl != null) 'image_url': imageUrl,
      if (description != null) 'description': description,
      if (priceValue != null) 'price_value': priceValue,
      if (priceCurrency != null) 'price_currency': priceCurrency,
      if (qty != null) 'qty': qty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CartItemsCompanion copyWith({
    Value<String>? productId,
    Value<String?>? imageUrl,
    Value<String?>? description,
    Value<String?>? priceValue,
    Value<String?>? priceCurrency,
    Value<int>? qty,
    Value<int>? rowid,
  }) {
    return CartItemsCompanion(
      productId: productId ?? this.productId,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      priceValue: priceValue ?? this.priceValue,
      priceCurrency: priceCurrency ?? this.priceCurrency,
      qty: qty ?? this.qty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (priceValue.present) {
      map['price_value'] = Variable<String>(priceValue.value);
    }
    if (priceCurrency.present) {
      map['price_currency'] = Variable<String>(priceCurrency.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsCompanion(')
          ..write('productId: $productId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('description: $description, ')
          ..write('priceValue: $priceValue, ')
          ..write('priceCurrency: $priceCurrency, ')
          ..write('qty: $qty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CartItemsTable cartItems = $CartItemsTable(this);
  late final CartDao cartDao = CartDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cartItems];
}

typedef $$CartItemsTableCreateCompanionBuilder =
    CartItemsCompanion Function({
      required String productId,
      Value<String?> imageUrl,
      Value<String?> description,
      Value<String?> priceValue,
      Value<String?> priceCurrency,
      Value<int> qty,
      Value<int> rowid,
    });
typedef $$CartItemsTableUpdateCompanionBuilder =
    CartItemsCompanion Function({
      Value<String> productId,
      Value<String?> imageUrl,
      Value<String?> description,
      Value<String?> priceValue,
      Value<String?> priceCurrency,
      Value<int> qty,
      Value<int> rowid,
    });

class $$CartItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priceValue => $composableBuilder(
    column: $table.priceValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priceCurrency => $composableBuilder(
    column: $table.priceCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CartItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceValue => $composableBuilder(
    column: $table.priceValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceCurrency => $composableBuilder(
    column: $table.priceCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priceValue => $composableBuilder(
    column: $table.priceValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priceCurrency => $composableBuilder(
    column: $table.priceCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);
}

class $$CartItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartItemsTable,
          CartItem,
          $$CartItemsTableFilterComposer,
          $$CartItemsTableOrderingComposer,
          $$CartItemsTableAnnotationComposer,
          $$CartItemsTableCreateCompanionBuilder,
          $$CartItemsTableUpdateCompanionBuilder,
          (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
          CartItem,
          PrefetchHooks Function()
        > {
  $$CartItemsTableTableManager(_$AppDatabase db, $CartItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> productId = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> priceValue = const Value.absent(),
                Value<String?> priceCurrency = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CartItemsCompanion(
                productId: productId,
                imageUrl: imageUrl,
                description: description,
                priceValue: priceValue,
                priceCurrency: priceCurrency,
                qty: qty,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String productId,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> priceValue = const Value.absent(),
                Value<String?> priceCurrency = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CartItemsCompanion.insert(
                productId: productId,
                imageUrl: imageUrl,
                description: description,
                priceValue: priceValue,
                priceCurrency: priceCurrency,
                qty: qty,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CartItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartItemsTable,
      CartItem,
      $$CartItemsTableFilterComposer,
      $$CartItemsTableOrderingComposer,
      $$CartItemsTableAnnotationComposer,
      $$CartItemsTableCreateCompanionBuilder,
      $$CartItemsTableUpdateCompanionBuilder,
      (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
      CartItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CartItemsTableTableManager get cartItems =>
      $$CartItemsTableTableManager(_db, _db.cartItems);
}
