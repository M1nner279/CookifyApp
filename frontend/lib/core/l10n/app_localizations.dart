import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @profileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profileTitle;

  /// No description provided for @profileUserInfoCreatedAt.
  ///
  /// In ru, this message translates to:
  /// **'На кухне с {date}'**
  String profileUserInfoCreatedAt(Object date);

  /// No description provided for @profileUserStatisticInfoFavorite.
  ///
  /// In ru, this message translates to:
  /// **'Сохранено'**
  String get profileUserStatisticInfoFavorite;

  /// No description provided for @profileUserStatisticInfoCreated.
  ///
  /// In ru, this message translates to:
  /// **'Создано'**
  String get profileUserStatisticInfoCreated;

  /// No description provided for @profileUserStatisticInfoPublished.
  ///
  /// In ru, this message translates to:
  /// **'Опубликовано'**
  String get profileUserStatisticInfoPublished;

  /// No description provided for @profileSettings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get profileSettings;

  /// No description provided for @profileSettingsLocale.
  ///
  /// In ru, this message translates to:
  /// **'Сменить язык'**
  String get profileSettingsLocale;

  /// No description provided for @profileSettingsChangePassword.
  ///
  /// In ru, this message translates to:
  /// **'Смена пароля'**
  String get profileSettingsChangePassword;

  /// No description provided for @profileSettingsSignout.
  ///
  /// In ru, this message translates to:
  /// **'Выйти из аккаунта'**
  String get profileSettingsSignout;

  /// No description provided for @recipeFormTitle.
  ///
  /// In ru, this message translates to:
  /// **'Создание рецепта'**
  String get recipeFormTitle;

  /// No description provided for @recipeFormAddPhoto.
  ///
  /// In ru, this message translates to:
  /// **'Добавить фото'**
  String get recipeFormAddPhoto;

  /// No description provided for @recipeFormNameLabel.
  ///
  /// In ru, this message translates to:
  /// **'НАЗВАНИЕ РЕЦЕПТА'**
  String get recipeFormNameLabel;

  /// No description provided for @recipeFormNameHint.
  ///
  /// In ru, this message translates to:
  /// **'Название вашего шедевра'**
  String get recipeFormNameHint;

  /// No description provided for @recipeFormDescriptionLabel.
  ///
  /// In ru, this message translates to:
  /// **'ОПИСАНИЕ'**
  String get recipeFormDescriptionLabel;

  /// No description provided for @recipeFormDescriptionHint.
  ///
  /// In ru, this message translates to:
  /// **'Расскажите нам почему это вкусно...'**
  String get recipeFormDescriptionHint;

  /// No description provided for @recipeFormNutrition.
  ///
  /// In ru, this message translates to:
  /// **'КБЖУ'**
  String get recipeFormNutrition;

  /// No description provided for @recipeFormProtein.
  ///
  /// In ru, this message translates to:
  /// **'БЕЛ'**
  String get recipeFormProtein;

  /// No description provided for @recipeFormFat.
  ///
  /// In ru, this message translates to:
  /// **'ЖИР'**
  String get recipeFormFat;

  /// No description provided for @recipeFormCarbs.
  ///
  /// In ru, this message translates to:
  /// **'УГЛ'**
  String get recipeFormCarbs;

  /// No description provided for @recipeFormCalories.
  ///
  /// In ru, this message translates to:
  /// **'КАЛОРИИ'**
  String get recipeFormCalories;

  /// No description provided for @recipeFormDifficulty.
  ///
  /// In ru, this message translates to:
  /// **'СЛОЖНОСТЬ'**
  String get recipeFormDifficulty;

  /// No description provided for @recipeFormDifficultyEasy.
  ///
  /// In ru, this message translates to:
  /// **'ЛЕГКО'**
  String get recipeFormDifficultyEasy;

  /// No description provided for @recipeFormDifficultyMedium.
  ///
  /// In ru, this message translates to:
  /// **'СРЕДНЕ'**
  String get recipeFormDifficultyMedium;

  /// No description provided for @recipeFormDifficultyHard.
  ///
  /// In ru, this message translates to:
  /// **'СЛОЖНО'**
  String get recipeFormDifficultyHard;

  /// No description provided for @recipeFormCookingTimeLabel.
  ///
  /// In ru, this message translates to:
  /// **'ВРЕМЯ ПРИГОТОВЛЕНИЯ'**
  String get recipeFormCookingTimeLabel;

  /// No description provided for @recipeFormCookingTimeHint.
  ///
  /// In ru, this message translates to:
  /// **'45 минут'**
  String get recipeFormCookingTimeHint;

  /// No description provided for @recipeFormCategories.
  ///
  /// In ru, this message translates to:
  /// **'КАТЕГОРИИ'**
  String get recipeFormCategories;

  /// No description provided for @recipeFormAddCategory.
  ///
  /// In ru, this message translates to:
  /// **'Добавить категорию'**
  String get recipeFormAddCategory;

  /// No description provided for @recipeFormIngredients.
  ///
  /// In ru, this message translates to:
  /// **'ИНГРЕДИЕНТЫ'**
  String get recipeFormIngredients;

  /// No description provided for @recipeFormAddIngredient.
  ///
  /// In ru, this message translates to:
  /// **'Добавить ингредиент'**
  String get recipeFormAddIngredient;

  /// No description provided for @recipeFormSteps.
  ///
  /// In ru, this message translates to:
  /// **'ШАГИ ПРИГОТОВЛЕНИЯ'**
  String get recipeFormSteps;

  /// No description provided for @recipeFormAddStep.
  ///
  /// In ru, this message translates to:
  /// **'ДОБАВИТЬ ШАГ'**
  String get recipeFormAddStep;

  /// No description provided for @recipeFormSaveDraft.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить черновик'**
  String get recipeFormSaveDraft;

  /// No description provided for @recipeFormSaveToSaved.
  ///
  /// In ru, this message translates to:
  /// **'В сохранённые'**
  String get recipeFormSaveToSaved;

  /// No description provided for @recipeFormPublish.
  ///
  /// In ru, this message translates to:
  /// **'Опубликовать рецепт'**
  String get recipeFormPublish;

  /// No description provided for @recipeFormSaving.
  ///
  /// In ru, this message translates to:
  /// **'Сохранение...'**
  String get recipeFormSaving;

  /// No description provided for @recipeFormPublishing.
  ///
  /// In ru, this message translates to:
  /// **'Публикация...'**
  String get recipeFormPublishing;

  /// No description provided for @recipeFormDraftSaved.
  ///
  /// In ru, this message translates to:
  /// **'Черновик сохранён'**
  String get recipeFormDraftSaved;

  /// No description provided for @recipeFormSavedRecipeAdded.
  ///
  /// In ru, this message translates to:
  /// **'Рецепт добавлен в сохранённые'**
  String get recipeFormSavedRecipeAdded;

  /// No description provided for @recipeFormPublished.
  ///
  /// In ru, this message translates to:
  /// **'Рецепт опубликован'**
  String get recipeFormPublished;

  /// No description provided for @recipeFormPublishFailed.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось опубликовать рецепт'**
  String get recipeFormPublishFailed;

  /// No description provided for @recipeFormFillRequired.
  ///
  /// In ru, this message translates to:
  /// **'Заполните обязательные поля'**
  String get recipeFormFillRequired;

  /// No description provided for @recipeFormErrorPhoto.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте фото рецепта'**
  String get recipeFormErrorPhoto;

  /// No description provided for @recipeFormErrorName.
  ///
  /// In ru, this message translates to:
  /// **'Введите название рецепта'**
  String get recipeFormErrorName;

  /// No description provided for @recipeFormErrorDescription.
  ///
  /// In ru, this message translates to:
  /// **'Введите описание'**
  String get recipeFormErrorDescription;

  /// No description provided for @recipeFormErrorCookingTime.
  ///
  /// In ru, this message translates to:
  /// **'Введите время приготовления больше 0'**
  String get recipeFormErrorCookingTime;

  /// No description provided for @recipeFormErrorCategories.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте хотя бы одну категорию'**
  String get recipeFormErrorCategories;

  /// No description provided for @recipeFormErrorIngredients.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте хотя бы один ингредиент с количеством и единицей'**
  String get recipeFormErrorIngredients;

  /// No description provided for @recipeFormErrorSteps.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте хотя бы один шаг с заголовком и описанием'**
  String get recipeFormErrorSteps;

  /// No description provided for @recipeFormStepTitleHint.
  ///
  /// In ru, this message translates to:
  /// **'Заголовок шага'**
  String get recipeFormStepTitleHint;

  /// No description provided for @recipeFormStepDescriptionHint.
  ///
  /// In ru, this message translates to:
  /// **'Описание шага'**
  String get recipeFormStepDescriptionHint;

  /// No description provided for @commonOfflineMessage.
  ///
  /// In ru, this message translates to:
  /// **'Нет подключения к интернету. Подключитесь к сети и обновите страницу.'**
  String get commonOfflineMessage;

  /// No description provided for @commonRefresh.
  ///
  /// In ru, this message translates to:
  /// **'Обновить'**
  String get commonRefresh;

  /// No description provided for @commonBack.
  ///
  /// In ru, this message translates to:
  /// **'Назад'**
  String get commonBack;

  /// No description provided for @commonCancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get commonDelete;

  /// No description provided for @commonGramShort.
  ///
  /// In ru, this message translates to:
  /// **'г'**
  String get commonGramShort;

  /// No description provided for @commonKcalShort.
  ///
  /// In ru, this message translates to:
  /// **'ккал'**
  String get commonKcalShort;

  /// No description provided for @commonMinutes.
  ///
  /// In ru, this message translates to:
  /// **'{value} мин'**
  String commonMinutes(Object value);

  /// No description provided for @commonServings.
  ///
  /// In ru, this message translates to:
  /// **'{value} порций'**
  String commonServings(Object value);

  /// No description provided for @commonServingsDouble.
  ///
  /// In ru, this message translates to:
  /// **'{value} порций'**
  String commonServingsDouble(Object value);

  /// No description provided for @authBarSignIn.
  ///
  /// In ru, this message translates to:
  /// **'Вход'**
  String get authBarSignIn;

  /// No description provided for @authBarSignUp.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get authBarSignUp;

  /// No description provided for @authBarRestore.
  ///
  /// In ru, this message translates to:
  /// **'Восстановление'**
  String get authBarRestore;

  /// No description provided for @authTopSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'ИСКУССТВО ДОМАШНЕЙ КУХНИ'**
  String get authTopSubtitle;

  /// No description provided for @authDividerOr.
  ///
  /// In ru, this message translates to:
  /// **'ИЛИ ЧЕРЕЗ'**
  String get authDividerOr;

  /// No description provided for @authLoginLabel.
  ///
  /// In ru, this message translates to:
  /// **'ЛОГИН'**
  String get authLoginLabel;

  /// No description provided for @authLoginHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите логин'**
  String get authLoginHint;

  /// No description provided for @authEmailHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите email'**
  String get authEmailHint;

  /// No description provided for @authPasswordLabel.
  ///
  /// In ru, this message translates to:
  /// **'ПАРОЛЬ'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль'**
  String get authPasswordHint;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In ru, this message translates to:
  /// **'ПОВТОРИТЕ ПАРОЛЬ'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authConfirmPasswordHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль повторно'**
  String get authConfirmPasswordHint;

  /// No description provided for @authSignInButton.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get authSignInButton;

  /// No description provided for @authSignInWrongLogin.
  ///
  /// In ru, this message translates to:
  /// **'Неправильный логин'**
  String get authSignInWrongLogin;

  /// No description provided for @authSignInWrongPassword.
  ///
  /// In ru, this message translates to:
  /// **'Неправильный пароль'**
  String get authSignInWrongPassword;

  /// No description provided for @authSignUpButton.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get authSignUpButton;

  /// No description provided for @authSignUpLoginTaken.
  ///
  /// In ru, this message translates to:
  /// **'Логин занят'**
  String get authSignUpLoginTaken;

  /// No description provided for @authSignUpEmailTaken.
  ///
  /// In ru, this message translates to:
  /// **'Почта занята'**
  String get authSignUpEmailTaken;

  /// No description provided for @authRestoreLoginOrEmailLabel.
  ///
  /// In ru, this message translates to:
  /// **'ЛОГИН ИЛИ EMAIL'**
  String get authRestoreLoginOrEmailLabel;

  /// No description provided for @authRestoreLoginOrEmailHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите логин или email'**
  String get authRestoreLoginOrEmailHint;

  /// No description provided for @authRestoreWrongLoginOrEmail.
  ///
  /// In ru, this message translates to:
  /// **'Неверный логин или email'**
  String get authRestoreWrongLoginOrEmail;

  /// No description provided for @authRestoreButton.
  ///
  /// In ru, this message translates to:
  /// **'Восстановить'**
  String get authRestoreButton;

  /// No description provided for @changePasswordTitle.
  ///
  /// In ru, this message translates to:
  /// **'Смена пароля'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordNewPasswordLabel.
  ///
  /// In ru, this message translates to:
  /// **'НОВЫЙ ПАРОЛЬ'**
  String get changePasswordNewPasswordLabel;

  /// No description provided for @changePasswordNewPasswordHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите новый пароль'**
  String get changePasswordNewPasswordHint;

  /// No description provided for @changePasswordSubmit.
  ///
  /// In ru, this message translates to:
  /// **'Сменить'**
  String get changePasswordSubmit;

  /// No description provided for @otpTitle.
  ///
  /// In ru, this message translates to:
  /// **'Код подтверждения'**
  String get otpTitle;

  /// No description provided for @otpInvalidCode.
  ///
  /// In ru, this message translates to:
  /// **'Неверный код'**
  String get otpInvalidCode;

  /// No description provided for @otpResend.
  ///
  /// In ru, this message translates to:
  /// **'Отправить повторно{suffix}'**
  String otpResend(Object suffix);

  /// No description provided for @otpResendAfter.
  ///
  /// In ru, this message translates to:
  /// **' через {seconds} секунд'**
  String otpResendAfter(Object seconds);

  /// No description provided for @otpChangeAccount.
  ///
  /// In ru, this message translates to:
  /// **'Сменить аккаунт'**
  String get otpChangeAccount;

  /// No description provided for @recipeSavedTitle.
  ///
  /// In ru, this message translates to:
  /// **'Моя кухня'**
  String get recipeSavedTitle;

  /// No description provided for @recipeSavedEmptyMessage.
  ///
  /// In ru, this message translates to:
  /// **'Здесь пока пусто. Сохраняйте понравившиеся рецепты из ленты, чтобы не потерять их'**
  String get recipeSavedEmptyMessage;

  /// No description provided for @recipeSavedFind.
  ///
  /// In ru, this message translates to:
  /// **'Найти'**
  String get recipeSavedFind;

  /// No description provided for @recipeDraftsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Черновики'**
  String get recipeDraftsTitle;

  /// No description provided for @recipeDraftsEmptyMessage.
  ///
  /// In ru, this message translates to:
  /// **'Здесь пока пусто. Создавайте свои собственные кулинарные шедевры'**
  String get recipeDraftsEmptyMessage;

  /// No description provided for @recipeDraftsCreate.
  ///
  /// In ru, this message translates to:
  /// **'Создать'**
  String get recipeDraftsCreate;

  /// No description provided for @recipeDraftsUntitled.
  ///
  /// In ru, this message translates to:
  /// **'Без названия'**
  String get recipeDraftsUntitled;

  /// No description provided for @recipeDraftsDeleteTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить черновик?'**
  String get recipeDraftsDeleteTitle;

  /// No description provided for @recipeDraftsUpdated.
  ///
  /// In ru, this message translates to:
  /// **'Обновлено: {value}'**
  String recipeDraftsUpdated(Object value);

  /// No description provided for @recipeDetailIngredients.
  ///
  /// In ru, this message translates to:
  /// **'Ингредиенты'**
  String get recipeDetailIngredients;

  /// No description provided for @recipeDetailSteps.
  ///
  /// In ru, this message translates to:
  /// **'Шаги'**
  String get recipeDetailSteps;

  /// No description provided for @recipeDetailTime.
  ///
  /// In ru, this message translates to:
  /// **'Время'**
  String get recipeDetailTime;

  /// No description provided for @recipeDetailProteinSign.
  ///
  /// In ru, this message translates to:
  /// **'Б'**
  String get recipeDetailProteinSign;

  /// No description provided for @recipeDetailFatSign.
  ///
  /// In ru, this message translates to:
  /// **'Ж'**
  String get recipeDetailFatSign;

  /// No description provided for @recipeDetailCarbsSign.
  ///
  /// In ru, this message translates to:
  /// **'У'**
  String get recipeDetailCarbsSign;

  /// No description provided for @recipeDifficultyEasy.
  ///
  /// In ru, this message translates to:
  /// **'ЛЕГКО'**
  String get recipeDifficultyEasy;

  /// No description provided for @recipeDifficultyMedium.
  ///
  /// In ru, this message translates to:
  /// **'СРЕДНЕ'**
  String get recipeDifficultyMedium;

  /// No description provided for @recipeDifficultyHard.
  ///
  /// In ru, this message translates to:
  /// **'СЛОЖНО'**
  String get recipeDifficultyHard;

  /// No description provided for @commonLanguageRu.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get commonLanguageRu;

  /// No description provided for @commonLanguageEn.
  ///
  /// In ru, this message translates to:
  /// **'English'**
  String get commonLanguageEn;

  /// No description provided for @commonError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get commonError;

  /// No description provided for @searchTitle.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get searchTitle;

  /// No description provided for @searchButton.
  ///
  /// In ru, this message translates to:
  /// **'ПОИСК'**
  String get searchButton;

  /// No description provided for @searchNothingFound.
  ///
  /// In ru, this message translates to:
  /// **'Ничего не найдено'**
  String get searchNothingFound;

  /// No description provided for @searchRecipeNameHint.
  ///
  /// In ru, this message translates to:
  /// **'Название рецепта'**
  String get searchRecipeNameHint;

  /// No description provided for @searchCookingTimeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Время приготовления'**
  String get searchCookingTimeTitle;

  /// No description provided for @searchCookingTimeUpTo.
  ///
  /// In ru, this message translates to:
  /// **'до {value} мин'**
  String searchCookingTimeUpTo(Object value);

  /// No description provided for @searchNutritionGoals.
  ///
  /// In ru, this message translates to:
  /// **'Цели в питании'**
  String get searchNutritionGoals;

  /// No description provided for @searchCaloriesLabel.
  ///
  /// In ru, this message translates to:
  /// **'КАЛОРИИ'**
  String get searchCaloriesLabel;

  /// No description provided for @searchProteinsLabel.
  ///
  /// In ru, this message translates to:
  /// **'БЕЛКИ'**
  String get searchProteinsLabel;

  /// No description provided for @searchFatsLabel.
  ///
  /// In ru, this message translates to:
  /// **'ЖИРЫ'**
  String get searchFatsLabel;

  /// No description provided for @searchCarbsLabel.
  ///
  /// In ru, this message translates to:
  /// **'УГЛЕВОДЫ'**
  String get searchCarbsLabel;

  /// No description provided for @searchCategoriesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Категории'**
  String get searchCategoriesTitle;

  /// No description provided for @searchIngredientsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ингредиенты'**
  String get searchIngredientsTitle;

  /// No description provided for @searchAddCategoryHint.
  ///
  /// In ru, this message translates to:
  /// **'Добавить категорию...'**
  String get searchAddCategoryHint;

  /// No description provided for @searchAddIngredientHint.
  ///
  /// In ru, this message translates to:
  /// **'Добавить ингредиент...'**
  String get searchAddIngredientHint;

  /// No description provided for @searchAddCategory.
  ///
  /// In ru, this message translates to:
  /// **'Добавить категорию'**
  String get searchAddCategory;

  /// No description provided for @searchAddIngredient.
  ///
  /// In ru, this message translates to:
  /// **'Добавить ингредиент'**
  String get searchAddIngredient;

  /// No description provided for @searchCategoryNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Категории не найдены'**
  String get searchCategoryNotFound;

  /// No description provided for @searchIngredientNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Ингредиенты не найдены'**
  String get searchIngredientNotFound;

  /// No description provided for @searchCategoryHint.
  ///
  /// In ru, this message translates to:
  /// **'Здоровое питание'**
  String get searchCategoryHint;

  /// No description provided for @searchIngredientHint.
  ///
  /// In ru, this message translates to:
  /// **'Курица'**
  String get searchIngredientHint;

  /// No description provided for @searchGeneralTitle.
  ///
  /// In ru, this message translates to:
  /// **'Общее'**
  String get searchGeneralTitle;

  /// No description provided for @searchMaxCookingTimeHint.
  ///
  /// In ru, this message translates to:
  /// **'Максимальное время приготовления'**
  String get searchMaxCookingTimeHint;

  /// No description provided for @searchCaloriesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Калории'**
  String get searchCaloriesTitle;

  /// No description provided for @searchProteinsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Белки'**
  String get searchProteinsTitle;

  /// No description provided for @searchFatsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Жиры'**
  String get searchFatsTitle;

  /// No description provided for @searchCarbsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Углеводы'**
  String get searchCarbsTitle;

  /// No description provided for @searchMinHint.
  ///
  /// In ru, this message translates to:
  /// **'Мин'**
  String get searchMinHint;

  /// No description provided for @searchMaxHint.
  ///
  /// In ru, this message translates to:
  /// **'Макс'**
  String get searchMaxHint;

  /// No description provided for @validationFieldRequired.
  ///
  /// In ru, this message translates to:
  /// **'Поле не может быть пустым'**
  String get validationFieldRequired;

  /// No description provided for @validationLoginTooShort.
  ///
  /// In ru, this message translates to:
  /// **'Логин слишком короткий'**
  String get validationLoginTooShort;

  /// No description provided for @validationLoginTooLong.
  ///
  /// In ru, this message translates to:
  /// **'Логин слишком длинный'**
  String get validationLoginTooLong;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In ru, this message translates to:
  /// **'Некорректный email'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordTooShort.
  ///
  /// In ru, this message translates to:
  /// **'Пароль слишком короткий'**
  String get validationPasswordTooShort;

  /// No description provided for @validationPasswordTooLong.
  ///
  /// In ru, this message translates to:
  /// **'Пароль слишком длинный'**
  String get validationPasswordTooLong;

  /// No description provided for @validationPasswordInvalid.
  ///
  /// In ru, this message translates to:
  /// **'Пароль должен содержать строчные и заглавные латинские буквы, цифры и спец символы (@\$!%*?&_)'**
  String get validationPasswordInvalid;

  /// No description provided for @validationConfirmPasswordNotMatch.
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают'**
  String get validationConfirmPasswordNotMatch;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
