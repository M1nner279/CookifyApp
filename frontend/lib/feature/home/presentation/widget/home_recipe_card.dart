import 'package:cookify/config/l10n/s.dart';
import 'package:cookify/feature/recipe/presentation/page/recipe_page.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/feature/home/domain/entity/recipe_preview.dart';
import 'package:cookify/shared/domain/entity/category.dart';
import 'package:cookify/shared/presentation/widget/cookify_card.dart';
import 'package:cookify/shared/presentation/widget/cookify_carousel.dart';
import 'package:cookify/shared/presentation/widget/cookify_hero.dart';
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
      child: CookifyCard(
        child: Column(
          children: [
            CookifyHero(
              tag: 'recipe-${recipe.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxWidth,
                      child: CookifyCarousel(photoUrls: recipe.photoUrls),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const .fromLTRB(20.0, 16.0, 20.0, 20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          recipe.name,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            height: 28.0 / 20.0,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_border),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4.0),

                  Row(
                    spacing: 12.0,
                    children: [
                      _Info(
                        iconData: Icons.access_time,
                        text: S
                            .of(context)
                            .homeRecipeCardCookingTime(recipe.cookingTime),
                      ),

                      _Info(
                        iconData: Icons.person_outline,
                        text: S
                            .of(context)
                            .homeRecipeCardServingCount(recipe.servingCount),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8.0),

                  Row(
                    spacing: 8.0,
                    children: [
                      _Difficulty(difficulty: recipe.difficulty),

                      Expanded(
                        child: SizedBox(
                          height: 23.0,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (_, index) =>
                                _Category(category: recipe.categories[index]),
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 6.0),
                            itemCount: recipe.categories.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.iconData, required this.text});

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, size: 16.0),

        const SizedBox(width: 4.0),

        Text(
          text,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.0,
            height: 16.0 / 12.0,
          ),
        ),
      ],
    );
  }
}

class _Difficulty extends StatelessWidget {
  const _Difficulty({required this.difficulty});

  final RecipeDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: difficulty.color(),
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Text(
        difficulty.text(context),
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          height: 15.0 / 10.0,
        ),
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
      padding: const .symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: const Color(0x19000000),
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Text(
        category.name,
        style: const TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
          height: 15.0 / 10.0,
        ),
      ),
    );
  }
}
