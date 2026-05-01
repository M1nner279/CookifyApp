using CookifyAPI.Models.DTOs.Recipes;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class RecipesController(IRecipeService service) : ControllerBase
{
    // GET: api/recipes
    /// <summary>
    /// 
    /// </summary>
    /// <param name="lastId"></param>
    /// <returns></returns>
    [HttpGet]
    public async Task<ActionResult> GetRecipesKeyset(
        int? lastId = null)
    {
        return Ok(await service.GetRecipesKeysetAsync(lastId));
    }

    // GET: api/recipes/{id}
    [HttpGet("{id}")]
    public async Task<ActionResult<RecipeDetailDto>> GetRecipe(int id)
    {
        var recipe = await service.GetRecipeByIdAsync(id);
        if (recipe == null)
            return NotFound();

        return Ok(recipe);
    }


    // [HttpPost]
    // public async Task<IActionResult> Create(Recipe recipe)
    // {
    //     _db.Recipes.Add(recipe);
    //     await _db.SaveChangesAsync();
    //     return Ok(recipe);
    // }
}