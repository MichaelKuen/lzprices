import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:lzprices/data/tables/key_value_store_table.dart';
import 'package:lzprices/database/unsupported.dart'
    if (dart.library.html) 'package:lzprices/database/web.dart'
    if (dart.library.io) 'package:lzprices/database/native.dart';

part 'drift_database.g.dart';

// This global instance will be initialized in main.dart
late AppDatabase db;

class ListOfStringConverter extends TypeConverter<List<String>, String> {
  const ListOfStringConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    try {
      return (json.decode(fromDb) as List).cast<String>();
    } catch (e) {
      return [];
    }
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

@DataClassName('Product')
class Products extends Table {
  TextColumn get id => text()();
  IntColumn get wooId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get sku => text().nullable()();
  RealColumn get price => real().nullable()();
  RealColumn get installerPrice => real().nullable()();
  RealColumn get wholesalePrice => real().nullable()();
  IntColumn get quantity => integer().nullable()();
  IntColumn get lowThreshold => integer().nullable()();
  BoolColumn get whatsappSent => boolean().nullable()();
  TextColumn get categories =>
      text().map(const ListOfStringConverter()).nullable()();
  TextColumn get imageUrls =>
      text().map(const ListOfStringConverter()).nullable()();
  TextColumn get createdAt => text().nullable()();
  TextColumn get updatedAt => text().nullable()();
  TextColumn get userId => text().nullable()();
  TextColumn get wooStatus => text().nullable()();
  TextColumn get locations =>
      text().map(const ListOfStringConverter()).nullable()();
  TextColumn get shortDescription => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get searchableName => text().nullable()();
  TextColumn get lastSyncedFrom => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Location')
class Locations extends Table {
  TextColumn get wcLocationId => text()();
  TextColumn get name => text()();
  TextColumn get slug => text()();
  BoolColumn get isActive => boolean()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {slug};
}

@DataClassName('ProductImageThumbnail')
class ProductImageThumbnails extends Table {
  TextColumn get imageUrl => text()();
  TextColumn get productId => text()();
  BlobColumn get thumbnail => blob()();

  @override
  Set<Column> get primaryKey => {imageUrl};
}

@DriftDatabase(
    tables: [Products, KeyValueStore, Locations, ProductImageThumbnails])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  // This constructor is for the background isolate.
  AppDatabase.connect(super.connection);

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 5) {
            await m.createTable(allTables
                .firstWhere((t) => t.actualTableName == 'key_value_store'));
          }
          if (from < 6) {
            await m.createTable(
                allTables.firstWhere((t) => t.actualTableName == 'locations'));
          }
          if (from < 7) {
            await m.createTable(productImageThumbnails);
          }
        },
      );
}
