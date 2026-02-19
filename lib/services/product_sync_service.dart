import 'package:flutter/foundation.dart';
import 'package:lzprices/services/local_storage_service.dart';
import 'package:lzprices/integrations/supabase_service.dart';
import 'package:lzprices/models/product.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:lzprices/service_locator.dart';

class ProductSyncService {
  final LocalStorageService _localStorage = sl<LocalStorageService>();
  final SupabaseService _supabase = sl<SupabaseService>();

  bool _isSyncing = false;

  Future<bool> get isOnline async {
    try {
      await _supabase.client.from('products').select('id').limit(1);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkForUpdates() async {
    final lastRemoteUpdate = await _supabase.getLatestProductTimestamp();
    if (lastRemoteUpdate == null) {
      return false; // No remote data, so no update available
    }

    final lastLocalSync = await _localStorage.getLastSyncTime();
    if (lastLocalSync == null) {
      return true; // No local data, so an update is definitely available
    }

    return lastRemoteUpdate.isAfter(lastLocalSync);
  }

  Future<List<Product>> checkForNewAndUpdatedProducts() async {
    if (_isSyncing) {
      return []; // Don't run if another sync is already in progress
    }
    _isSyncing = true;

    try {
      final online = await isOnline;
      if (!online) {
        return [];
      }

      final lastSyncTime = await _localStorage.getLastSyncTime();

      if (lastSyncTime == null) {
        await _localStorage.setLastSyncTime(DateTime.now().toUtc());
        return [];
      }

      final productsToSync =
          await _supabase.getProductsUpdatedSince(lastSyncTime);

      if (productsToSync.isNotEmpty) {
        final productsWithStatus = <Product>[];
        for (final product in productsToSync) {
          final existingProduct =
              await _localStorage.getProductById(product.id);
          if (existingProduct == null) {
            productsWithStatus.add(product.copyWith(isNew: true));
          } else {
            // Compare prices
            final bool pricesAreEqual =
                existingProduct.price == product.price &&
                    existingProduct.installerPrice == product.installerPrice &&
                    existingProduct.wholesalePrice == product.wholesalePrice;

            // Compare locations
            final bool locationsAreEqual = const ListEquality().equals(
                existingProduct.locations?..sort(), product.locations?..sort());

            UpdateType updateType = UpdateType.other;
            if (!pricesAreEqual) {
              updateType = UpdateType.price;
            } else if (!locationsAreEqual) {
              updateType = UpdateType.location;
            }

            productsWithStatus.add(product.copyWith(updateType: updateType));
          }
        }

        await _localStorage.saveProducts(productsToSync);
        await _syncImageThumbnails(productsToSync);
        await _localStorage.setLastSyncTime(DateTime.now().toUtc());

        return productsWithStatus;
      }

      return []; // No updates found
    } catch (e) {
      debugPrint('Polling for updates failed: $e');
      return []; // Return empty on error
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _syncLocations() async {
    debugPrint('Syncing locations...');
    final locations = await _supabase.getLocations();
    await _localStorage.saveLocations(locations);
    debugPrint('Saved ${locations.length} locations to local storage.');
  }

  Future<void> performDeltaSync() async {
    if (_isSyncing) {
      return;
    }
    _isSyncing = true;

    try {
      final online = await isOnline;
      if (!online) {
        _isSyncing = false;
        return;
      }

      await _syncLocations();

      final lastSyncTime = await _localStorage.getLastSyncTime();
      List<Product> productsToSync;

      if (lastSyncTime == null) {
        debugPrint('Performing initial full sync...');
        productsToSync = await _supabase.searchProducts('');
      } else {
        debugPrint('Performing delta sync for changes since $lastSyncTime...');
        productsToSync = await _supabase.getProductsUpdatedSince(lastSyncTime);
      }

      if (productsToSync.isNotEmpty) {
        await _localStorage.saveProducts(productsToSync);
        await _syncImageThumbnails(productsToSync);
        debugPrint('Saved ${productsToSync.length} products to local storage.');
      }

      await _localStorage.setLastSyncTime(DateTime.now().toUtc());
      debugPrint(
          'Sync completed successfully. New sync time is ${DateTime.now().toUtc()}.');
    } catch (e) {
      debugPrint('Sync failed: $e');
      rethrow;
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> performFullSync() async {
    if (_isSyncing) {
      return;
    }
    _isSyncing = true;

    try {
      final online = await isOnline;
      if (!online) {
        throw Exception('Cannot perform a full sync while offline.');
      }

      debugPrint('Performing full sync...');

      // 1. Clear existing local data.
      await _localStorage.clearAllData();
      await _localStorage.clearThumbnails();

      // 2. Fetch all products from remote.
      final allProducts = await _supabase.searchProducts('');

      // 3. Save them to local storage.
      await _localStorage.saveProducts(allProducts);
      await _syncImageThumbnails(allProducts);

      // 4. Sync locations
      await _syncLocations();

      // 5. Update the sync time.
      await _localStorage.setLastSyncTime(DateTime.now().toUtc());

      debugPrint(
          'Full sync completed successfully. Saved ${allProducts.length} products.');
    } catch (e) {
      debugPrint('Full sync failed: $e');
      rethrow; // Rethrow to allow the UI to catch it.
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _syncImageThumbnails(List<Product> products) async {
    if (kIsWeb) {
      return;
    }

    for (final product in products) {
      if (product.imageUrls != null) {
        for (final imageUrl in product.imageUrls!) {
          try {
            // Construct the URL for the resized thumbnail by manipulating the public URL.
            if (!imageUrl.contains('/object/public/')) {
              debugPrint('Image URL does not appear to be a public Supabase URL, skipping: $imageUrl');
              continue;
            }
            final thumbnailUrl = imageUrl.replaceFirst('/object/public/', '/render/image/public/') + '?width=150';
            
            // Download the thumbnail.
            final response = await http.get(Uri.parse(thumbnailUrl)).timeout(const Duration(seconds: 10));

            if (response.statusCode == 200) {
              // Save the downloaded thumbnail directly.
              await _localStorage.saveProductImageThumbnail(product.id, imageUrl, response.bodyBytes);
            } else {
                debugPrint(
                  'Failed to download thumbnail for $imageUrl. Status: ${response.statusCode}');
            }
          } catch (e) {
            debugPrint('Failed to sync thumbnail for $imageUrl: $e');
          }
        }
      }
    }
  }
}
