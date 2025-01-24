import 'package:flutter/material.dart';
import 'package:zephyr_flutter/features/categories/data/models/categories.dart' as custom;

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final custom.Category category;

  @override
  Widget build(BuildContext context) {
    final imageUrl = category.images.source.first;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),  // Rounded borders
        ),
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 50,
                  ),
              ),
        ),
      ),
    );
  }
}
