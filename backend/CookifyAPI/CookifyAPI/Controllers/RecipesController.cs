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
    private readonly IRecipeService _service;
    private readonly RecipeImportService _importService;

    public RecipesController(IRecipeService service,  RecipeImportService importService)
    {
        _service = service;
        _importService = importService;
    }
    
    // GET: api/recipes
    [HttpGet]
    public async Task<ActionResult> GetRecipesKeyset(
        int? lastId = null)
    {
        return Ok(await _service.GetRecipesKeysetAsync(lastId));
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
    
    [HttpPost("import")]
    [RequestSizeLimit(50_000_000)]
    public async Task<IActionResult> Import(IFormFile file)
    {
        if (file == null || file.Length == 0)
            return BadRequest("Файл пуст");

        using var stream = file.OpenReadStream();

        await _importService.ImportAsync(stream);

        return Ok();
    }
    
    
    // [HttpPost]
    // public async Task<IActionResult> Create(Recipe recipe)
    // {
    //     _db.Recipes.Add(recipe);
    //     await _db.SaveChangesAsync();
    //     return Ok(recipe);
    // }
}