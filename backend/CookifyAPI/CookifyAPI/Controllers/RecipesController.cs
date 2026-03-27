using CookifyAPI.Data;
using CookifyAPI.DTOs.Recipes;
using CookifyAPI.Models;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class RecipesController : ControllerBase
{
    // private readonly AppDbContext _db;
    //
    // public RecipesController(AppDbContext db)
    // {
    //     _db = db;
    // }
    
    private readonly IRecipeService _service;

    public RecipesController(IRecipeService service)
    {
        _service = service;
    }

    // GET: api/recipes
    [HttpGet]
    public async Task<ActionResult<IEnumerable<RecipeListDto>>> GetRecipes()
    {
        var recipes = await _service.GetRecipesListAsync();
        return Ok(recipes);
    }
    
    // GET: api/recipes/{id}
    [HttpGet("{id}")]
    public async Task<ActionResult<RecipeDetailDto>> GetRecipe(int id)
    {
        var recipe = await _service.GetRecipeByIdAsync(id);
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