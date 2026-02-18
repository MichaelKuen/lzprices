class Location {
  final String wcLocationId;
  final String name;
  final String slug;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Location({
    required this.wcLocationId,
    required this.name,
    required this.slug,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      wcLocationId: json['wc_location_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wc_location_id': wcLocationId,
      'name': name,
      'slug': slug,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
