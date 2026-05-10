using CookifyAPI.Models.DTOs.Search;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers;

[ApiController]
[Route("api/search")]
public class SearchController(ISearchService searchService) : ControllerBase
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
            return Ok(Array.Empty<TagSearchDocument>());
        var results = await searchService.SearchIngredientsAsync(name, limit);
        return Ok(results);
    }
}