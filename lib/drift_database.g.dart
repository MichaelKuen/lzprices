// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wooIdMeta = const VerificationMeta('wooId');
  @override
  late final GeneratedColumn<int> wooId = GeneratedColumn<int>(
    'woo_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installerPriceMeta = const VerificationMeta(
    'installerPrice',
  );
  @override
  late final GeneratedColumn<double> installerPrice = GeneratedColumn<double>(
    'installer_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wholesalePriceMeta = const VerificationMeta(
    'wholesalePrice',
  );
  @override
  late final GeneratedColumn<double> wholesalePrice = GeneratedColumn<double>(
    'wholesale_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lowThresholdMeta = const VerificationMeta(
    'lowThreshold',
  );
  @override
  late final GeneratedColumn<int> lowThreshold = GeneratedColumn<int>(
    'low_threshold',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _whatsappSentMeta = const VerificationMeta(
    'whatsappSent',
  );
  @override
  late final GeneratedColumn<bool> whatsappSent = GeneratedColumn<bool>(
    'whatsapp_sent',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("whatsapp_sent" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String>
  categories = GeneratedColumn<String>(
    'categories',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<String>?>($ProductsTable.$convertercategoriesn);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> imageUrls =
      GeneratedColumn<String>(
        'image_urls',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($ProductsTable.$converterimageUrlsn);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wooStatusMeta = const VerificationMeta(
    'wooStatus',
  );
  @override
  late final GeneratedColumn<String> wooStatus = GeneratedColumn<String>(
    'woo_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> locations =
      GeneratedColumn<String>(
        'locations',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($ProductsTable.$converterlocationsn);
  static const VerificationMeta _shortDescriptionMeta = const VerificationMeta(
    'shortDescription',
  );
  @override
  late final GeneratedColumn<String> shortDescription = GeneratedColumn<String>(
    'short_description',
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
  static const VerificationMeta _searchableNameMeta = const VerificationMeta(
    'searchableName',
  );
  @override
  late final GeneratedColumn<String> searchableName = GeneratedColumn<String>(
    'searchable_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedFromMeta = const VerificationMeta(
    'lastSyncedFrom',
  );
  @override
  late final GeneratedColumn<String> lastSyncedFrom = GeneratedColumn<String>(
    'last_synced_from',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wooId,
    name,
    sku,
    price,
    installerPrice,
    wholesalePrice,
    quantity,
    lowThreshold,
    whatsappSent,
    categories,
    imageUrls,
    createdAt,
    updatedAt,
    userId,
    wooStatus,
    locations,
    shortDescription,
    description,
    searchableName,
    lastSyncedFrom,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('woo_id')) {
      context.handle(
        _wooIdMeta,
        wooId.isAcceptableOrUnknown(data['woo_id']!, _wooIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('installer_price')) {
      context.handle(
        _installerPriceMeta,
        installerPrice.isAcceptableOrUnknown(
          data['installer_price']!,
          _installerPriceMeta,
        ),
      );
    }
    if (data.containsKey('wholesale_price')) {
      context.handle(
        _wholesalePriceMeta,
        wholesalePrice.isAcceptableOrUnknown(
          data['wholesale_price']!,
          _wholesalePriceMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('low_threshold')) {
      context.handle(
        _lowThresholdMeta,
        lowThreshold.isAcceptableOrUnknown(
          data['low_threshold']!,
          _lowThresholdMeta,
        ),
      );
    }
    if (data.containsKey('whatsapp_sent')) {
      context.handle(
        _whatsappSentMeta,
        whatsappSent.isAcceptableOrUnknown(
          data['whatsapp_sent']!,
          _whatsappSentMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('woo_status')) {
      context.handle(
        _wooStatusMeta,
        wooStatus.isAcceptableOrUnknown(data['woo_status']!, _wooStatusMeta),
      );
    }
    if (data.containsKey('short_description')) {
      context.handle(
        _shortDescriptionMeta,
        shortDescription.isAcceptableOrUnknown(
          data['short_description']!,
          _shortDescriptionMeta,
        ),
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
    if (data.containsKey('searchable_name')) {
      context.handle(
        _searchableNameMeta,
        searchableName.isAcceptableOrUnknown(
          data['searchable_name']!,
          _searchableNameMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_from')) {
      context.handle(
        _lastSyncedFromMeta,
        lastSyncedFrom.isAcceptableOrUnknown(
          data['last_synced_from']!,
          _lastSyncedFromMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      wooId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}woo_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      ),
      installerPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}installer_price'],
      ),
      wholesalePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wholesale_price'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      ),
      lowThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}low_threshold'],
      ),
      whatsappSent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}whatsapp_sent'],
      ),
      categories: $ProductsTable.$convertercategoriesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}categories'],
        ),
      ),
      imageUrls: $ProductsTable.$converterimageUrlsn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}image_urls'],
        ),
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      wooStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}woo_status'],
      ),
      locations: $ProductsTable.$converterlocationsn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}locations'],
        ),
      ),
      shortDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_description'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      searchableName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}searchable_name'],
      ),
      lastSyncedFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_from'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertercategories =
      const ListOfStringConverter();
  static TypeConverter<List<String>?, String?> $convertercategoriesn =
      NullAwareTypeConverter.wrap($convertercategories);
  static TypeConverter<List<String>, String> $converterimageUrls =
      const ListOfStringConverter();
  static TypeConverter<List<String>?, String?> $converterimageUrlsn =
      NullAwareTypeConverter.wrap($converterimageUrls);
  static TypeConverter<List<String>, String> $converterlocations =
      const ListOfStringConverter();
  static TypeConverter<List<String>?, String?> $converterlocationsn =
      NullAwareTypeConverter.wrap($converterlocations);
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final int? wooId;
  final String name;
  final String? sku;
  final double? price;
  final double? installerPrice;
  final double? wholesalePrice;
  final int? quantity;
  final int? lowThreshold;
  final bool? whatsappSent;
  final List<String>? categories;
  final List<String>? imageUrls;
  final String? createdAt;
  final String? updatedAt;
  final String? userId;
  final String? wooStatus;
  final List<String>? locations;
  final String? shortDescription;
  final String? description;
  final String? searchableName;
  final String? lastSyncedFrom;
  const Product({
    required this.id,
    this.wooId,
    required this.name,
    this.sku,
    this.price,
    this.installerPrice,
    this.wholesalePrice,
    this.quantity,
    this.lowThreshold,
    this.whatsappSent,
    this.categories,
    this.imageUrls,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.wooStatus,
    this.locations,
    this.shortDescription,
    this.description,
    this.searchableName,
    this.lastSyncedFrom,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || wooId != null) {
      map['woo_id'] = Variable<int>(wooId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || installerPrice != null) {
      map['installer_price'] = Variable<double>(installerPrice);
    }
    if (!nullToAbsent || wholesalePrice != null) {
      map['wholesale_price'] = Variable<double>(wholesalePrice);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    if (!nullToAbsent || lowThreshold != null) {
      map['low_threshold'] = Variable<int>(lowThreshold);
    }
    if (!nullToAbsent || whatsappSent != null) {
      map['whatsapp_sent'] = Variable<bool>(whatsappSent);
    }
    if (!nullToAbsent || categories != null) {
      map['categories'] = Variable<String>(
        $ProductsTable.$convertercategoriesn.toSql(categories),
      );
    }
    if (!nullToAbsent || imageUrls != null) {
      map['image_urls'] = Variable<String>(
        $ProductsTable.$converterimageUrlsn.toSql(imageUrls),
      );
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || wooStatus != null) {
      map['woo_status'] = Variable<String>(wooStatus);
    }
    if (!nullToAbsent || locations != null) {
      map['locations'] = Variable<String>(
        $ProductsTable.$converterlocationsn.toSql(locations),
      );
    }
    if (!nullToAbsent || shortDescription != null) {
      map['short_description'] = Variable<String>(shortDescription);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || searchableName != null) {
      map['searchable_name'] = Variable<String>(searchableName);
    }
    if (!nullToAbsent || lastSyncedFrom != null) {
      map['last_synced_from'] = Variable<String>(lastSyncedFrom);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      wooId: wooId == null && nullToAbsent
          ? const Value.absent()
          : Value(wooId),
      name: Value(name),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      installerPrice: installerPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(installerPrice),
      wholesalePrice: wholesalePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(wholesalePrice),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      lowThreshold: lowThreshold == null && nullToAbsent
          ? const Value.absent()
          : Value(lowThreshold),
      whatsappSent: whatsappSent == null && nullToAbsent
          ? const Value.absent()
          : Value(whatsappSent),
      categories: categories == null && nullToAbsent
          ? const Value.absent()
          : Value(categories),
      imageUrls: imageUrls == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrls),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      wooStatus: wooStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(wooStatus),
      locations: locations == null && nullToAbsent
          ? const Value.absent()
          : Value(locations),
      shortDescription: shortDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(shortDescription),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      searchableName: searchableName == null && nullToAbsent
          ? const Value.absent()
          : Value(searchableName),
      lastSyncedFrom: lastSyncedFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedFrom),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      wooId: serializer.fromJson<int?>(json['wooId']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String?>(json['sku']),
      price: serializer.fromJson<double?>(json['price']),
      installerPrice: serializer.fromJson<double?>(json['installerPrice']),
      wholesalePrice: serializer.fromJson<double?>(json['wholesalePrice']),
      quantity: serializer.fromJson<int?>(json['quantity']),
      lowThreshold: serializer.fromJson<int?>(json['lowThreshold']),
      whatsappSent: serializer.fromJson<bool?>(json['whatsappSent']),
      categories: serializer.fromJson<List<String>?>(json['categories']),
      imageUrls: serializer.fromJson<List<String>?>(json['imageUrls']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      userId: serializer.fromJson<String?>(json['userId']),
      wooStatus: serializer.fromJson<String?>(json['wooStatus']),
      locations: serializer.fromJson<List<String>?>(json['locations']),
      shortDescription: serializer.fromJson<String?>(json['shortDescription']),
      description: serializer.fromJson<String?>(json['description']),
      searchableName: serializer.fromJson<String?>(json['searchableName']),
      lastSyncedFrom: serializer.fromJson<String?>(json['lastSyncedFrom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'wooId': serializer.toJson<int?>(wooId),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String?>(sku),
      'price': serializer.toJson<double?>(price),
      'installerPrice': serializer.toJson<double?>(installerPrice),
      'wholesalePrice': serializer.toJson<double?>(wholesalePrice),
      'quantity': serializer.toJson<int?>(quantity),
      'lowThreshold': serializer.toJson<int?>(lowThreshold),
      'whatsappSent': serializer.toJson<bool?>(whatsappSent),
      'categories': serializer.toJson<List<String>?>(categories),
      'imageUrls': serializer.toJson<List<String>?>(imageUrls),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'userId': serializer.toJson<String?>(userId),
      'wooStatus': serializer.toJson<String?>(wooStatus),
      'locations': serializer.toJson<List<String>?>(locations),
      'shortDescription': serializer.toJson<String?>(shortDescription),
      'description': serializer.toJson<String?>(description),
      'searchableName': serializer.toJson<String?>(searchableName),
      'lastSyncedFrom': serializer.toJson<String?>(lastSyncedFrom),
    };
  }

  Product copyWith({
    String? id,
    Value<int?> wooId = const Value.absent(),
    String? name,
    Value<String?> sku = const Value.absent(),
    Value<double?> price = const Value.absent(),
    Value<double?> installerPrice = const Value.absent(),
    Value<double?> wholesalePrice = const Value.absent(),
    Value<int?> quantity = const Value.absent(),
    Value<int?> lowThreshold = const Value.absent(),
    Value<bool?> whatsappSent = const Value.absent(),
    Value<List<String>?> categories = const Value.absent(),
    Value<List<String>?> imageUrls = const Value.absent(),
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
    Value<String?> userId = const Value.absent(),
    Value<String?> wooStatus = const Value.absent(),
    Value<List<String>?> locations = const Value.absent(),
    Value<String?> shortDescription = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> searchableName = const Value.absent(),
    Value<String?> lastSyncedFrom = const Value.absent(),
  }) => Product(
    id: id ?? this.id,
    wooId: wooId.present ? wooId.value : this.wooId,
    name: name ?? this.name,
    sku: sku.present ? sku.value : this.sku,
    price: price.present ? price.value : this.price,
    installerPrice: installerPrice.present
        ? installerPrice.value
        : this.installerPrice,
    wholesalePrice: wholesalePrice.present
        ? wholesalePrice.value
        : this.wholesalePrice,
    quantity: quantity.present ? quantity.value : this.quantity,
    lowThreshold: lowThreshold.present ? lowThreshold.value : this.lowThreshold,
    whatsappSent: whatsappSent.present ? whatsappSent.value : this.whatsappSent,
    categories: categories.present ? categories.value : this.categories,
    imageUrls: imageUrls.present ? imageUrls.value : this.imageUrls,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    userId: userId.present ? userId.value : this.userId,
    wooStatus: wooStatus.present ? wooStatus.value : this.wooStatus,
    locations: locations.present ? locations.value : this.locations,
    shortDescription: shortDescription.present
        ? shortDescription.value
        : this.shortDescription,
    description: description.present ? description.value : this.description,
    searchableName: searchableName.present
        ? searchableName.value
        : this.searchableName,
    lastSyncedFrom: lastSyncedFrom.present
        ? lastSyncedFrom.value
        : this.lastSyncedFrom,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      wooId: data.wooId.present ? data.wooId.value : this.wooId,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      price: data.price.present ? data.price.value : this.price,
      installerPrice: data.installerPrice.present
          ? data.installerPrice.value
          : this.installerPrice,
      wholesalePrice: data.wholesalePrice.present
          ? data.wholesalePrice.value
          : this.wholesalePrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      lowThreshold: data.lowThreshold.present
          ? data.lowThreshold.value
          : this.lowThreshold,
      whatsappSent: data.whatsappSent.present
          ? data.whatsappSent.value
          : this.whatsappSent,
      categories: data.categories.present
          ? data.categories.value
          : this.categories,
      imageUrls: data.imageUrls.present ? data.imageUrls.value : this.imageUrls,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userId: data.userId.present ? data.userId.value : this.userId,
      wooStatus: data.wooStatus.present ? data.wooStatus.value : this.wooStatus,
      locations: data.locations.present ? data.locations.value : this.locations,
      shortDescription: data.shortDescription.present
          ? data.shortDescription.value
          : this.shortDescription,
      description: data.description.present
          ? data.description.value
          : this.description,
      searchableName: data.searchableName.present
          ? data.searchableName.value
          : this.searchableName,
      lastSyncedFrom: data.lastSyncedFrom.present
          ? data.lastSyncedFrom.value
          : this.lastSyncedFrom,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('wooId: $wooId, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('price: $price, ')
          ..write('installerPrice: $installerPrice, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('quantity: $quantity, ')
          ..write('lowThreshold: $lowThreshold, ')
          ..write('whatsappSent: $whatsappSent, ')
          ..write('categories: $categories, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('wooStatus: $wooStatus, ')
          ..write('locations: $locations, ')
          ..write('shortDescription: $shortDescription, ')
          ..write('description: $description, ')
          ..write('searchableName: $searchableName, ')
          ..write('lastSyncedFrom: $lastSyncedFrom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    wooId,
    name,
    sku,
    price,
    installerPrice,
    wholesalePrice,
    quantity,
    lowThreshold,
    whatsappSent,
    categories,
    imageUrls,
    createdAt,
    updatedAt,
    userId,
    wooStatus,
    locations,
    shortDescription,
    description,
    searchableName,
    lastSyncedFrom,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.wooId == this.wooId &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.price == this.price &&
          other.installerPrice == this.installerPrice &&
          other.wholesalePrice == this.wholesalePrice &&
          other.quantity == this.quantity &&
          other.lowThreshold == this.lowThreshold &&
          other.whatsappSent == this.whatsappSent &&
          other.categories == this.categories &&
          other.imageUrls == this.imageUrls &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userId == this.userId &&
          other.wooStatus == this.wooStatus &&
          other.locations == this.locations &&
          other.shortDescription == this.shortDescription &&
          other.description == this.description &&
          other.searchableName == this.searchableName &&
          other.lastSyncedFrom == this.lastSyncedFrom);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<int?> wooId;
  final Value<String> name;
  final Value<String?> sku;
  final Value<double?> price;
  final Value<double?> installerPrice;
  final Value<double?> wholesalePrice;
  final Value<int?> quantity;
  final Value<int?> lowThreshold;
  final Value<bool?> whatsappSent;
  final Value<List<String>?> categories;
  final Value<List<String>?> imageUrls;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<String?> userId;
  final Value<String?> wooStatus;
  final Value<List<String>?> locations;
  final Value<String?> shortDescription;
  final Value<String?> description;
  final Value<String?> searchableName;
  final Value<String?> lastSyncedFrom;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.wooId = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.price = const Value.absent(),
    this.installerPrice = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.lowThreshold = const Value.absent(),
    this.whatsappSent = const Value.absent(),
    this.categories = const Value.absent(),
    this.imageUrls = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.wooStatus = const Value.absent(),
    this.locations = const Value.absent(),
    this.shortDescription = const Value.absent(),
    this.description = const Value.absent(),
    this.searchableName = const Value.absent(),
    this.lastSyncedFrom = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    this.wooId = const Value.absent(),
    required String name,
    this.sku = const Value.absent(),
    this.price = const Value.absent(),
    this.installerPrice = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.lowThreshold = const Value.absent(),
    this.whatsappSent = const Value.absent(),
    this.categories = const Value.absent(),
    this.imageUrls = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.wooStatus = const Value.absent(),
    this.locations = const Value.absent(),
    this.shortDescription = const Value.absent(),
    this.description = const Value.absent(),
    this.searchableName = const Value.absent(),
    this.lastSyncedFrom = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<int>? wooId,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<double>? price,
    Expression<double>? installerPrice,
    Expression<double>? wholesalePrice,
    Expression<int>? quantity,
    Expression<int>? lowThreshold,
    Expression<bool>? whatsappSent,
    Expression<String>? categories,
    Expression<String>? imageUrls,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? userId,
    Expression<String>? wooStatus,
    Expression<String>? locations,
    Expression<String>? shortDescription,
    Expression<String>? description,
    Expression<String>? searchableName,
    Expression<String>? lastSyncedFrom,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wooId != null) 'woo_id': wooId,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (price != null) 'price': price,
      if (installerPrice != null) 'installer_price': installerPrice,
      if (wholesalePrice != null) 'wholesale_price': wholesalePrice,
      if (quantity != null) 'quantity': quantity,
      if (lowThreshold != null) 'low_threshold': lowThreshold,
      if (whatsappSent != null) 'whatsapp_sent': whatsappSent,
      if (categories != null) 'categories': categories,
      if (imageUrls != null) 'image_urls': imageUrls,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (wooStatus != null) 'woo_status': wooStatus,
      if (locations != null) 'locations': locations,
      if (shortDescription != null) 'short_description': shortDescription,
      if (description != null) 'description': description,
      if (searchableName != null) 'searchable_name': searchableName,
      if (lastSyncedFrom != null) 'last_synced_from': lastSyncedFrom,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<int?>? wooId,
    Value<String>? name,
    Value<String?>? sku,
    Value<double?>? price,
    Value<double?>? installerPrice,
    Value<double?>? wholesalePrice,
    Value<int?>? quantity,
    Value<int?>? lowThreshold,
    Value<bool?>? whatsappSent,
    Value<List<String>?>? categories,
    Value<List<String>?>? imageUrls,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<String?>? userId,
    Value<String?>? wooStatus,
    Value<List<String>?>? locations,
    Value<String?>? shortDescription,
    Value<String?>? description,
    Value<String?>? searchableName,
    Value<String?>? lastSyncedFrom,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      wooId: wooId ?? this.wooId,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      installerPrice: installerPrice ?? this.installerPrice,
      wholesalePrice: wholesalePrice ?? this.wholesalePrice,
      quantity: quantity ?? this.quantity,
      lowThreshold: lowThreshold ?? this.lowThreshold,
      whatsappSent: whatsappSent ?? this.whatsappSent,
      categories: categories ?? this.categories,
      imageUrls: imageUrls ?? this.imageUrls,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      wooStatus: wooStatus ?? this.wooStatus,
      locations: locations ?? this.locations,
      shortDescription: shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      searchableName: searchableName ?? this.searchableName,
      lastSyncedFrom: lastSyncedFrom ?? this.lastSyncedFrom,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wooId.present) {
      map['woo_id'] = Variable<int>(wooId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (installerPrice.present) {
      map['installer_price'] = Variable<double>(installerPrice.value);
    }
    if (wholesalePrice.present) {
      map['wholesale_price'] = Variable<double>(wholesalePrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (lowThreshold.present) {
      map['low_threshold'] = Variable<int>(lowThreshold.value);
    }
    if (whatsappSent.present) {
      map['whatsapp_sent'] = Variable<bool>(whatsappSent.value);
    }
    if (categories.present) {
      map['categories'] = Variable<String>(
        $ProductsTable.$convertercategoriesn.toSql(categories.value),
      );
    }
    if (imageUrls.present) {
      map['image_urls'] = Variable<String>(
        $ProductsTable.$converterimageUrlsn.toSql(imageUrls.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (wooStatus.present) {
      map['woo_status'] = Variable<String>(wooStatus.value);
    }
    if (locations.present) {
      map['locations'] = Variable<String>(
        $ProductsTable.$converterlocationsn.toSql(locations.value),
      );
    }
    if (shortDescription.present) {
      map['short_description'] = Variable<String>(shortDescription.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (searchableName.present) {
      map['searchable_name'] = Variable<String>(searchableName.value);
    }
    if (lastSyncedFrom.present) {
      map['last_synced_from'] = Variable<String>(lastSyncedFrom.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('wooId: $wooId, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('price: $price, ')
          ..write('installerPrice: $installerPrice, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('quantity: $quantity, ')
          ..write('lowThreshold: $lowThreshold, ')
          ..write('whatsappSent: $whatsappSent, ')
          ..write('categories: $categories, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('wooStatus: $wooStatus, ')
          ..write('locations: $locations, ')
          ..write('shortDescription: $shortDescription, ')
          ..write('description: $description, ')
          ..write('searchableName: $searchableName, ')
          ..write('lastSyncedFrom: $lastSyncedFrom, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KeyValueStoreTable extends KeyValueStore
    with TableInfo<$KeyValueStoreTable, KeyValueStoreEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValueStoreTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'key_value_store';
  @override
  VerificationContext validateIntegrity(
    Insertable<KeyValueStoreEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  KeyValueStoreEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValueStoreEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $KeyValueStoreTable createAlias(String alias) {
    return $KeyValueStoreTable(attachedDatabase, alias);
  }
}

class KeyValueStoreEntry extends DataClass
    implements Insertable<KeyValueStoreEntry> {
  final String key;
  final String value;
  const KeyValueStoreEntry({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  KeyValueStoreCompanion toCompanion(bool nullToAbsent) {
    return KeyValueStoreCompanion(key: Value(key), value: Value(value));
  }

  factory KeyValueStoreEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValueStoreEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  KeyValueStoreEntry copyWith({String? key, String? value}) =>
      KeyValueStoreEntry(key: key ?? this.key, value: value ?? this.value);
  KeyValueStoreEntry copyWithCompanion(KeyValueStoreCompanion data) {
    return KeyValueStoreEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueStoreEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyValueStoreEntry &&
          other.key == this.key &&
          other.value == this.value);
}

class KeyValueStoreCompanion extends UpdateCompanion<KeyValueStoreEntry> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const KeyValueStoreCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValueStoreCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<KeyValueStoreEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeyValueStoreCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return KeyValueStoreCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueStoreCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wcLocationIdMeta = const VerificationMeta(
    'wcLocationId',
  );
  @override
  late final GeneratedColumn<String> wcLocationId = GeneratedColumn<String>(
    'wc_location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    wcLocationId,
    name,
    slug,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Location> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('wc_location_id')) {
      context.handle(
        _wcLocationIdMeta,
        wcLocationId.isAcceptableOrUnknown(
          data['wc_location_id']!,
          _wcLocationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wcLocationIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      wcLocationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wc_location_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final String wcLocationId;
  final String name;
  final String slug;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  const Location({
    required this.wcLocationId,
    required this.name,
    required this.slug,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['wc_location_id'] = Variable<String>(wcLocationId);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      wcLocationId: Value(wcLocationId),
      name: Value(name),
      slug: Value(slug),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Location.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      wcLocationId: serializer.fromJson<String>(json['wcLocationId']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wcLocationId': serializer.toJson<String>(wcLocationId),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Location copyWith({
    String? wcLocationId,
    String? name,
    String? slug,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) => Location(
    wcLocationId: wcLocationId ?? this.wcLocationId,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      wcLocationId: data.wcLocationId.present
          ? data.wcLocationId.value
          : this.wcLocationId,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('wcLocationId: $wcLocationId, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(wcLocationId, name, slug, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.wcLocationId == this.wcLocationId &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<String> wcLocationId;
  final Value<String> name;
  final Value<String> slug;
  final Value<bool> isActive;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const LocationsCompanion({
    this.wcLocationId = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    required String wcLocationId,
    required String name,
    required String slug,
    required bool isActive,
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : wcLocationId = Value(wcLocationId),
       name = Value(name),
       slug = Value(slug),
       isActive = Value(isActive),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Location> custom({
    Expression<String>? wcLocationId,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<bool>? isActive,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wcLocationId != null) 'wc_location_id': wcLocationId,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith({
    Value<String>? wcLocationId,
    Value<String>? name,
    Value<String>? slug,
    Value<bool>? isActive,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocationsCompanion(
      wcLocationId: wcLocationId ?? this.wcLocationId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wcLocationId.present) {
      map['wc_location_id'] = Variable<String>(wcLocationId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('wcLocationId: $wcLocationId, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductImageThumbnailsTable extends ProductImageThumbnails
    with TableInfo<$ProductImageThumbnailsTable, ProductImageThumbnail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductImageThumbnailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  static const VerificationMeta _thumbnailMeta = const VerificationMeta(
    'thumbnail',
  );
  @override
  late final GeneratedColumn<Uint8List> thumbnail = GeneratedColumn<Uint8List>(
    'thumbnail',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [imageUrl, productId, thumbnail];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_image_thumbnails';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductImageThumbnail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(
        _thumbnailMeta,
        thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta),
      );
    } else if (isInserting) {
      context.missing(_thumbnailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {imageUrl};
  @override
  ProductImageThumbnail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductImageThumbnail(
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      thumbnail: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}thumbnail'],
      )!,
    );
  }

  @override
  $ProductImageThumbnailsTable createAlias(String alias) {
    return $ProductImageThumbnailsTable(attachedDatabase, alias);
  }
}

class ProductImageThumbnail extends DataClass
    implements Insertable<ProductImageThumbnail> {
  final String imageUrl;
  final String productId;
  final Uint8List thumbnail;
  const ProductImageThumbnail({
    required this.imageUrl,
    required this.productId,
    required this.thumbnail,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['image_url'] = Variable<String>(imageUrl);
    map['product_id'] = Variable<String>(productId);
    map['thumbnail'] = Variable<Uint8List>(thumbnail);
    return map;
  }

  ProductImageThumbnailsCompanion toCompanion(bool nullToAbsent) {
    return ProductImageThumbnailsCompanion(
      imageUrl: Value(imageUrl),
      productId: Value(productId),
      thumbnail: Value(thumbnail),
    );
  }

  factory ProductImageThumbnail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductImageThumbnail(
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      productId: serializer.fromJson<String>(json['productId']),
      thumbnail: serializer.fromJson<Uint8List>(json['thumbnail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'imageUrl': serializer.toJson<String>(imageUrl),
      'productId': serializer.toJson<String>(productId),
      'thumbnail': serializer.toJson<Uint8List>(thumbnail),
    };
  }

  ProductImageThumbnail copyWith({
    String? imageUrl,
    String? productId,
    Uint8List? thumbnail,
  }) => ProductImageThumbnail(
    imageUrl: imageUrl ?? this.imageUrl,
    productId: productId ?? this.productId,
    thumbnail: thumbnail ?? this.thumbnail,
  );
  ProductImageThumbnail copyWithCompanion(
    ProductImageThumbnailsCompanion data,
  ) {
    return ProductImageThumbnail(
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      productId: data.productId.present ? data.productId.value : this.productId,
      thumbnail: data.thumbnail.present ? data.thumbnail.value : this.thumbnail,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductImageThumbnail(')
          ..write('imageUrl: $imageUrl, ')
          ..write('productId: $productId, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(imageUrl, productId, $driftBlobEquality.hash(thumbnail));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductImageThumbnail &&
          other.imageUrl == this.imageUrl &&
          other.productId == this.productId &&
          $driftBlobEquality.equals(other.thumbnail, this.thumbnail));
}

class ProductImageThumbnailsCompanion
    extends UpdateCompanion<ProductImageThumbnail> {
  final Value<String> imageUrl;
  final Value<String> productId;
  final Value<Uint8List> thumbnail;
  final Value<int> rowid;
  const ProductImageThumbnailsCompanion({
    this.imageUrl = const Value.absent(),
    this.productId = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductImageThumbnailsCompanion.insert({
    required String imageUrl,
    required String productId,
    required Uint8List thumbnail,
    this.rowid = const Value.absent(),
  }) : imageUrl = Value(imageUrl),
       productId = Value(productId),
       thumbnail = Value(thumbnail);
  static Insertable<ProductImageThumbnail> custom({
    Expression<String>? imageUrl,
    Expression<String>? productId,
    Expression<Uint8List>? thumbnail,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (imageUrl != null) 'image_url': imageUrl,
      if (productId != null) 'product_id': productId,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductImageThumbnailsCompanion copyWith({
    Value<String>? imageUrl,
    Value<String>? productId,
    Value<Uint8List>? thumbnail,
    Value<int>? rowid,
  }) {
    return ProductImageThumbnailsCompanion(
      imageUrl: imageUrl ?? this.imageUrl,
      productId: productId ?? this.productId,
      thumbnail: thumbnail ?? this.thumbnail,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<Uint8List>(thumbnail.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductImageThumbnailsCompanion(')
          ..write('imageUrl: $imageUrl, ')
          ..write('productId: $productId, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $KeyValueStoreTable keyValueStore = $KeyValueStoreTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $ProductImageThumbnailsTable productImageThumbnails =
      $ProductImageThumbnailsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    keyValueStore,
    locations,
    productImageThumbnails,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String id,
      Value<int?> wooId,
      required String name,
      Value<String?> sku,
      Value<double?> price,
      Value<double?> installerPrice,
      Value<double?> wholesalePrice,
      Value<int?> quantity,
      Value<int?> lowThreshold,
      Value<bool?> whatsappSent,
      Value<List<String>?> categories,
      Value<List<String>?> imageUrls,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<String?> userId,
      Value<String?> wooStatus,
      Value<List<String>?> locations,
      Value<String?> shortDescription,
      Value<String?> description,
      Value<String?> searchableName,
      Value<String?> lastSyncedFrom,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<int?> wooId,
      Value<String> name,
      Value<String?> sku,
      Value<double?> price,
      Value<double?> installerPrice,
      Value<double?> wholesalePrice,
      Value<int?> quantity,
      Value<int?> lowThreshold,
      Value<bool?> whatsappSent,
      Value<List<String>?> categories,
      Value<List<String>?> imageUrls,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<String?> userId,
      Value<String?> wooStatus,
      Value<List<String>?> locations,
      Value<String?> shortDescription,
      Value<String?> description,
      Value<String?> searchableName,
      Value<String?> lastSyncedFrom,
      Value<int> rowid,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wooId => $composableBuilder(
    column: $table.wooId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get installerPrice => $composableBuilder(
    column: $table.installerPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lowThreshold => $composableBuilder(
    column: $table.lowThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get whatsappSent => $composableBuilder(
    column: $table.whatsappSent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get imageUrls => $composableBuilder(
    column: $table.imageUrls,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wooStatus => $composableBuilder(
    column: $table.wooStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get locations => $composableBuilder(
    column: $table.locations,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get shortDescription => $composableBuilder(
    column: $table.shortDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchableName => $composableBuilder(
    column: $table.searchableName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedFrom => $composableBuilder(
    column: $table.lastSyncedFrom,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wooId => $composableBuilder(
    column: $table.wooId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get installerPrice => $composableBuilder(
    column: $table.installerPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lowThreshold => $composableBuilder(
    column: $table.lowThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get whatsappSent => $composableBuilder(
    column: $table.whatsappSent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrls => $composableBuilder(
    column: $table.imageUrls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wooStatus => $composableBuilder(
    column: $table.wooStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locations => $composableBuilder(
    column: $table.locations,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortDescription => $composableBuilder(
    column: $table.shortDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchableName => $composableBuilder(
    column: $table.searchableName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedFrom => $composableBuilder(
    column: $table.lastSyncedFrom,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get wooId =>
      $composableBuilder(column: $table.wooId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get installerPrice => $composableBuilder(
    column: $table.installerPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get lowThreshold => $composableBuilder(
    column: $table.lowThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get whatsappSent => $composableBuilder(
    column: $table.whatsappSent,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>?, String> get categories =>
      $composableBuilder(
        column: $table.categories,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<String>?, String> get imageUrls =>
      $composableBuilder(column: $table.imageUrls, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get wooStatus =>
      $composableBuilder(column: $table.wooStatus, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get locations =>
      $composableBuilder(column: $table.locations, builder: (column) => column);

  GeneratedColumn<String> get shortDescription => $composableBuilder(
    column: $table.shortDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchableName => $composableBuilder(
    column: $table.searchableName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedFrom => $composableBuilder(
    column: $table.lastSyncedFrom,
    builder: (column) => column,
  );
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int?> wooId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<double?> installerPrice = const Value.absent(),
                Value<double?> wholesalePrice = const Value.absent(),
                Value<int?> quantity = const Value.absent(),
                Value<int?> lowThreshold = const Value.absent(),
                Value<bool?> whatsappSent = const Value.absent(),
                Value<List<String>?> categories = const Value.absent(),
                Value<List<String>?> imageUrls = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> wooStatus = const Value.absent(),
                Value<List<String>?> locations = const Value.absent(),
                Value<String?> shortDescription = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> searchableName = const Value.absent(),
                Value<String?> lastSyncedFrom = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                wooId: wooId,
                name: name,
                sku: sku,
                price: price,
                installerPrice: installerPrice,
                wholesalePrice: wholesalePrice,
                quantity: quantity,
                lowThreshold: lowThreshold,
                whatsappSent: whatsappSent,
                categories: categories,
                imageUrls: imageUrls,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userId: userId,
                wooStatus: wooStatus,
                locations: locations,
                shortDescription: shortDescription,
                description: description,
                searchableName: searchableName,
                lastSyncedFrom: lastSyncedFrom,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int?> wooId = const Value.absent(),
                required String name,
                Value<String?> sku = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<double?> installerPrice = const Value.absent(),
                Value<double?> wholesalePrice = const Value.absent(),
                Value<int?> quantity = const Value.absent(),
                Value<int?> lowThreshold = const Value.absent(),
                Value<bool?> whatsappSent = const Value.absent(),
                Value<List<String>?> categories = const Value.absent(),
                Value<List<String>?> imageUrls = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> wooStatus = const Value.absent(),
                Value<List<String>?> locations = const Value.absent(),
                Value<String?> shortDescription = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> searchableName = const Value.absent(),
                Value<String?> lastSyncedFrom = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                wooId: wooId,
                name: name,
                sku: sku,
                price: price,
                installerPrice: installerPrice,
                wholesalePrice: wholesalePrice,
                quantity: quantity,
                lowThreshold: lowThreshold,
                whatsappSent: whatsappSent,
                categories: categories,
                imageUrls: imageUrls,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userId: userId,
                wooStatus: wooStatus,
                locations: locations,
                shortDescription: shortDescription,
                description: description,
                searchableName: searchableName,
                lastSyncedFrom: lastSyncedFrom,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;
typedef $$KeyValueStoreTableCreateCompanionBuilder =
    KeyValueStoreCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$KeyValueStoreTableUpdateCompanionBuilder =
    KeyValueStoreCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$KeyValueStoreTableFilterComposer
    extends Composer<_$AppDatabase, $KeyValueStoreTable> {
  $$KeyValueStoreTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KeyValueStoreTableOrderingComposer
    extends Composer<_$AppDatabase, $KeyValueStoreTable> {
  $$KeyValueStoreTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KeyValueStoreTableAnnotationComposer
    extends Composer<_$AppDatabase, $KeyValueStoreTable> {
  $$KeyValueStoreTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$KeyValueStoreTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KeyValueStoreTable,
          KeyValueStoreEntry,
          $$KeyValueStoreTableFilterComposer,
          $$KeyValueStoreTableOrderingComposer,
          $$KeyValueStoreTableAnnotationComposer,
          $$KeyValueStoreTableCreateCompanionBuilder,
          $$KeyValueStoreTableUpdateCompanionBuilder,
          (
            KeyValueStoreEntry,
            BaseReferences<
              _$AppDatabase,
              $KeyValueStoreTable,
              KeyValueStoreEntry
            >,
          ),
          KeyValueStoreEntry,
          PrefetchHooks Function()
        > {
  $$KeyValueStoreTableTableManager(_$AppDatabase db, $KeyValueStoreTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeyValueStoreTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeyValueStoreTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeyValueStoreTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  KeyValueStoreCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => KeyValueStoreCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KeyValueStoreTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KeyValueStoreTable,
      KeyValueStoreEntry,
      $$KeyValueStoreTableFilterComposer,
      $$KeyValueStoreTableOrderingComposer,
      $$KeyValueStoreTableAnnotationComposer,
      $$KeyValueStoreTableCreateCompanionBuilder,
      $$KeyValueStoreTableUpdateCompanionBuilder,
      (
        KeyValueStoreEntry,
        BaseReferences<_$AppDatabase, $KeyValueStoreTable, KeyValueStoreEntry>,
      ),
      KeyValueStoreEntry,
      PrefetchHooks Function()
    >;
typedef $$LocationsTableCreateCompanionBuilder =
    LocationsCompanion Function({
      required String wcLocationId,
      required String name,
      required String slug,
      required bool isActive,
      required String createdAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$LocationsTableUpdateCompanionBuilder =
    LocationsCompanion Function({
      Value<String> wcLocationId,
      Value<String> name,
      Value<String> slug,
      Value<bool> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> rowid,
    });

class $$LocationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get wcLocationId => $composableBuilder(
    column: $table.wcLocationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get wcLocationId => $composableBuilder(
    column: $table.wcLocationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get wcLocationId => $composableBuilder(
    column: $table.wcLocationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationsTable,
          Location,
          $$LocationsTableFilterComposer,
          $$LocationsTableOrderingComposer,
          $$LocationsTableAnnotationComposer,
          $$LocationsTableCreateCompanionBuilder,
          $$LocationsTableUpdateCompanionBuilder,
          (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
          Location,
          PrefetchHooks Function()
        > {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> wcLocationId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion(
                wcLocationId: wcLocationId,
                name: name,
                slug: slug,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String wcLocationId,
                required String name,
                required String slug,
                required bool isActive,
                required String createdAt,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion.insert(
                wcLocationId: wcLocationId,
                name: name,
                slug: slug,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationsTable,
      Location,
      $$LocationsTableFilterComposer,
      $$LocationsTableOrderingComposer,
      $$LocationsTableAnnotationComposer,
      $$LocationsTableCreateCompanionBuilder,
      $$LocationsTableUpdateCompanionBuilder,
      (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
      Location,
      PrefetchHooks Function()
    >;
typedef $$ProductImageThumbnailsTableCreateCompanionBuilder =
    ProductImageThumbnailsCompanion Function({
      required String imageUrl,
      required String productId,
      required Uint8List thumbnail,
      Value<int> rowid,
    });
typedef $$ProductImageThumbnailsTableUpdateCompanionBuilder =
    ProductImageThumbnailsCompanion Function({
      Value<String> imageUrl,
      Value<String> productId,
      Value<Uint8List> thumbnail,
      Value<int> rowid,
    });

class $$ProductImageThumbnailsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductImageThumbnailsTable> {
  $$ProductImageThumbnailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductImageThumbnailsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductImageThumbnailsTable> {
  $$ProductImageThumbnailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductImageThumbnailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductImageThumbnailsTable> {
  $$ProductImageThumbnailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<Uint8List> get thumbnail =>
      $composableBuilder(column: $table.thumbnail, builder: (column) => column);
}

class $$ProductImageThumbnailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductImageThumbnailsTable,
          ProductImageThumbnail,
          $$ProductImageThumbnailsTableFilterComposer,
          $$ProductImageThumbnailsTableOrderingComposer,
          $$ProductImageThumbnailsTableAnnotationComposer,
          $$ProductImageThumbnailsTableCreateCompanionBuilder,
          $$ProductImageThumbnailsTableUpdateCompanionBuilder,
          (
            ProductImageThumbnail,
            BaseReferences<
              _$AppDatabase,
              $ProductImageThumbnailsTable,
              ProductImageThumbnail
            >,
          ),
          ProductImageThumbnail,
          PrefetchHooks Function()
        > {
  $$ProductImageThumbnailsTableTableManager(
    _$AppDatabase db,
    $ProductImageThumbnailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductImageThumbnailsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ProductImageThumbnailsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProductImageThumbnailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> imageUrl = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<Uint8List> thumbnail = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductImageThumbnailsCompanion(
                imageUrl: imageUrl,
                productId: productId,
                thumbnail: thumbnail,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String imageUrl,
                required String productId,
                required Uint8List thumbnail,
                Value<int> rowid = const Value.absent(),
              }) => ProductImageThumbnailsCompanion.insert(
                imageUrl: imageUrl,
                productId: productId,
                thumbnail: thumbnail,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductImageThumbnailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductImageThumbnailsTable,
      ProductImageThumbnail,
      $$ProductImageThumbnailsTableFilterComposer,
      $$ProductImageThumbnailsTableOrderingComposer,
      $$ProductImageThumbnailsTableAnnotationComposer,
      $$ProductImageThumbnailsTableCreateCompanionBuilder,
      $$ProductImageThumbnailsTableUpdateCompanionBuilder,
      (
        ProductImageThumbnail,
        BaseReferences<
          _$AppDatabase,
          $ProductImageThumbnailsTable,
          ProductImageThumbnail
        >,
      ),
      ProductImageThumbnail,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$KeyValueStoreTableTableManager get keyValueStore =>
      $$KeyValueStoreTableTableManager(_db, _db.keyValueStore);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$ProductImageThumbnailsTableTableManager get productImageThumbnails =>
      $$ProductImageThumbnailsTableTableManager(
        _db,
        _db.productImageThumbnails,
      );
}
