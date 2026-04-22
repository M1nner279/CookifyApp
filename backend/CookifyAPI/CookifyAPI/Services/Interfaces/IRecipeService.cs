using CookifyAPI.Models.DTOs.Pagination;
using CookifyAPI.Models.DTOs.Recipes;

namespace CookifyAPI.Services;

public interface IRecipeService
{
    Task<IEnumerable<RecipeListDto>> GetRecipesListAsync();
    Task<RecipeDetailDto?> GetRecipeByIdAsync(int id);
    Task<OffsetPagedResult<RecipeListDto>> GetRecipesOffsetAsync(int page);
    Task<KeysetPagedResult<RecipeListDto>> GetRecipesKeysetAsync(int? lastId);
}