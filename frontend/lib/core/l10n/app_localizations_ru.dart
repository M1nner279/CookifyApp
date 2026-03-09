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
  String recipeDescriptionSectionCookingTime(Object time) {
    return '$time мин. |';
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
  String get recipeIngredientsSectionTitle => 'Ингредиенты';

  @override
  String get recipeStepsSectionTitle => 'Рецепт';
}
