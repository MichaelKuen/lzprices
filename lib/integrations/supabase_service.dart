import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lzprices/models/product.dart';
import 'package:lzprices/models/location.dart';
import 'package:lzprices/config.dart';

class SupabaseService {
  // Private constructor
  SupabaseService._internal();

  // The single instance
  static final SupabaseService _instance = SupabaseService._internal();

  // Factory constructor to return the instance
  factory SupabaseService() => _instance;

  // Getter for the Supabase client
  SupabaseClient get client => Supabase.instance.client;

  Future<void> initialize() async {
    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      anonKey: AppConfig.supabaseAnonKey,
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      await client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  Future<DateTime?> getLatestProductTimestamp() async {
    try {
      final response = await client.rpc('get_latest_product_timestamp');
      if (response == null) {
        return null;
      }
      return DateTime.tryParse(response.toString());
    } catch (e) {
      debugPrint('Failed to get latest product timestamp: $e');
      return null;
    }
  }

  Future<List<Product>> getProductsUpdatedSince(DateTime time) async {
    try {
      final response = await client
          .from('products')
          .select()
          .eq('woo_status', 'publish')
          .gt('updated_at', time.toIso8601String());

      final List<dynamic> data = response as List<dynamic>;
      final List<Product> products = [];

      for (final json in data) {
        try {
          if (json is Map<String, dynamic>) {
            products.add(Product.fromJson(json));
          }
        } catch (e) {
          debugPrint('Failed to parse product: $json. Error: $e');
        }
      }
      return products;
    } catch (e) {
      throw Exception('Failed to fetch updated products: $e');
    }
  }

  Future<List<Product>> searchProducts(String searchTerm, {List<String>? categories}) async {
    const pageSize = 1000;
    int currentPage = 0;
    List<Product> allProducts = [];
    bool hasMore = true;

    while (hasMore) {
      try {
        var query = client.from('products').select('*').eq('woo_status', 'publish');

        if (searchTerm.isNotEmpty) {
          final lowerSearch = searchTerm.toLowerCase().trim();
          final orFilters = 'name.ilike.%$lowerSearch%,searchable_name.ilike.%$lowerSearch%,sku.ilike.%$lowerSearch%,search_tags.cs.{$lowerSearch}';
          query = query.or(orFilters);
        }

        if (categories != null && categories.isNotEmpty) {
          final categoryFilters = categories.map((c) => 'categories.cs.{"$c"}').join(',');
          query = query.or(categoryFilters);
        }

        final response = await query
            .order('name')
            .range(currentPage * pageSize, (currentPage + 1) * pageSize - 1);

        final List<dynamic> data = response as List<dynamic>;
        final List<Product> products = [];

        for (final json in data) {
          try {
            if (json is Map<String, dynamic>) {
              products.add(Product.fromJson(json));
            }
          } catch (e) {
            debugPrint('Failed to parse product: $json. Error: $e');
          }
        }

        allProducts.addAll(products);

        if (data.length < pageSize) {
          hasMore = false;
        } else {
          currentPage++;
        }
      } catch (e) {
        throw Exception('Failed to search products: $e');
      }
    }
    return allProducts;
  }

  Future<Product?> addSearchTag(String productId, String tag) async {
    try {
      final product = await getProductById(productId).timeout(const Duration(seconds: 10));
      if (product == null) {
        throw Exception('Product not found');
      }

      final updatedTags = List<String>.from(product.searchTags ?? []);
      if (!updatedTags.contains(tag)) {
        updatedTags.add(tag);
      } else {
        return product; // Tag already exists, no update needed
      }

      return await updateProduct(productId, {'search_tags': updatedTags})
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      throw Exception('Failed to add search tag: $e');
    }
  }

  Future<Product?> removeSearchTag(String productId, String tag) async {
    try {
      final product = await getProductById(productId).timeout(const Duration(seconds: 10));
      if (product == null) {
        throw Exception('Product not found');
      }

      final updatedTags = List<String>.from(product.searchTags ?? []);
      updatedTags.remove(tag);

      return await updateProduct(productId, {'search_tags': updatedTags})
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      throw Exception('Failed to remove search tag: $e');
    }
  }

  Future<List<String>> getProductCategories() async {
    try {
      final response = await client.rpc('get_unique_categories');
      final List<dynamic> data = response as List<dynamic>;
      return data.map((dynamic item) => item['category'].toString()).toList();
    } catch (e) {
      throw Exception('Failed to fetch product categories: $e');
    }
  }

  Future<List<Location>> getLocations() async {
    try {
      final response = await client
          .from('locations')
          .select()
          .order('name', ascending: true);

      final List<dynamic> data = response as List<dynamic>;
      final List<Location> locations = [];

      for (final json in data) {
        if (json is Map<String, dynamic>) {
          locations.add(Location.fromJson(json));
        }
      }
      return locations;
    } catch (e) {
      throw Exception('Failed to fetch locations: $e');
    }
  }

  Future<Product?> getProductById(String productId) async {
    try {
      final response = await client
          .from('products')
          .select('*') // Explicitly select all columns
          .eq('id', productId)
          .single();
      return Product.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }

  Future<Product?> updateProduct(String productId, Map<String, dynamic> updates) async {
    try {
      final response = await client
          .from('products')
          .update(updates)
          .eq('id', productId)
          .select();

      if (response.isEmpty) {
        debugPrint('Supabase update returned no data. Check RLS policies.');
        return null;
      }
      return Product.fromJson(response.first);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<Product?> updateProductPrices(String productId, {double? price, double? installerPrice, double? wholesalePrice}) async {
    final updates = <String, dynamic>{};
    if (price != null) updates['price'] = price;
    if (installerPrice != null) updates['installer_price'] = installerPrice;
    if (wholesalePrice != null) updates['wholesale_price'] = wholesalePrice;

    if (updates.isEmpty) {
      return null; // Nothing to update
    }

    return updateProduct(productId, updates);
  }

  Future<Product?> updateProductLocations(String productId, List<String> locationSlugs) async {
    return updateProduct(productId, {'locations': locationSlugs});
  }

  Future<List<String>> getProductImages(String productId) async {
    try {
      final files = await client.storage
          .from('product-images')
          .list(path: 'products/$productId');
      final imageUrls = files
          .map(
            (file) => client.storage
                .from('product-images')
                .getPublicUrl('products/$productId/${file.name}'),
          )
          .toList();
      return imageUrls;
    } catch (e) {
      throw Exception('Failed to get product images: $e');
    }
  }

  Future<void> deleteProductImageFromStorage(
    String productId,
    String fileName,
  ) async {
    try {
      final result = await client.storage
          .from('product-images')
          .remove(['products/$productId/$fileName']);

      if (result.isEmpty) {
        throw 'The file was not found in the bucket or could not be accessed. Check file path and RLS policies.';
      }
    } on StorageException catch (e) {
      throw Exception(
          'Supabase Storage error: ${e.message} (Status code: ${e.statusCode})');
    } catch (e) {
      throw Exception('An unexpected error occurred during deletion: $e');
    }
  }


  Future<String> uploadProductImageToStorage(
    String productId,
    Uint8List bytes,
    String fileName,
  ) async {
    try {
      final String path = 'products/$productId/$fileName';
      await client.storage
          .from('product-images')
          .uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );
      final String publicUrl = client.storage
          .from('product-images')
          .getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
