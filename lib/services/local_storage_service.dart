import 'dart:typed_data';

import 'package:lzprices/models/location.dart';
import 'package:lzprices/models/product.dart';

// Conditionally import the correct implementation.
import 'local_storage_service_web.dart'
    if (dart.library.io) 'local_storage_service_mobile.dart';

abstract class LocalStorageService {
  // This factory constructor will automatically return the correct platform-specific instance.
  factory LocalStorageService() => getLocalStorageService();

  Future<void> saveProducts(List<Product> products);

  Future<void> saveProduct(Product product);

  Future<List<Product>> getAllProducts();

  Future<List<Product>> searchProducts(String searchTerm,
      {List<String>? categories});

  Future<Product?> getProductById(String productId);

  Future<void> setLastSyncTime(DateTime time);

  Future<DateTime?> getLastSyncTime();

  Future<void> saveProductImages(String productId, List<String> imageUrls);

  Future<List<String>> getProductImages(String productId);

  Future<void> saveProductImageThumbnail(
      String productId, String imageUrl, Uint8List thumbnail);

  Future<Uint8List?> getProductImageThumbnail(String imageUrl);

  Future<Map<String, Uint8List>> getProductImageThumbnailsForProduct(
      String productId);

  Future<void> clearAllData();

  Future<void> clearThumbnails();

  Future<void> saveLocations(List<Location> locations);

  Future<List<Location>> getLocations();
}
