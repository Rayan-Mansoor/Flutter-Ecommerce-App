import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_state.dart';
import 'package:zephyr_flutter/features/products/data/models/product.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier() : super(ProductState(products: [], favoriteProducts: {}, cartProducts: {}));

  void addProduct(Product product) {
    state = state.copyWith(
      products: [...state.products, product],
    );
  }

  void setProducts(List<Product> products) {
    state = state.copyWith(products: products);
  }

  void toggleFavorite(Product product) {
    final isFavorite = state.favoriteProducts.contains(product);

    final updatedFavorites = {...state.favoriteProducts};
    if (isFavorite) {
      updatedFavorites.remove(product);
    } else {
      updatedFavorites.add(product);
    }

    state = state.copyWith(favoriteProducts: updatedFavorites);
  }

  void toggleCart(Product product) {
    final isInCart = state.cartProducts.contains(product);

    final updatedCart = {...state.cartProducts};
    if (isInCart) {
      updatedCart.remove(product);
    } else {
      updatedCart.add(product);
    }

    state = state.copyWith(cartProducts: updatedCart);
  }

  bool isFavorite(Product product) {
    return state.favoriteProducts.contains(product);
  }

  bool isInCart(Product product) {
    return state.cartProducts.contains(product);
  }
  
}

// Finally, the provider:
final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier();
});

final productFetchProvider = FutureProvider<List<Product>>((ref) async {
  final querySnapshot = await FirebaseFirestore.instance.collection('products').get();

  final products = querySnapshot.docs
      .map((doc) => Product.fromFirestore(doc.data()))
      .toList();

  // Optionally set them in product state if needed
  ref.read(productProvider.notifier).setProducts(products);

  return products;
});
