using CookifyAPI.Models.DTOs.Requests;
using CookifyAPI.Models.DTOs.Search;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers;

[ApiController]
[Route("api/search")]
public class SearchController(
    ISearchService searchService, 
    IRecipeService recipeService) : ControllerBase
{
    [HttpGet("tags")]
    public async Task<IActionResult> SearchTags([FromQuery] string? name, [FromQuery] int limit = 20)
    {
        if (string.IsNullOrWhiteSpace(name))
            return Ok(Array.Empty<TagSearchDocument>()); // Пустой массив, если нет запроса

        var results = await searchService.SearchTagsAsync(name, limit);
        return Ok(results);
    }

    [HttpGet("ingredients")]
    public async Task<IActionResult> SearchIngredients([FromQuery] string? name, [FromQuery] int limit = 20)
    {
        if  (string.IsNullOrWhiteSpace(name))
            return Ok(Array.Empty<IngredientSearchDocument>());
        var results = await searchService.SearchIngredientsAsync(name, limit);
        return Ok(results);
    }
    
    // [HttpGet("recipes-Detailed")]
    // public async Task<IActionResult> SearchDetailedRecipes([FromQuery] RecipeSearchRequest request)
    // {
    //     var results = await recipeService.SearchRecipesDetailedAsync(request);
    //     return Ok(results);
    // }

    [HttpGet("recipes")]
    public async Task<IActionResult> SearchRecipes([FromQuery] RecipeSearchRequest request)
    {
        var results = await recipeService.SearchRecipesAsync(request);
        return Ok(results);
    }
}