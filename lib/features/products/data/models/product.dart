import 'images.dart';
import '../../../categories/data/models/categories.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final Categories category;
  final int stock;
  final Images images;

  const Product({
    this.name = "",
    this.description = "",
    this.price = 0.0,
    this.category = Categories.APPAREL,
    this.stock = 0,
    this.images = const Images(),
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Product) return false;

    return name == other.name &&
        description == other.description &&
        price == other.price &&
        category == other.category &&
        stock == other.stock &&
        images == other.images;
  }

  @override
  int get hashCode => Object.hash(
        name,
        description,
        price,
        category,
        stock,
        images,
      );

  factory Product.fromFirestore(Map<String, dynamic> data) {
    return Product(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      category: Categories.fromString(data['category'] ?? ''),
      stock: data['stock'] ?? 0,
      images: Images.fromMap(data['images'] ?? {'source': []}),
    );
  }
}