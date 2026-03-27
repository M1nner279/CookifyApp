using CookifyAPI.Data;
using CookifyAPI.DTOs.Recipes;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public interface IRecipeService
{
    Task<IEnumerable<RecipeListDto>> GetRecipesListAsync();
}

public class RecipeService : IRecipeService
{
    private readonly AppDbContext _context;

    public RecipeService(AppDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<RecipeListDto>> GetRecipesListAsync()
    {
        return await _context.Recipes
            .Select(r => new RecipeListDto
            {
                Id = r.Id,
                Title = r.Title,
                CookingTimeMin = r.CookingTimeMin,
                Servings = r.Servings,
                Difficulty = r.Difficulty,
                Tags = r.Tags
                    .Select(rt => rt.Tag.Name)
                    .ToList()
            })
            .ToListAsync();
        
        
    }
}