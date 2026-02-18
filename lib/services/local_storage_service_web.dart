import 'dart:typed_data';
import 'package:lzprices/models/location.dart';
import 'package:lzprices/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:lzprices/services/local_storage_service.dart';

class LocalStorageServiceWeb implements LocalStorageService {
  @override
  Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = products.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_productsKey, productsJson);
  }

  @override
  Future<void> saveProduct(Product product) async {
    final products = await getAllProducts();
    final index = products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      products[index] = product;
    } else {
      products.add(product);
    }
    await saveProducts(products);
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getStringList(_productsKey) ?? [];
    return productsJson.map((jsonStr) {
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      return Product.fromJson(json);
    }).toList();
  }

  @override
  Future<List<Product>> searchProducts(String searchTerm,
      {List<String>? categories}) async {
    final allProducts = await getAllProducts();
    final lowerSearch = searchTerm.toLowerCase().trim();

    final bool hasSearchTerm = lowerSearch.isNotEmpty;
    final bool hasCategories = categories != null &&
        categories.isNotEmpty &&
        !categories.contains('All');

    // If no filters are applied, return an empty list as per original logic.
    if (!hasSearchTerm && !hasCategories) {
      return [];
    }

    Iterable<Product> results = allProducts;

    if (hasSearchTerm) {
      results = results.where((product) {
        return product.name.toLowerCase().contains(lowerSearch) ||
            (product.searchableName?.toLowerCase().contains(lowerSearch) ??
                false) ||
            (product.sku?.toLowerCase().contains(lowerSearch) ?? false);
      });
    }

    if (hasCategories) {
      results = results.where((product) {
        return product.categories?.any((c) => categories.contains(c)) ?? false;
      });
    }

    return results.toList();
  }

  @override
  Future<Product?> getProductById(String productId) async {
    final allProducts = await getAllProducts();
    try {
      return allProducts.firstWhere((p) => p.id == productId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<DateTime?> getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString(_lastSyncKey);
    if (timestamp == null) {
      return null;
    }
    return DateTime.parse(timestamp);
  }

  @override
  Future<void> setLastSyncTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastSyncKey, time.toIso8601String());
  }

  @override
  Future<List<String>> getProductImages(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('product_images_$productId') ?? [];
  }

  @override
  Future<void> saveProductImages(String productId, List<String> images) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('product_images_$productId', images);
  }

  @override
  Future<void> saveLocations(List<Location> locations) async {
    final prefs = await SharedPreferences.getInstance();
    final locationsJson = locations.map((l) => jsonEncode(l.toJson())).toList();
    await prefs.setStringList(_locationsKey, locationsJson);
  }

  @override
  Future<List<Location>> getLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final locationsJson = prefs.getStringList(_locationsKey) ?? [];
    return locationsJson.map((jsonStr) {
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      return Location.fromJson(json);
    }).toList();
  }

  @override
  Future<void> saveProductImageThumbnail(
      String productId, String imageUrl, Uint8List thumbnail) async {
    // No-op for web
  }

  @override
  Future<Uint8List?> getProductImageThumbnail(String imageUrl) async {
    return null; // No-op for web
  }

  @override
  Future<Map<String, Uint8List>> getProductImageThumbnailsForProduct(
      String productId) async {
    return {}; // No-op for web
  }

  @override
  Future<void> clearThumbnails() async {
    // No-op for web
  }
}

LocalStorageService getLocalStorageService() => LocalStorageServiceWeb();

const String _productsKey = 'cached_products';
const String _lastSyncKey = 'last_sync_time';
const String _locationsKey = 'cached_locations';
