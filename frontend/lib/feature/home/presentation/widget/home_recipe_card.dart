import 'package:cookify/common/presentation/widget/cookify_cached_network_image.dart';
import 'package:cookify/core/l10n/s.dart';
import 'package:cookify/core/theme/t.dart';
import 'package:cookify/feature/home/domain/entity/recipe_preview.dart';
import 'package:cookify/feature/recipe/domain/entity/category.dart';
import 'package:cookify/feature/recipe/presentation/page/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeRecipeCard extends StatelessWidget {
  const HomeRecipeCard({super.key, required this.recipe});

  final RecipePreview recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RecipePage.fullRoute(id: recipe.id));
      },
      child: Column(
        spacing: 4.0,
        children: [
          Hero(
            tag: recipe.photoUrl,
            child: CookifyCachedNetworkImage(
              recipe.photoUrl,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Row(
                  spacing: 4.0,
                  children: [
                    Icon(Icons.favorite_border),

                    Text(
                      '20',
                      style: T
                          .bodyMedium(context)
                          .copyWith(color: T.primary(context)),
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: recipe.difficulty.color(),
                        border: Border.all(color: T.secondary(context)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      height: 26.0,
                      child: Text(
                        recipe.difficulty.text(context),
                        style: T.bodySmall(context),
                      ),
                    ),

                    Text(
                      S
                          .of(context)
                          .homeRecipeCardCookingTime(
                            recipe.cookingTime,
                          ),
                      style: T
                          .bodyMedium(context)
                          .copyWith(color: T.primary(context)),
                    ),

                    const Spacer(),

                    Icon(Icons.bookmark_border),
                  ],
                ),

                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: recipe.categories
                      .map((category) => _Category(category: category))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: T.primary(context),
        border: Border.all(color: T.secondary(context)),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(category.name, style: T.bodySmall(context)),
    );
  }
}
