/// Id рецепта в «Сохранённые», привязанный к локальному черновику формы.
abstract final class UserSavedRecipeId {
  static const _prefix = 'user_recipe_';

  static String fromDraft(String draftId) => '$_prefix$draftId';

  /// Возвращает id черновика, если [savedRecipeId] — сохранённая из формы запись.
  static String? draftIdIfFromForm(String savedRecipeId) {
    if (!savedRecipeId.startsWith(_prefix)) return null;
    return savedRecipeId.substring(_prefix.length);
  }
}
