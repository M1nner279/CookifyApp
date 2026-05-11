using System.Security.Claims;
using CookifyAPI.Models.DTOs.Recipes;
using CookifyAPI.Models.DTOs.Requests;
using CookifyAPI.Models.Entities;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class RecipesController(IRecipeService service) : AuthBaseController
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
    
    [HttpPost]
    [Authorize]
    public async Task<IActionResult> CreateRecipe([FromBody] RecipePublishRequest request)
    {
        try
        {
            var id = await service.CreateRecipeAsync(CurrentUserId, request);
            return Ok(new { id });
        }
        catch (Exception ex)
        {
            return BadRequest(new { error = ex.Message });
        }
    }


    // [HttpPost]
    // public async Task<IActionResult> Create(Recipe recipe)
    // {
    //     _db.Recipes.Add(recipe);
    //     await _db.SaveChangesAsync();
    //     return Ok(recipe);
    // }
}