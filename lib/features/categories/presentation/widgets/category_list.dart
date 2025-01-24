import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zephyr_flutter/features/categories/presentation/widgets/category_card.dart';
import 'package:zephyr_flutter/features/categories/providers/category_notifier.dart';

class Categorylist extends ConsumerWidget {
  const Categorylist({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategories = ref.watch(categoriesFetchProvider);

    return asyncCategories.when(
      data: (categories) {
        if(categories.isEmpty) {
          return const Center(child: Text('No categories found'));
        }
        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: categories[index]);
            },
          ),
        );
      }, 
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}