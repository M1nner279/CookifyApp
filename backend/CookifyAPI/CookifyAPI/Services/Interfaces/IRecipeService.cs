using CookifyAPI.DTOs.Pagination;
using CookifyAPI.DTOs.Recipes;

namespace CookifyAPI.Services.Implementations.Interfaces;

public interface IRecipeService
{
    Task<IEnumerable<RecipeListDto>> GetRecipesListAsync();
    Task<RecipeDetailDto?> GetRecipeByIdAsync(int id);
    Task<OffsetPagedResult<RecipeListDto>> GetRecipesOffsetAsync(int page);
    Task<KeysetPagedResult<RecipeListDto>> GetRecipesKeysetAsync(int? lastId);
}