// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get profileTitle => 'Profile';

  @override
  String profileUserInfoCreatedAt(Object date) {
    return 'In the kitchen since $date';
  }

  @override
  String get profileUserStatisticInfoFavorite => 'Saved';

  @override
  String get profileUserStatisticInfoCreated => 'Created';

  @override
  String get profileUserStatisticInfoPublished => 'Published';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileSettingsLocale => 'Change language';

  @override
  String get profileSettingsChangePassword => 'Change password';

  @override
  String get profileSettingsSignout => 'Sign out';

  @override
  String get recipeFormTitle => 'Create recipe';

  @override
  String get recipeFormAddPhoto => 'Add photo';

  @override
  String get recipeFormNameLabel => 'RECIPE NAME';

  @override
  String get recipeFormNameHint => 'Name of your masterpiece';

  @override
  String get recipeFormDescriptionLabel => 'DESCRIPTION';

  @override
  String get recipeFormDescriptionHint => 'Tell us why it is delicious...';

  @override
  String get recipeFormNutrition => 'NUTRITION';

  @override
  String get recipeFormProtein => 'PROTEIN';

  @override
  String get recipeFormFat => 'FAT';

  @override
  String get recipeFormCarbs => 'CARBS';

  @override
  String get recipeFormCalories => 'CALORIES';

  @override
  String get recipeFormDifficulty => 'DIFFICULTY';

  @override
  String get recipeFormDifficultyEasy => 'EASY';

  @override
  String get recipeFormDifficultyMedium => 'MEDIUM';

  @override
  String get recipeFormDifficultyHard => 'HARD';

  @override
  String get recipeFormCookingTimeLabel => 'COOKING TIME';

  @override
  String get recipeFormCookingTimeHint => '45 minutes';

  @override
  String get recipeFormCategories => 'CATEGORIES';

  @override
  String get recipeFormAddCategory => 'Add category';

  @override
  String get recipeFormIngredients => 'INGREDIENTS';

  @override
  String get recipeFormAddIngredient => 'Add ingredient';

  @override
  String get recipeFormSteps => 'COOKING STEPS';

  @override
  String get recipeFormAddStep => 'ADD STEP';

  @override
  String get recipeFormSaveDraft => 'Save draft';

  @override
  String get recipeFormSaveToSaved => 'Save to favorites';

  @override
  String get recipeFormPublish => 'Publish recipe';

  @override
  String get recipeFormSaving => 'Saving...';

  @override
  String get recipeFormPublishing => 'Publishing...';

  @override
  String get recipeFormDraftSaved => 'Draft saved';

  @override
  String get recipeFormSavedRecipeAdded => 'Recipe added to saved';

  @override
  String get recipeFormPublished => 'Recipe published';

  @override
  String get recipeFormPublishFailed => 'Failed to publish recipe';

  @override
  String get recipeFormFillRequired => 'Please fill in required fields';

  @override
  String get recipeFormErrorPhoto => 'Add a recipe photo';

  @override
  String get recipeFormErrorName => 'Enter recipe name';

  @override
  String get recipeFormErrorDescription => 'Enter description';

  @override
  String get recipeFormErrorCookingTime => 'Enter cooking time greater than 0';

  @override
  String get recipeFormErrorCategories => 'Add at least one category';

  @override
  String get recipeFormErrorIngredients =>
      'Add at least one ingredient with amount and unit';

  @override
  String get recipeFormErrorSteps =>
      'Add at least one step with title and description';

  @override
  String get recipeFormStepTitleHint => 'Step title';

  @override
  String get recipeFormStepDescriptionHint => 'Step description';

  @override
  String get commonOfflineMessage =>
      'No internet connection. Connect to the network and refresh the page.';

  @override
  String get commonRefresh => 'Refresh';

  @override
  String get commonBack => 'Back';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonGramShort => 'g';

  @override
  String get commonKcalShort => 'kcal';

  @override
  String commonMinutes(Object value) {
    return '$value min';
  }

  @override
  String commonServings(Object value) {
    return '$value servings';
  }

  @override
  String commonServingsDouble(Object value) {
    return '$value servings';
  }

  @override
  String get authBarSignIn => 'Sign in';

  @override
  String get authBarSignUp => 'Sign up';

  @override
  String get authBarRestore => 'Restore';

  @override
  String get authTopSubtitle => 'THE ART OF HOME COOKING';

  @override
  String get authDividerOr => 'OR WITH';

  @override
  String get authLoginLabel => 'LOGIN';

  @override
  String get authLoginHint => 'Enter login';

  @override
  String get authEmailHint => 'Enter email';

  @override
  String get authPasswordLabel => 'PASSWORD';

  @override
  String get authPasswordHint => 'Enter password';

  @override
  String get authConfirmPasswordLabel => 'CONFIRM PASSWORD';

  @override
  String get authConfirmPasswordHint => 'Enter password again';

  @override
  String get authSignInButton => 'Sign in';

  @override
  String get authSignInWrongLogin => 'Invalid login';

  @override
  String get authSignInWrongPassword => 'Invalid password';

  @override
  String get authSignUpButton => 'Sign up';

  @override
  String get authSignUpLoginTaken => 'Login already taken';

  @override
  String get authSignUpEmailTaken => 'Email already taken';

  @override
  String get authRestoreLoginOrEmailLabel => 'LOGIN OR EMAIL';

  @override
  String get authRestoreLoginOrEmailHint => 'Enter login or email';

  @override
  String get authRestoreWrongLoginOrEmail => 'Invalid login or email';

  @override
  String get authRestoreButton => 'Restore';

  @override
  String get changePasswordTitle => 'Change password';

  @override
  String get changePasswordNewPasswordLabel => 'NEW PASSWORD';

  @override
  String get changePasswordNewPasswordHint => 'Enter new password';

  @override
  String get changePasswordSubmit => 'Change';

  @override
  String get otpTitle => 'Confirmation code';

  @override
  String get otpInvalidCode => 'Invalid code';

  @override
  String otpResend(Object suffix) {
    return 'Resend$suffix';
  }

  @override
  String otpResendAfter(Object seconds) {
    return ' in $seconds seconds';
  }

  @override
  String get otpChangeAccount => 'Change account';

  @override
  String get recipeSavedTitle => 'My kitchen';

  @override
  String get recipeSavedEmptyMessage =>
      'Nothing here yet. Save recipes you like from the feed so you do not lose them';

  @override
  String get recipeSavedFind => 'Find';

  @override
  String get recipeDraftsTitle => 'Drafts';

  @override
  String get recipeDraftsEmptyMessage =>
      'Nothing here yet. Create your own culinary masterpieces';

  @override
  String get recipeDraftsCreate => 'Create';

  @override
  String get recipeDraftsUntitled => 'Untitled';

  @override
  String get recipeDraftsDeleteTitle => 'Delete draft?';

  @override
  String recipeDraftsUpdated(Object value) {
    return 'Updated: $value';
  }

  @override
  String get recipeDetailIngredients => 'Ingredients';

  @override
  String get recipeDetailSteps => 'Steps';

  @override
  String get recipeDetailTime => 'Time';

  @override
  String get recipeDetailProteinSign => 'P';

  @override
  String get recipeDetailFatSign => 'F';

  @override
  String get recipeDetailCarbsSign => 'C';

  @override
  String get recipeDifficultyEasy => 'EASY';

  @override
  String get recipeDifficultyMedium => 'MEDIUM';

  @override
  String get recipeDifficultyHard => 'HARD';

  @override
  String get commonLanguageRu => 'Russian';

  @override
  String get commonLanguageEn => 'English';

  @override
  String get commonError => 'Error';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchButton => 'SEARCH';

  @override
  String get searchNothingFound => 'Nothing found';

  @override
  String get searchRecipeNameHint => 'Recipe name';

  @override
  String get searchCookingTimeTitle => 'Cooking time';

  @override
  String searchCookingTimeUpTo(Object value) {
    return 'up to $value min';
  }

  @override
  String get recipeSearchText => 'No recipes found with the specified filters';

  @override
  String get searchNutritionGoals => 'Nutrition goals';

  @override
  String get searchCaloriesLabel => 'CALORIES';

  @override
  String get searchProteinsLabel => 'PROTEINS';

  @override
  String get searchFatsLabel => 'FATS';

  @override
  String get searchCarbsLabel => 'CARBS';

  @override
  String get searchCategoriesTitle => 'Categories';

  @override
  String get searchIngredientsTitle => 'Ingredients';

  @override
  String get searchAddCategoryHint => 'Add category...';

  @override
  String get searchAddIngredientHint => 'Add ingredient...';

  @override
  String get searchAddCategory => 'Add category';

  @override
  String get searchAddIngredient => 'Add ingredient';

  @override
  String get searchCategoryNotFound => 'No categories found';

  @override
  String get searchIngredientNotFound => 'No ingredients found';

  @override
  String get searchCategoryHint => 'Healthy eating';

  @override
  String get searchIngredientHint => 'Chicken';

  @override
  String get searchGeneralTitle => 'General';

  @override
  String get searchMaxCookingTimeHint => 'Maximum cooking time';

  @override
  String get searchCaloriesTitle => 'Calories';

  @override
  String get searchProteinsTitle => 'Proteins';

  @override
  String get searchFatsTitle => 'Fats';

  @override
  String get searchCarbsTitle => 'Carbohydrates';

  @override
  String get searchMinHint => 'Min';

  @override
  String get searchMaxHint => 'Max';

  @override
  String get validationFieldRequired => 'Field cannot be empty';

  @override
  String get validationLoginTooShort => 'Login is too short';

  @override
  String get validationLoginTooLong => 'Login is too long';

  @override
  String get validationEmailInvalid => 'Invalid email';

  @override
  String get validationPasswordTooShort => 'Password is too short';

  @override
  String get validationPasswordTooLong => 'Password is too long';

  @override
  String get validationPasswordInvalid =>
      'Password must contain lowercase and uppercase Latin letters, digits, and special symbols (@\$!%*?&_)';

  @override
  String get validationConfirmPasswordNotMatch => 'Passwords do not match';
}
