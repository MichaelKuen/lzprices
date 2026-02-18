import 'dart:convert';

// Enum to represent the type of update for a product.
enum UpdateType { none, price, location, other }

class Product {
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
    this.searchTags,
    this.isNew = false, // Not persisted, only for UI state
    this.updateType = UpdateType.none, // Not persisted, only for UI state
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Safely parse a value to double, handling int, double, or string
    double? toDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        // Allow for empty strings or other non-numeric strings
        return double.tryParse(value);
      }
      return null;
    }

    // Safely parse a value to int, handling int, double, or string
    int? toInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt(); // Truncate if a double is provided
      if (value is String) {
        // Allow for empty strings or other non-numeric strings
        return int.tryParse(value);
      }
      return null;
    }

    // Safely parse a value to bool
    bool? toBool(dynamic value) {
      if (value == null) return null;
      if (value is bool) return value;
      if (value is int) return value == 1;
      if (value is String) {
        if (value.toLowerCase() == 'true' || value == '1') return true;
        if (value.toLowerCase() == 'false' || value == '0') return false;
      }
      return null;
    }

    // Safely parse a list of strings
    List<String> parseStringList(dynamic data) {
      if (data == null) return [];
      if (data is List) {
        return data.map((item) => item.toString().trim()).toList();
      }
      if (data is String && data.isNotEmpty) {
        if (data.startsWith('[') && data.endsWith(']')) {
          try {
            final List<dynamic> decoded = jsonDecode(data);
            return decoded.map((item) => item.toString().trim()).toList();
          } catch (e) {
            // Not a valid JSON array, fall back to comma separation
          }
        }
        return data.split(',').map((s) => s.trim()).toList();
      }
      return [];
    }

    return Product(
      id: json['id']?.toString() ?? '', // A product must have an ID
      wooId: toInt(json['woo_id']),
      name: json['name']?.toString() ?? 'Unnamed Product', // A product must have a name
      sku: json['sku']?.toString(),
      price: toDouble(json['price']),
      installerPrice: toDouble(json['installer_price']),
      wholesalePrice: toDouble(json['wholesale_price']),
      quantity: toInt(json['quantity']),
      lowThreshold: toInt(json['low_threshold']),
      whatsappSent: toBool(json['whatsapp_sent']),
      categories: parseStringList(json['categories']),
      imageUrls: parseStringList(json['image_url']),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      userId: json['user_id']?.toString(),
      wooStatus: json['woo_status']?.toString(),
      locations: parseStringList(json['locations']),
      shortDescription: json['short_description']?.toString(),
      description: json['description']?.toString(),
      searchableName: json['searchable_name']?.toString(),
      lastSyncedFrom: json['last_synced_from']?.toString(),
      searchTags: parseStringList(json['search_tags']),
    );
  }

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
  final List<String>? searchTags;
  final bool isNew;
  final UpdateType updateType;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'woo_id': wooId,
      'name': name,
      'sku': sku,
      'price': price,
      'installer_price': installerPrice,
      'wholesale_price': wholesalePrice,
      'quantity': quantity,
      'low_threshold': lowThreshold,
      'whatsapp_sent': whatsappSent,
      'categories': categories,
      'image_url': imageUrls, // Keep as a list
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_id': userId,
      'woo_status': wooStatus,
      'locations': locations,
      'short_description': shortDescription,
      'description': description,
      'searchable_name': searchableName,
      'last_synced_from': lastSyncedFrom,
      'search_tags': searchTags,
    };
  }

  Product copyWith({
    String? id,
    int? wooId,
    String? name,
    String? sku,
    double? price,
    double? installerPrice,
    double? wholesalePrice,
    int? quantity,
    int? lowThreshold,
    bool? whatsappSent,
    List<String>? categories,
    List<String>? imageUrls,
    String? createdAt,
    String? updatedAt,
    String? userId,
    String? wooStatus,
    List<String>? locations,
    String? shortDescription,
    String? description,
    String? searchableName,
    String? lastSyncedFrom,
    List<String>? searchTags,
    bool? isNew,
    UpdateType? updateType,
  }) {
    return Product(
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
      searchTags: searchTags ?? this.searchTags,
      isNew: isNew ?? this.isNew,
      updateType: updateType ?? this.updateType,
    );
  }
}