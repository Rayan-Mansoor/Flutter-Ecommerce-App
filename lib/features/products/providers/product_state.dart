import 'package:zephyr_flutter/features/products/data/models/product.dart';

class ProductState {
  final List<Product> products;
  final Set<Product> favoriteProducts;
  final Set<Product> cartProducts;

  ProductState({
    required this.products,
    required this.favoriteProducts,
    required this.cartProducts,
  });

  ProductState copyWith({
    List<Product>? products,
    Set<Product>? favoriteProducts,
    Set<Product>? cartProducts,
  }) {
    return ProductState(
      products: products ?? this.products,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      cartProducts: cartProducts ?? this.cartProducts,
    );
  }
}