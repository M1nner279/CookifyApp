import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/home/domain/entity/recipe_preview.dart';
import 'package:cookify/feature/home/domain/repository/home_repository.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/shared/domain/entity/category.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, List<RecipePreview>>> getRecipeList() async {
    await Future.delayed(const Duration(seconds: 3));
    return Right([
      RecipePreview(
        id: '0', // Оставил как есть
        photoUrl:
            'https://image.fonwall.ru/o/ws/food-bread-blue-lollipop.jpeg?auto=compress&fit=crop&h=889&w=500&domain=img3.fonwall.ru', // Основное фото булочек с сайта
        name: 'Булочки "Вкусняшки"', // Название с сайта
        categories: [
          Category(id: '0', name: 'Выпечка'),
          Category(id: '1', name: 'Булочки'),
        ], // Более подходящие категории
        cookingTime: 60, // Примерное общее время (подготовка + выпечка)
        difficulty: RecipeDifficulty.easy, // Судя по отзывам, рецепт простой
      ),

      RecipePreview(
        id: '1', // Оставил как есть, можно заменить на уникальный
        photoUrl:
            'https://farm5.static.flickr.com/4060/4308794520_88b95f829a.jpg', // Основное фото готового блюда

        name: 'Плацинды с картофелем', // Название с сайта
        categories: [
          Category(id: '0', name: 'Выпечка'),
          Category(id: '1', name: 'Пироги'),
          Category(id: '2', name: 'Молдавская кухня'),
        ], // Подходящие категории
        cookingTime: 130, // Общее время (2 часа 10 минут) в минутах
        difficulty: RecipeDifficulty
            .medium, // В описании указана "небольшая сноровка", поэтому средний уровень
      ),

      RecipePreview(
        id: '2', // Оставил как есть
        photoUrl:
            'https://www.russianfood.com/dycontent/images_upl/66/sm_65164.jpg', // Основное фото готовых лепешек

        name: 'Лепешки с колбасно-сырной начинкой',
        categories: [
          Category(id: '0', name: 'Выпечка'),
          Category(id: '1', name: 'Закуски'),
          Category(id: '2', name: 'Пирожки и лепешки'),
        ],
        cookingTime: 60, // 1 час (как указано на сайте)
        difficulty: RecipeDifficulty
            .easy, // Рецепт позиционируется как "быстрое решение"
      ),
    ]);
  }
}
