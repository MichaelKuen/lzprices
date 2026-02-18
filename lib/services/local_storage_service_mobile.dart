import 'dart:typed_data';
import 'package:drift/drift.dart';
import 'package:lzprices/models/location.dart' as loc_model;
import 'package:lzprices/models/product.dart' as prod_model;
import 'package:lzprices/drift_database.dart';
import 'dart:convert';

import 'package:lzprices/services/local_storage_service.dart';

const String _lastSyncKey = 'last_sync_time';

class LocalStorageServiceMobile implements LocalStorageService {
  final AppDatabase _db;

  LocalStorageServiceMobile() : _db = db;

  @override
  Future<void> saveProducts(List<prod_model.Product> products) async {
    await _db.batch((batch) {
      batch.insertAll(
        _db.products,
        products.map((p) => _toDriftProduct(p)),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> saveProduct(prod_model.Product product) async {
    await _db
        .into(_db.products)
        .insert(_toDriftProduct(product), mode: InsertMode.insertOrReplace);
  }

  @override
  Future<List<prod_model.Product>> getAllProducts() async {
    final productEntries = await _db.select(_db.products).get();
    return productEntries.map((entry) => _fromDriftProduct(entry)).toList();
  }

  @override
  Future<List<prod_model.Product>> searchProducts(String searchTerm,
      {List<String>? categories}) async {
    final hasSearchTerm = searchTerm.trim().isNotEmpty;
    final hasCategories = categories != null && categories.isNotEmpty;

    if (!hasSearchTerm && !hasCategories) {
      return [];
    }

    var query = _db.select(_db.products);

    if (hasSearchTerm) {
      final searchTerms = searchTerm
          .toLowerCase()
          .split(' ')
          .where((t) => t.isNotEmpty)
          .toList();
      for (final term in searchTerms) {
        query.where((p) =>
            p.name.lower().like('%$term%') |
            p.searchableName.lower().like('%$term%') |
            p.sku.lower().like('%$term%'));
      }
    }

    if (hasCategories) {
      Expression<bool> categoryExpression = const Constant(false);
      for (final category in categories) {
        categoryExpression =
            categoryExpression | _db.products.categories.like('%$category%');
      }
      query.where((_) => categoryExpression);
    }

    final productEntries = await query.get();
    return productEntries.map((entry) => _fromDriftProduct(entry)).toList();
  }

  @override
  Future<prod_model.Product?> getProductById(String productId) async {
    final query = _db.select(_db.products)
      ..where((p) => p.id.equals(productId));
    final productEntry = await query.getSingleOrNull();
    return productEntry != null ? _fromDriftProduct(productEntry) : null;
  }

  @override
  Future<void> clearAllData() async {
    await _db.transaction(() async {
      await _db.delete(_db.products).go();
      await _db.delete(_db.keyValueStore).go();
      await _db.delete(_db.locations).go();
      await _db.delete(_db.productImageThumbnails).go();
    });
  }

  @override
  Future<DateTime?> getLastSyncTime() async {
    final entry = await (_db.select(_db.keyValueStore)
          ..where((tbl) => tbl.key.equals(_lastSyncKey)))
        .getSingleOrNull();

    if (entry != null) {
      return DateTime.tryParse(entry.value);
    }
    return null;
  }

  @override
  Future<void> setLastSyncTime(DateTime time) async {
    await _db.into(_db.keyValueStore).insert(
        KeyValueStoreCompanion.insert(
          key: _lastSyncKey,
          value: time.toIso8601String(),
        ),
        mode: InsertMode.insertOrReplace);
  }

  @override
  Future<List<String>> getProductImages(String productId) async {
    final entry = await (_db.select(_db.keyValueStore)
          ..where((tbl) => tbl.key.equals('product_images_$productId')))
        .getSingleOrNull();

    if (entry != null) {
      try {
        return (jsonDecode(entry.value) as List).cast<String>();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<void> saveProductImages(String productId, List<String> images) async {
    await _db.into(_db.keyValueStore).insert(
        KeyValueStoreCompanion.insert(
          key: 'product_images_$productId',
          value: jsonEncode(images),
        ),
        mode: InsertMode.insertOrReplace);
  }

  Product _toDriftProduct(prod_model.Product p) {
    return Product(
      id: p.id,
      wooId: p.wooId,
      name: p.name,
      sku: p.sku,
      price: p.price,
      installerPrice: p.installerPrice,
      wholesalePrice: p.wholesalePrice,
      quantity: p.quantity,
      lowThreshold: p.lowThreshold,
      whatsappSent: p.whatsappSent,
      categories: p.categories,
      imageUrls: p.imageUrls,
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
      userId: p.userId,
      wooStatus: p.wooStatus,
      locations: p.locations,
      shortDescription: p.shortDescription,
      description: p.description,
      searchableName: p.searchableName,
      lastSyncedFrom: p.lastSyncedFrom,
    );
  }

  prod_model.Product _fromDriftProduct(Product p) {
    return prod_model.Product(
      id: p.id,
      wooId: p.wooId,
      name: p.name,
      sku: p.sku,
      price: p.price,
      installerPrice: p.installerPrice,
      wholesalePrice: p.wholesalePrice,
      quantity: p.quantity,
      lowThreshold: p.lowThreshold,
      whatsappSent: p.whatsappSent,
      categories: p.categories,
      imageUrls: p.imageUrls,
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
      userId: p.userId,
      wooStatus: p.wooStatus,
      locations: p.locations,
      shortDescription: p.shortDescription,
      description: p.description,
      searchableName: p.searchableName,
      lastSyncedFrom: p.lastSyncedFrom,
    );
  }

  @override
  Future<void> saveLocations(List<loc_model.Location> locations) async {
    await _db.batch((batch) {
      batch.insertAll(
        _db.locations,
        locations.map((l) => _toDriftLocation(l)),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<List<loc_model.Location>> getLocations() async {
    final locationEntries = await _db.select(_db.locations).get();
    return locationEntries.map((entry) => _fromDriftLocation(entry)).toList();
  }

  Location _toDriftLocation(loc_model.Location l) {
    return Location(
      wcLocationId: l.wcLocationId,
      name: l.name,
      slug: l.slug,
      isActive: l.isActive,
      createdAt: l.createdAt.toIso8601String(),
      updatedAt: l.updatedAt.toIso8601String(),
    );
  }

  loc_model.Location _fromDriftLocation(Location l) {
    return loc_model.Location(
      wcLocationId: l.wcLocationId,
      name: l.name,
      slug: l.slug,
      isActive: l.isActive,
      createdAt: DateTime.parse(l.createdAt),
      updatedAt: DateTime.parse(l.updatedAt),
    );
  }

  @override
  Future<void> saveProductImageThumbnail(
      String productId, String imageUrl, Uint8List thumbnail) async {
    await _db.into(_db.productImageThumbnails).insert(
          ProductImageThumbnail(
            productId: productId,
            imageUrl: imageUrl,
            thumbnail: thumbnail,
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Future<Uint8List?> getProductImageThumbnail(String imageUrl) async {
    final query = _db.select(_db.productImageThumbnails)
      ..where((t) => t.imageUrl.equals(imageUrl));
    final result = await query.getSingleOrNull();
    return result?.thumbnail;
  }

  @override
  Future<Map<String, Uint8List>> getProductImageThumbnailsForProduct(
      String productId) async {
    final query = _db.select(_db.productImageThumbnails)
      ..where((t) => t.productId.equals(productId));
    final results = await query.get();
    return {for (var r in results) r.imageUrl: r.thumbnail};
  }

  @override
  Future<void> clearThumbnails() async {
    await _db.delete(_db.productImageThumbnails).go();
  }
}

LocalStorageService getLocalStorageService() => LocalStorageServiceMobile();
