import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// No description provided for @cookifyCachedNetworkImageError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки изображения'**
  String get cookifyCachedNetworkImageError;

  /// No description provided for @recipeDifficultyEasy.
  ///
  /// In ru, this message translates to:
  /// **'ЛЕГКИЙ'**
  String get recipeDifficultyEasy;

  /// No description provided for @recipeDifficultyMedium.
  ///
  /// In ru, this message translates to:
  /// **'СРЕДНИЙ'**
  String get recipeDifficultyMedium;

  /// No description provided for @recipeDifficultyHard.
  ///
  /// In ru, this message translates to:
  /// **'СЛОЖНЫЙ'**
  String get recipeDifficultyHard;

  /// No description provided for @authSlogan.
  ///
  /// In ru, this message translates to:
  /// **'ИСКУССТВО ДОМАШНЕЙ КУХНИ'**
  String get authSlogan;

  /// No description provided for @homeRecipeCardCookingTime.
  ///
  /// In ru, this message translates to:
  /// **'{time} мин'**
  String homeRecipeCardCookingTime(Object time);

  /// No description provided for @homeRecipeCardServingCount.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one {{count} порция} few {{count} порции} other {{count} порций}}'**
  String homeRecipeCardServingCount(num count);

  /// No description provided for @recipeDescriptionSectionTime.
  ///
  /// In ru, this message translates to:
  /// **'Время'**
  String get recipeDescriptionSectionTime;

  /// No description provided for @recipeDescriptionSectionCookingTime.
  ///
  /// In ru, this message translates to:
  /// **'{time} мин'**
  String recipeDescriptionSectionCookingTime(Object time);

  /// No description provided for @recipeDescriptionSectionCarbs.
  ///
  /// In ru, this message translates to:
  /// **'У'**
  String get recipeDescriptionSectionCarbs;

  /// No description provided for @recipeDescriptionSectionProteins.
  ///
  /// In ru, this message translates to:
  /// **'Б'**
  String get recipeDescriptionSectionProteins;

  /// No description provided for @recipeDescriptionSectionFats.
  ///
  /// In ru, this message translates to:
  /// **'Ж'**
  String get recipeDescriptionSectionFats;

  /// No description provided for @recipeDescriptionSectionGrams.
  ///
  /// In ru, this message translates to:
  /// **'г'**
  String get recipeDescriptionSectionGrams;

  /// No description provided for @recipeDescriptionSectionCalories.
  ///
  /// In ru, this message translates to:
  /// **'ккал'**
  String get recipeDescriptionSectionCalories;

  /// No description provided for @recipeIngredientsSectionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ингредиенты'**
  String get recipeIngredientsSectionTitle;

  /// No description provided for @recipeIngredientsSectionServingCount.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one {{count} порция} few {{count} порции} many {{count} порций} other {{count} порции}}'**
  String recipeIngredientsSectionServingCount(num count);

  /// No description provided for @recipeStepsSectionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Рецепт'**
  String get recipeStepsSectionTitle;
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
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
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
