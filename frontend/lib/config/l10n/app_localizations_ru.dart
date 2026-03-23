// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get cookifyCachedNetworkImageError => 'Ошибка загрузки изображения';

  @override
  String get recipeDifficultyEasy => 'ЛЕГКИЙ';

  @override
  String get recipeDifficultyMedium => 'СРЕДНИЙ';

  @override
  String get recipeDifficultyHard => 'СЛОЖНЫЙ';

  @override
  String homeRecipeCardCookingTime(Object time) {
    return '$time мин';
  }

  @override
  String homeRecipeCardServingCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порций',
      few: '$count порции',
      one: '$count порция',
    );
    return '$_temp0';
  }

  @override
  String get recipeDescriptionSectionTime => 'Время';

  @override
  String recipeDescriptionSectionCookingTime(Object time) {
    return '$time мин';
  }

  @override
  String get recipeDescriptionSectionCarbs => 'У';

  @override
  String get recipeDescriptionSectionProteins => 'Б';

  @override
  String get recipeDescriptionSectionFats => 'Ж';

  @override
  String get recipeDescriptionSectionGrams => 'г';

  @override
  String get recipeDescriptionSectionCalories => 'ккал';

  @override
  String get recipeIngredientsSectionTitle => 'Ингредиенты';

  @override
  String recipeIngredientsSectionServingCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порции',
      many: '$count порций',
      few: '$count порции',
      one: '$count порция',
    );
    return '$_temp0';
  }

  @override
  String recipeDescriptionSectionCpfc(
    Object calories,
    Object carbohydrates,
    Object fats,
    Object proteins,
  ) {
    return 'БЖУ $proteins/$fats/$carbohydrates г. | $calories ккал. на 100 г.';
  }

  @override
  String get recipeStepsSectionTitle => 'Рецепт';
}
