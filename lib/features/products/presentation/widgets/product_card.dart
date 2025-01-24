import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zephyr_flutter/features/products/data/models/product.dart';
import 'package:zephyr_flutter/features/products/providers/product_notifier.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final WidgetRef ref;

  const ProductCard({
    super.key,
    required this.product,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: product.images.source.isNotEmpty
                        ? Image.network(
                            product.images.source.first,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product Name
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                
                // Product Description
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 10),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '\$${product.price.toInt()}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                      width: 32,
                      child: Consumer(
                        builder: (context, ref, _) {
                          final favoriteProducts = ref.watch(
                            productProvider.select((state) => state.favoriteProducts),
                          );
                          final isFavorite = favoriteProducts.contains(product);

                          return IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              size: 18,
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              ref.read(productProvider.notifier).toggleFavorite(product);
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 32,
                      width: 32,
                      child:  Consumer(
                        builder: (context, ref, _) {
                          final cartProducts = ref.watch(
                            productProvider.select((state) => state.cartProducts),
                          );
                          final isInCart = cartProducts.contains(product);

                          return IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              isInCart ? Icons.remove_shopping_cart : Icons.shopping_cart,
                              size: 18,
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              ref.read(productProvider.notifier).toggleCart(product);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}