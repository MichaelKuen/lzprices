import 'package:lzprices/integrations/supabase_service.dart';
import 'package:lzprices/models/product.dart';
import 'package:lzprices/service_locator.dart';
import 'package:lzprices/services/local_storage_service.dart';

class ProductRepository {
  final SupabaseService _supabase = sl<SupabaseService>();
  final LocalStorageService _localStorage = sl<LocalStorageService>();

  Future<bool> get isOnline async {
    try {
      // A quick check to see if we can reach the remote database
      await _supabase.client.from('products').select('id').limit(1);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Product>> searchProducts(String searchTerm,
      {List<String>? categories}) async {
    final online = await isOnline;
    if (online) {
      try {
        final products = await _supabase.searchProducts(searchTerm, categories: categories);
        // Cache the results locally for offline access
        await _localStorage.saveProducts(products);
        return products;
      } catch (e) {
        // If online search fails, fall back to the local database
        return _localStorage.searchProducts(searchTerm, categories: categories);
      }
    } else {
      // When offline, search the local database directly
      return _localStorage.searchProducts(searchTerm, categories: categories);
    }
  }

  Future<Product?> getProduct(String productId) async {
    final online = await isOnline;
    if (online) {
      try {
        final product = await _supabase.getProductById(productId);
        if (product != null) {
          await _localStorage.saveProduct(product);
        }
        return product;
      } catch (e) {
        return _localStorage.getProductById(productId);
      }
    } else {
      return _localStorage.getProductById(productId);
    }
  }

  Future<List<String>> getProductCategories() async {
    final online = await isOnline;
    if (online) {
      try {
        return await _supabase.getProductCategories();
      } catch (e) {
        return _getLocalCategories();
      }
    } else {
      return _getLocalCategories();
    }
  }

  Future<List<String>> _getLocalCategories() async {
    final allProducts = await _localStorage.getAllProducts();
    final categorySet = <String>{};
    for (final product in allProducts) {
      if (product.categories != null) {
        categorySet.addAll(product.categories!);
      }
    }
    final categoryList = categorySet.toList();
    categoryList.sort();
    return categoryList;
  }

  Future<Product?> updateProductPrices(String productId,
      {double? price, double? installerPrice, double? wholesalePrice}) async {
    if (!await isOnline) {
      throw Exception('Cannot update prices while offline.');
    }

    try {
      final updatedProduct = await _supabase.updateProductPrices(
        productId,
        price: price,
        installerPrice: installerPrice,
        wholesalePrice: wholesalePrice,
      );

      if (updatedProduct != null) {
        await _localStorage.saveProduct(updatedProduct);
      }

      return updatedProduct;
    } catch (e) {
      throw Exception('Failed to update product prices: $e');
    }
  }

   Future<Product?> updateProductQuantity(String productId, int quantity) async {
    if (!await isOnline) {
      throw Exception('Cannot update quantity while offline.');
    }

    try {
      final updatedProduct = await _supabase.updateProduct(productId, {'quantity': quantity, 'quantity_update_source': 'app'});

      if (updatedProduct != null) {
        await _localStorage.saveProduct(updatedProduct);
      }

      return updatedProduct;
    } catch (e) {
      throw Exception('Failed to update product quantity: $e');
    }
  }

  Future<List<String>> getProductImages(String productId) async {
     final online = await isOnline;
    if (online) {
      try {
        final images = await _supabase.getProductImages(productId);
        await _localStorage.saveProductImages(productId, images);
        return images;
      } catch (e) {
        return await _localStorage.getProductImages(productId);
      }
    } else {
      return await _localStorage.getProductImages(productId);
    }
  }
}
