using CookifyAPI.Data;
using CookifyAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class RecipeController : ControllerBase
{
    private readonly AppDbContext _db;

    public RecipeController(AppDbContext db)
    {
        _db = db;
    }

    [HttpGet]
    public async Task<IEnumerable<Recipe>> Get()
    {
        return await _db.Recipes.ToListAsync();
    }

    [HttpPost]
    public async Task<IActionResult> Create(Recipe recipe)
    {
        _db.Recipes.Add(recipe);
        await _db.SaveChangesAsync();
        return Ok(recipe);
    }
}