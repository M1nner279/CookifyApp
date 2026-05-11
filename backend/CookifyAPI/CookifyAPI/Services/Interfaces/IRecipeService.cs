using CookifyAPI.Models.DTOs.Pagination;
using CookifyAPI.Models.DTOs.Recipes;
using CookifyAPI.Models.DTOs.Requests;

namespace CookifyAPI.Services;

public interface IRecipeService
{
    //Task<IEnumerable<RecipeListDto>> GetRecipesListAsync();
    Task<RecipeDetailDto?> GetRecipeByIdAsync(int id);
    //Task<OffsetPagedResult<RecipeListDto>> GetRecipesOffsetAsync(int page);
    Task<KeysetPagedResult<RecipeListDto>> GetRecipesKeysetAsync(int? lastId);
    //Task<List<RecipeDetailDto>> SearchRecipesDetailedAsync(RecipeSearchRequest request);
    Task<List<RecipeListDto>> SearchRecipesAsync(RecipeSearchRequest request);
    Task<int> CreateRecipeAsync(int authorId, RecipePublishRequest publishRequest);
}