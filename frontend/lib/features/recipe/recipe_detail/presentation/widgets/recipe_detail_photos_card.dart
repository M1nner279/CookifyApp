import 'package:cookify/core/presentation/widgets/cookify_carousel.dart';
import 'package:flutter/material.dart';

class RecipeDetailPhotosCard extends StatelessWidget {
  const RecipeDetailPhotosCard({super.key, required this.photoUrls});

  final List<String> photoUrls;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            child: CookifyCarousel(imageUrls: photoUrls),
          );
        },
      ),
    );
  }
}
