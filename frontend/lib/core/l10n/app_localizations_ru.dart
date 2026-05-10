// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get profileTitle => 'Профиль';

  @override
  String profileUserInfoCreatedAt(Object date) {
    return 'На кухне с $date';
  }

  @override
  String get profileUserStatisticInfoFavorite => 'Сохранено';

  @override
  String get profileUserStatisticInfoCreated => 'Создано';

  @override
  String get profileUserStatisticInfoPublished => 'Опубликовано';

  @override
  String get profileSettings => 'Настройки';

  @override
  String get profileSettingsLocale => 'Сменить язык';

  @override
  String get profileSettingsChangePassword => 'Смена пароля';

  @override
  String get profileSettingsSignout => 'Выйти из аккаунта';

  @override
  String get recipeFormTitle => 'Создание рецепта';

  @override
  String get recipeFormAddPhoto => 'Добавить фото';

  @override
  String get recipeFormNameLabel => 'НАЗВАНИЕ РЕЦЕПТА';

  @override
  String get recipeFormNameHint => 'Название вашего шедевра';

  @override
  String get recipeFormDescriptionLabel => 'ОПИСАНИЕ';

  @override
  String get recipeFormDescriptionHint => 'Расскажите нам почему это вкусно...';

  @override
  String get recipeFormNutrition => 'КБЖУ';

  @override
  String get recipeFormProtein => 'БЕЛ';

  @override
  String get recipeFormFat => 'ЖИР';

  @override
  String get recipeFormCarbs => 'УГЛ';

  @override
  String get recipeFormCalories => 'КАЛОРИИ';

  @override
  String get recipeFormDifficulty => 'СЛОЖНОСТЬ';

  @override
  String get recipeFormDifficultyEasy => 'ЛЕГКО';

  @override
  String get recipeFormDifficultyMedium => 'СРЕДНЕ';

  @override
  String get recipeFormDifficultyHard => 'СЛОЖНО';

  @override
  String get recipeFormCookingTimeLabel => 'ВРЕМЯ ПРИГОТОВЛЕНИЯ';

  @override
  String get recipeFormCookingTimeHint => '45 минут';

  @override
  String get recipeFormCategories => 'КАТЕГОРИИ';

  @override
  String get recipeFormAddCategory => 'Добавить категорию';

  @override
  String get recipeFormIngredients => 'ИНГРЕДИЕНТЫ';

  @override
  String get recipeFormAddIngredient => 'Добавить ингредиент';

  @override
  String get recipeFormSteps => 'ШАГИ ПРИГОТОВЛЕНИЯ';

  @override
  String get recipeFormAddStep => 'ДОБАВИТЬ ШАГ';

  @override
  String get recipeFormSaveDraft => 'Сохранить черновик';

  @override
  String get recipeFormSaveToSaved => 'В сохранённые';

  @override
  String get recipeFormPublish => 'Опубликовать рецепт';

  @override
  String get recipeFormSaving => 'Сохранение...';

  @override
  String get recipeFormPublishing => 'Публикация...';

  @override
  String get recipeFormDraftSaved => 'Черновик сохранён';

  @override
  String get recipeFormSavedRecipeAdded => 'Рецепт добавлен в сохранённые';

  @override
  String get recipeFormPublished => 'Рецепт опубликован';

  @override
  String get recipeFormPublishFailed => 'Не удалось опубликовать рецепт';

  @override
  String get recipeFormFillRequired => 'Заполните обязательные поля';

  @override
  String get recipeFormErrorPhoto => 'Добавьте фото рецепта';

  @override
  String get recipeFormErrorName => 'Введите название рецепта';

  @override
  String get recipeFormErrorDescription => 'Введите описание';

  @override
  String get recipeFormErrorCookingTime =>
      'Введите время приготовления больше 0';

  @override
  String get recipeFormErrorCategories => 'Добавьте хотя бы одну категорию';

  @override
  String get recipeFormErrorIngredients =>
      'Добавьте хотя бы один ингредиент с количеством и единицей';

  @override
  String get recipeFormErrorSteps =>
      'Добавьте хотя бы один шаг с заголовком и описанием';

  @override
  String get recipeFormStepTitleHint => 'Заголовок шага';

  @override
  String get recipeFormStepDescriptionHint => 'Описание шага';

  @override
  String get commonOfflineMessage =>
      'Нет подключения к интернету. Подключитесь к сети и обновите страницу.';

  @override
  String get commonRefresh => 'Обновить';

  @override
  String get commonBack => 'Назад';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonGramShort => 'г';

  @override
  String get commonKcalShort => 'ккал';

  @override
  String commonMinutes(Object value) {
    return '$value мин';
  }

  @override
  String commonServings(Object value) {
    return '$value порций';
  }

  @override
  String commonServingsDouble(Object value) {
    return '$value порций';
  }

  @override
  String get authBarSignIn => 'Вход';

  @override
  String get authBarSignUp => 'Регистрация';

  @override
  String get authBarRestore => 'Восстановление';

  @override
  String get authTopSubtitle => 'ИСКУССТВО ДОМАШНЕЙ КУХНИ';

  @override
  String get authDividerOr => 'ИЛИ ЧЕРЕЗ';

  @override
  String get authLoginLabel => 'ЛОГИН';

  @override
  String get authLoginHint => 'Введите логин';

  @override
  String get authEmailHint => 'Введите email';

  @override
  String get authPasswordLabel => 'ПАРОЛЬ';

  @override
  String get authPasswordHint => 'Введите пароль';

  @override
  String get authConfirmPasswordLabel => 'ПОВТОРИТЕ ПАРОЛЬ';

  @override
  String get authConfirmPasswordHint => 'Введите пароль повторно';

  @override
  String get authSignInButton => 'Войти';

  @override
  String get authSignInWrongLogin => 'Неправильный логин';

  @override
  String get authSignInWrongPassword => 'Неправильный пароль';

  @override
  String get authSignUpButton => 'Зарегистрироваться';

  @override
  String get authSignUpLoginTaken => 'Логин занят';

  @override
  String get authSignUpEmailTaken => 'Почта занята';

  @override
  String get authRestoreLoginOrEmailLabel => 'ЛОГИН ИЛИ EMAIL';

  @override
  String get authRestoreLoginOrEmailHint => 'Введите логин или email';

  @override
  String get authRestoreWrongLoginOrEmail => 'Неверный логин или email';

  @override
  String get authRestoreButton => 'Восстановить';

  @override
  String get changePasswordTitle => 'Смена пароля';

  @override
  String get changePasswordNewPasswordLabel => 'НОВЫЙ ПАРОЛЬ';

  @override
  String get changePasswordNewPasswordHint => 'Введите новый пароль';

  @override
  String get changePasswordSubmit => 'Сменить';

  @override
  String get otpTitle => 'Код подтверждения';

  @override
  String get otpInvalidCode => 'Неверный код';

  @override
  String otpResend(Object suffix) {
    return 'Отправить повторно$suffix';
  }

  @override
  String otpResendAfter(Object seconds) {
    return ' через $seconds секунд';
  }

  @override
  String get otpChangeAccount => 'Сменить аккаунт';

  @override
  String get recipeSavedTitle => 'Моя кухня';

  @override
  String get recipeSavedEmptyMessage =>
      'Здесь пока пусто. Сохраняйте понравившиеся рецепты из ленты, чтобы не потерять их';

  @override
  String get recipeSavedFind => 'Найти';

  @override
  String get recipeDraftsTitle => 'Черновики';

  @override
  String get recipeDraftsEmptyMessage =>
      'Здесь пока пусто. Создавайте свои собственные кулинарные шедевры';

  @override
  String get recipeDraftsCreate => 'Создать';

  @override
  String get recipeDraftsUntitled => 'Без названия';

  @override
  String get recipeDraftsDeleteTitle => 'Удалить черновик?';

  @override
  String recipeDraftsUpdated(Object value) {
    return 'Обновлено: $value';
  }

  @override
  String get recipeDetailIngredients => 'Ингредиенты';

  @override
  String get recipeDetailSteps => 'Шаги';

  @override
  String get recipeDetailTime => 'Время';

  @override
  String get recipeDetailProteinSign => 'Б';

  @override
  String get recipeDetailFatSign => 'Ж';

  @override
  String get recipeDetailCarbsSign => 'У';

  @override
  String get recipeDifficultyEasy => 'ЛЕГКО';

  @override
  String get recipeDifficultyMedium => 'СРЕДНЕ';

  @override
  String get recipeDifficultyHard => 'СЛОЖНО';

  @override
  String get commonLanguageRu => 'Русский';

  @override
  String get commonLanguageEn => 'English';

  @override
  String get commonError => 'Ошибка';

  @override
  String get searchTitle => 'Поиск';

  @override
  String get searchButton => 'ПОИСК';

  @override
  String get searchNothingFound => 'Ничего не найдено';

  @override
  String get searchRecipeNameHint => 'Название рецепта';

  @override
  String get searchCookingTimeTitle => 'Время приготовления';

  @override
  String searchCookingTimeUpTo(Object value) {
    return 'до $value мин';
  }

  @override
  String get searchNutritionGoals => 'Цели в питании';

  @override
  String get searchCaloriesLabel => 'КАЛОРИИ';

  @override
  String get searchProteinsLabel => 'БЕЛКИ';

  @override
  String get searchFatsLabel => 'ЖИРЫ';

  @override
  String get searchCarbsLabel => 'УГЛЕВОДЫ';

  @override
  String get searchCategoriesTitle => 'Категории';

  @override
  String get searchIngredientsTitle => 'Ингредиенты';

  @override
  String get searchAddCategoryHint => 'Добавить категорию...';

  @override
  String get searchAddIngredientHint => 'Добавить ингредиент...';

  @override
  String get searchAddCategory => 'Добавить категорию';

  @override
  String get searchAddIngredient => 'Добавить ингредиент';

  @override
  String get searchCategoryNotFound => 'Категории не найдены';

  @override
  String get searchIngredientNotFound => 'Ингредиенты не найдены';

  @override
  String get searchCategoryHint => 'Здоровое питание';

  @override
  String get searchIngredientHint => 'Курица';

  @override
  String get searchGeneralTitle => 'Общее';

  @override
  String get searchMaxCookingTimeHint => 'Максимальное время приготовления';

  @override
  String get searchCaloriesTitle => 'Калории';

  @override
  String get searchProteinsTitle => 'Белки';

  @override
  String get searchFatsTitle => 'Жиры';

  @override
  String get searchCarbsTitle => 'Углеводы';

  @override
  String get searchMinHint => 'Мин';

  @override
  String get searchMaxHint => 'Макс';

  @override
  String get validationFieldRequired => 'Поле не может быть пустым';

  @override
  String get validationLoginTooShort => 'Логин слишком короткий';

  @override
  String get validationLoginTooLong => 'Логин слишком длинный';

  @override
  String get validationEmailInvalid => 'Некорректный email';

  @override
  String get validationPasswordTooShort => 'Пароль слишком короткий';

  @override
  String get validationPasswordTooLong => 'Пароль слишком длинный';

  @override
  String get validationPasswordInvalid =>
      'Пароль должен содержать строчные и заглавные латинские буквы, цифры и спец символы (@\$!%*?&_)';

  @override
  String get validationConfirmPasswordNotMatch => 'Пароли не совпадают';
}
