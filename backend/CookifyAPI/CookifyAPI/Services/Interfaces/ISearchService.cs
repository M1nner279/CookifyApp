using CookifyAPI.Models.DTOs.Search;

namespace CookifyAPI.Services;

public interface ISearchService
{
    // Методы поиска (возвращают готовые списки)
    Task<IReadOnlyCollection<TagSearchDocument>> SearchTagsAsync(string query, int limit = 20);
    Task<IReadOnlyCollection<IngredientSearchDocument>> SearchIngredientsAsync(string query, int limit = 20);
    Task<int[]> SearchRecipeIdsAsync(string query, int limit = 100);
    
    // Методы синхронизации (добавление пачками для производительности)
    Task IndexTagsAsync(IEnumerable<TagSearchDocument> tags);
    Task IndexIngredientsAsync(IEnumerable<IngredientSearchDocument> ingredients);
    Task IndexRecipesAsync(IEnumerable<RecipeSearchDocument> recipes);

    // Первоначальная настройка индексов
    Task SetupIndicesAsync();
}