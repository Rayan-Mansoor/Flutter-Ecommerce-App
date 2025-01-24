import 'package:zephyr_flutter/features/products/data/models/images.dart';

enum Categories {
  APPAREL,
  FOOTWEAR,
  EYEWEAR,
  WATCHES,
  JEWELLERY,
  BAGS;

  static Categories fromString(String value) {
    return Categories.values.firstWhere(
      (category) => category.name == value,
      orElse: () => throw ArgumentError('Invalid category'),
    );
  }
}

class Category {
  String name;
  Images images;

  Category({
    this.name = '',
    this.images = const Images(),
  });

  factory Category.fromFirestore(Map<String, dynamic> data) {
    return Category(
      name: data['name'] ?? '',
      images: Images.fromMap(data['images'] ?? {'source': []}),
    );
  }

  @override
  String toString() {
    return 'Category (name: $name, images: ${images.source.first})';
  }
}