import 'package:cookify/config/error/failure.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/shared/domain/entity/category.dart';
import 'package:cookify/shared/domain/entity/cpfc.dart';
import 'package:cookify/shared/domain/entity/recipe.dart';
import 'package:cookify/shared/domain/entity/recipe_ingredient.dart';
import 'package:cookify/shared/domain/entity/recipe_step.dart';
import 'package:cookify/feature/recipe/domain/repository/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  @override
  Future<Either<Failure, Recipe>> getRecipe(String id) async {
    return switch (id) {
      '0' => Right(
        Recipe(
          id: '0', // Оставил как есть
          creator: 'lipin22', // Имя автора рецепта на сайте
          photoUrls: [
            'https://image.fonwall.ru/o/ws/food-bread-blue-lollipop.jpeg?auto=compress&fit=crop&h=889&w=500&domain=img3.fonwall.ru', // Основное фото булочек с сайта
            'https://image.fonwall.ru/o/ws/food-bread-blue-lollipop.jpeg?auto=compress&fit=crop&h=889&w=500&domain=img3.fonwall.ru',
          ],
          name: 'Булочки "Вкусняшки"', // Название с сайта
          categories: [
            Category(id: '0', name: 'Выпечка'),
            Category(id: '1', name: 'Булочки'),
          ], // Более подходящие категории
          cookingTime: 60, // Примерное общее время (подготовка + выпечка)
          difficulty: RecipeDifficulty.easy, // Судя по отзывам, рецепт простой
          cpfc: Cpfc(
            calories: 0,
            proteins: 0,
            fats: 0,
            carbohydrates: 0,
          ), // Нет данных на сайте. Оставил 0 для ручного расчета
          description:
              'Самые быстрые сладкие булочки. А продуктов вообще немного. Дешево и вкусно!', // Описание автора
          servingCount: 4.0,
          ingredients: [
            // Ингредиенты из списка на сайте. Количество и порядок сохранены
            RecipeIngredient(
              name: 'Мука',
              cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
              amount: 1,
              unit: 'g',
            ),
            RecipeIngredient(
              name: 'Мука',
              cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
              amount: 1,
              unit: 'g',
            ),
            RecipeIngredient(
              name: 'Мука',
              cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
              amount: 1,
              unit: 'g',
            ),
            RecipeIngredient(
              name: 'Мука',
              cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
              amount: 1,
              unit: 'g',
            ),
            // Примечание: в некоторых комментариях упоминается добавление яиц и молока, но в оригинальном рецепте их нет. Оставил базовый состав.
          ],
          steps: [
            // Пошаговые шаги, составленные на основе описания рецепта и фото на сайте
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/60/sm_59104.jpg', // Шаг 1: фото ингредиентов
              description:
                  'Подготовьте продукты: муку, сахар, прессованные дрожжи, воду, растительное масло, ванилин и соль.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/60/sm_59047.jpg', // Шаг 2: фото замеса опары
              description:
                  'Разведите дрожжи в теплой воде, добавьте сахар и 3 столовые ложки муки. Размешайте до однородности и оставьте опару подходить на 15-20 минут.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/60/sm_59049.jpg', // Шаг 3: фото замеса теста
              description:
                  'Когда опара запузырится, влейте в нее растительное масло, добавьте соль, ванилин и начните понемногу всыпать оставшуюся муку. Замесите мягкое, не липнущее к рукам тесто.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/60/sm_59049.jpg', // Шаг 4: фото раскатки и нарезки
              description:
                  'Раскатайте тесто в пласт толщиной примерно 1 см. Смажьте его растительным маслом и разрежьте на полоски шириной 2-3 см, а затем каждую полоску на прямоугольники.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/60/sm_59049.jpg', // Шаг 5: фото формовки
              description:
                  'Каждый прямоугольник слегка скрутите спиралькой. Выложите заготовки на противень, застеленный пергаментом, на некотором расстоянии друг от друга.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/60/sm_59061.jpg', // Шаг 6: готовые булочки
              description:
                  'Выпекайте булочки в разогретой до 180-200°C духовке примерно 20-25 минут до золотистого цвета. Готовые булочки можно присыпать сахарной пудрой.',
            ),
          ],
        ),
      ),
      '1' => Right(
        Recipe(
          id: '1', // Оставил как есть, можно заменить на уникальный
          creator: 'КомуДобавки', // Имя автора рецепта на сайте
          photoUrls: [
            'https://farm5.static.flickr.com/4060/4308794520_88b95f829a.jpg', // Основное фото готового блюда
          ],
          name: 'Плацинды с картофелем', // Название с сайта
          categories: [
            Category(id: '0', name: 'Выпечка'),
            Category(id: '1', name: 'Пироги'),
            Category(id: '2', name: 'Молдавская кухня'),
          ], // Подходящие категории
          cookingTime: 130, // Общее время (2 часа 10 минут) в минутах
          difficulty: RecipeDifficulty
              .medium, // В описании указана "небольшая сноровка", поэтому средний уровень
          cpfc: Cpfc(
            calories: 0,
            proteins: 0,
            fats: 0,
            carbohydrates: 0,
          ), // Данных на сайте нет, требуется ручной расчет
          description:
              'Молдавские плацинды с картофелем - аппетитные, румяные и вкусные. Сочная картофельная начинка и хрустящее тонкое тесто отлично сочетаются. Продукты для приготовления плацинд простейшие.', // Описание автора
          servingCount: 4.0,
          ingredients: [
            // Ингредиенты из списка на сайте, разделенные на группы для ясности

            // Для теста
            RecipeIngredient(
              name: 'Мука',
              cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
              amount: 1,
              unit: 'g',
            ),
          ],
          steps: [
            // Пошаговые шаги, составленные на основе описания рецепта
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/32/sm_31100.jpg', // Шаг 1: подготовка продуктов
              description:
                  'Подготовьте все ингредиенты: муку, воду, масло, соль для теста; картофель, лук, масло, соль и перец для начинки; яйцо для смазывания.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/32/sm_31101.jpg', // Шаг 2: замес теста
              description:
                  'В тёплой воде растворите соль. Муку просейте горкой, сделайте углубление, влейте воду и 2-3 ст. ложки масла. Замесите эластичное, нелипкое тесто (8-10 минут).',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/32/sm_31102.jpg', // Шаг 3: тесто под пленкой
              description:
                  'Миску смажьте маслом, положите тесто, накройте пленкой и оставьте на 40-60 минут.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/32/sm_31102.jpg', // Шаг 4: варка картофеля
              description:
                  'Для начинки: очистите картофель, отварите до готовности (20-25 минут после закипания). Лук мелко нарежьте и обжарьте до мягкости на растительном масле.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/32/sm_31104.jpg', // Шаг 5: приготовление пюре с луком
              description:
                  'Готовый картофель разомните в пюре, добавьте обжаренный лук вместе с маслом. Посолите, поперчите по вкусу и перемешайте. Полностью остудите начинку.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/610/sm_609809.jpg', // Шаг 6: деление теста на части
              description:
                  'Отдохнувшее тесто обомните и разделите на 5 равных частей, скатайте из каждой колобок. Накройте их пленкой, чтобы не обветривались.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/610/sm_609810.jpg', // Шаг 7: подготовка лепешек
              description:
                  'Каждый колобок раскатайте в небольшой круг (⌀ 15 см). Тарелку щедро смажьте маслом, выложите первый круг и тоже обильно смажьте маслом. Так же поступите с остальными кругами, сложив их стопкой.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/610/sm_609811.jpg', // Шаг 8: растягивание теста
              description:
                  'Возьмите одну лепешку и аккуратно растяните её руками в очень тонкий, почти прозрачный пласт (можно растягивать на кулаках). Если тесто порвется — не страшно. Слегка смажьте пласт маслом.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/610/sm_609812.jpg', // Шаг 9: складывание теста конвертом
              description:
                  'Заверните дальний край теста к центру, затем накройте его ближним краем. Получившуюся полосу сложите поперёк втрое, чтобы вышел квадрат. Хорошо растяните квадрат руками.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/610/sm_609813.jpg', // Шаг 10: формирование плацинды с начинкой
              description:
                  'На центр выложите ~2 ст. ложки начинки, распределите её тонким слоем. Соедините уголки теста в центре, закрывая начинку. Затем подтяните и соедините образовавшиеся уголки, чтобы получился круглый пирожок. Аккуратно растяните или раскатайте плацинду до нужного размера. Повторите с оставшимся тестом и начинкой.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/610/sm_609814.jpg', // Шаг 11: выпечка
              description:
                  'Духовку разогрейте до 190°C. Противень застелите пергаментом, выложите плацинды. Взболтайте яйцо и смажьте им заготовки. Выпекайте 30-35 минут до румяности.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/610/big_609814.jpg', // Шаг 12: готовое блюдо
              description:
                  'Готовые плацинды с картофелем слегка остудите и подавайте к столу. Приятного аппетита!',
            ),
          ],
        ),
      ),
      '2' => Right(
        Recipe(
          id: '2', // Оставил как есть
          creator: null, // Имя автора на странице не указано
          photoUrls: [
            'https://www.russianfood.com/dycontent/images_upl/66/sm_65164.jpg', // Основное фото готовых лепешек
          ],
          name: 'Лепешки с колбасно-сырной начинкой',
          categories: [
            Category(id: '0', name: 'Выпечка'),
            Category(id: '1', name: 'Закуски'),
            Category(id: '2', name: 'Пирожки и лепешки'),
          ],
          cookingTime: 60, // 1 час (как указано на сайте)
          difficulty: RecipeDifficulty
              .easy, // Рецепт позиционируется как "быстрое решение"
          cpfc: Cpfc(
            calories: 0,
            proteins: 0,
            fats: 0,
            carbohydrates: 0,
          ), // Требуется ручной расчет
          description:
              'Рецепт лепешек на кефире к вашему столу. Вкусное и быстрое решение продуктового вопроса :)',
          servingCount: 4.0,
          ingredients: [
            // Для теста
            RecipeIngredient(
              name: 'Мука',
              cpfc: Cpfc(calories: 0, proteins: 0, fats: 0, carbohydrates: 0),
              amount: 1,
              unit: 'g',
            ),
          ],
          steps: [
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/66/sm_65165.jpg', // Шаг 1: подготовка продуктов
              description:
                  'Подготовьте продукты: муку, кефир, яйцо, растительное масло, соль для теста. Для начинки: сардельку, сыр, вареное яйцо и укроп.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/66/sm_65166.jpg', // Шаг 2: приготовление начинки
              description:
                  'Приготовьте начинку: сардельку, сыр и вареное яйцо натрите на крупной терке. Укроп мелко нарежьте. Смешайте все ингредиенты начинки в миске.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://www.russianfood.com/dycontent/images_upl/66/sm_65171.jpg', // Шаг 3: замес теста
              description:
                  'Для теста: в миске смешайте кефир, яйцо, растительное масло и соль. Постепенно добавляйте муку и замесите мягкое тесто. (По отзывам, муки может потребоваться немного больше, чем 2 стакана, чтобы тесто не липло к рукам).',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/422/sm_421460.jpg', // Шаг 4: разделка теста
              description:
                  'Готовое тесто разделите на 6 равных частей и скатайте из них шарики. Каждый шарик раскатайте или растяните руками в круглую лепешку.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/422/sm_421461.jpg', // Шаг 5: формирование лепешек с начинкой
              description:
                  'На половину каждой лепешки выложите порцию начинки. Накройте начинку второй половиной теста и тщательно защипните края, придавая изделию форму полумесяца или круглого пирожка.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/422/sm_421462.jpg', // Шаг 6: жарка
              description:
                  'На сковороде разогрейте растительное масло. Обжарьте лепешки с двух сторон до золотистой корочки на среднем огне.',
            ),
            RecipeStep(
              name: 'Подготовка ингредиентов',
              photoUrl:
                  'https://img1.russianfood.com/dycontent/images_upl/422/big_421466.jpg', // Шаг 7: готовое блюдо
              description:
                  'Готовые лепешки выложите на бумажное полотенце, чтобы удалить лишнее масло. Подавайте горячими. Приятного аппетита!',
            ),
          ],
        ),
      ),
      _ => throw Exception(),
    };
  }
}
