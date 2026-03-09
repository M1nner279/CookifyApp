import 'package:cookify/core/error/failure.dart';
import 'package:cookify/feature/recipe/config/enum/recipe_difficulty.dart';
import 'package:cookify/feature/recipe/domain/entity/category.dart';
import 'package:cookify/feature/recipe/domain/entity/cpfc.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe_ingredient.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe_step.dart';
import 'package:cookify/feature/recipe/domain/repository/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  @override
  Future<Either<Failure, Recipe>> getRecipe(String id) async {
    await Future.delayed(const Duration(seconds: 5));
    return Right(
      Recipe(
        id: '0',
        creator: null,
        photoUrls: [
          'https://s0.rbk.ru/v6_top_pics/resized/600xH/media/img/2/14/347101571204142.webp',
        ],
        name: 'Блины на молоке: традиционный рецепт',
        categories: [Category(id: '0', name: 'Блины')],
        cookingTime: 20,
        difficulty: RecipeDifficulty.easy,
        cpfc: Cpfc(calories: 420, proteins: 5, fats: 30, carbohydrates: 65),
        ingredients: [
          RecipeIngredient(
            id: '0',
            name: 'Молоко',
            cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
            quantity: '500 мл.',
          ),

          RecipeIngredient(
            id: '1',
            name: 'Яйца',
            cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
            quantity: '2-3 шт. (в зависимости от размера)',
          ),

          RecipeIngredient(
            id: '2',
            name: 'Масло растительное',
            cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
            quantity: '1 ст. ложка (+для смазывания сковороды)',
          ),

          RecipeIngredient(
            id: '3',
            name: 'Мука',
            cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
            quantity: '200 г.',
          ),

          RecipeIngredient(
            id: '4',
            name: 'Сахар',
            cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
            quantity: '1 ст. ложка',
          ),

          RecipeIngredient(
            id: '5',
            name: 'Соль',
            cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
            quantity: '1 щепотка',
          ),

          RecipeIngredient(
            id: '6',
            name: 'Масло сливочное',
            cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
            quantity: '1 ст. ложка',
          ),
        ],
        steps: [
          RecipeStep(
            imageUrl: 'https://www.russianfood.com/dycontent/images_upl/173/sm_172876.jpg',
            description:
                'Размешайте яйца с солью и сахаром (венчиком или миксером). Влейте молоко (желательно слегка тёплое, или комнатной температуры). Понемногу добавляя просеянную муку, перемешайте блинное тесто венчиком, чтобы добиться однородной консистенции без комочков.',
          ),

          RecipeStep(
            imageUrl: 'https://www.russianfood.com/dycontent/images_upl/173/sm_172877.jpg',
            description:
                'Тесто для блинов должно быть достаточно жидким, чтобы блинчики получались тонкими. Влейте в тесто растительное масло. Перемешайте. Оставьте блинное тесто на 15-20 минут.',
          ),

          RecipeStep(
            imageUrl: 'https://www.russianfood.com/dycontent/images_upl/173/sm_172878.jpg',
            description:
                'Хорошо разогрейте сковороду и слегка смажьте её маслом.',
          ),

          RecipeStep(
            imageUrl: 'https://www.russianfood.com/dycontent/images_upl/173/sm_172879.jpg',
            description:
                'Налейте в центр сковороды небольшую порцию теста. Сразу же вращайте сковородку по кругу, чтобы тесто равномерно распределилось по всей поверхности.',
          ),

          RecipeStep(
            imageUrl: 'https://www.russianfood.com/dycontent/images_upl/173/sm_172880.jpg',
            description:
                'Жарьте тонкие блины на среднем огне (или чуть выше среднего) до румяности с двух сторон. Переворачивайте блинчик аккуратно, поддевая лопаткой с края. Готовые блины выкладывайте на тарелку и сразу смазывайте сливочным маслом, чтобы края не были сухими и блинчики получились нежными.',
          ),

          RecipeStep(
            imageUrl: 'https://www.russianfood.com/dycontent/images_upl/174/sm_173026.jpg',
            description:
                'Подавайте блинчики с вареньем, джемом или сгущенкой. Приятного аппетита!',
          ),
        ],
      ),
    );
  }
}
