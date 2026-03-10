import 'package:cookify/core/error/failure.dart';
import 'package:cookify/feature/home/domain/entity/recipe_preview.dart';
import 'package:cookify/feature/home/domain/repository/home_repository.dart';
import 'package:cookify/feature/recipe/config/enum/recipe_difficulty.dart';
import 'package:cookify/feature/recipe/domain/entity/category.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, List<RecipePreview>>> getRecipeList() async {
    await Future.delayed(const Duration(seconds: 3));
    return Right([
      RecipePreview(
        id: '0',
        photoUrl: 'https://s0.rbk.ru/v6_top_pics/resized/600xH/media/img/2/14/347101571204142.webp',
        name: 'Блины на молоке: традиционный рецепт',
        categories: [
          Category(id: '0', name: 'Блины'),
        ],
        cookingTime: 69,
        difficulty: RecipeDifficulty.easy,
      ),

      RecipePreview(
        id: '1',
        photoUrl: 'https://www.russianfood.com/dycontent/images_upl/109/sm_108777.jpg',
        name: 'Драники',
        categories: [
          Category(id: '0', name: 'Белорусская'),
          Category(id: '1', name: 'Картофельная'),
          Category(id: '2', name: 'Крутая'),
          Category(id: '3', name: 'Сасная'),
          Category(id: '4', name: 'Хуй')
        ],
        cookingTime: 72,
        difficulty: RecipeDifficulty.medium,
      ),
    ]);
  }
}
