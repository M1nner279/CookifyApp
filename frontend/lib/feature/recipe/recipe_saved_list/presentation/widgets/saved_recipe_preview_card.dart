import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/entities/saved_recipe_preview_entity.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavedRecipePreviewCard extends StatelessWidget {
  const SavedRecipePreviewCard({super.key, required this.recipe});

  final SavedRecipePreviewEntity recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/recipes/${recipe.id}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2C1C16),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CachedNetworkImage(
                        imageUrl: recipe.photoUrl,
                        width: constraints.maxWidth,
                        height: constraints.maxWidth,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
      
                if (recipe.isPublished ?? false)
                  Positioned(
                    top: 12.0,
                    right: 12.0,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5E6D3),
                        shape: BoxShape.circle,
                      ),
                      width: 36.0,
                      height: 36.0,
                      child: const Icon(Icons.star, color: Color(0xFF3E2D16)),
                    ),
                  ),
              ],
            ),
      
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Difficulty(difficulty: recipe.difficulty),
      
                  const SizedBox(height: 8.0),
      
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      color: Color(0xFFFFE6C9),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.0,
                      height: 22.5 / 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
      
                  const SizedBox(height: 12.0),
      
                  _CookingTime(cookingTime: recipe.cookingTime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Difficulty extends StatelessWidget {
  const _Difficulty({required this.difficulty});

  final RecipeDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: difficulty.color(),
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Text(
        'EASY',
        style: const TextStyle(
          color: Color(0xFF1A0F0A),
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
          height: 15.0 / 10.0,
        ),
      ),
    );
  }
}

class _CookingTime extends StatelessWidget {
  const _CookingTime({required this.cookingTime});

  final int cookingTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: [
        const Icon(Icons.access_time, size: 11.67, color: Color(0x9AFADCD2)),

        Text(
          '$cookingTime mins',
          style: const TextStyle(
            color: Color(0x9AFADCD2),
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.0,
            height: 18.0 / 14.0,
          ),
        ),
      ],
    );
  }
}
