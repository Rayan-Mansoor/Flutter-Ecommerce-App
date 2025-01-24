import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zephyr_flutter/features/products/providers/product_notifier.dart';
import 'package:zephyr_flutter/features/products/presentation/widgets/product_card.dart';
import 'package:zephyr_flutter/features/sliders/presentation/widgets/image_slider.dart';
import 'package:zephyr_flutter/features/categories/presentation/widgets/category_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(productFetchProvider);

    return asyncProducts.when(
      data: (products) {
        if (products.isEmpty) {
          return const Center(child: Text('No products found'));
        }
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: ImageSlider()),
            const SliverToBoxAdapter(child: Categorylist()),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index >= products.length) return null;
                    return ProductCard(product: products[index], ref: ref);
                  },
                  childCount: products.length,
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}