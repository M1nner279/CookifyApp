using CookifyAPI.Data;
using CookifyAPI.DTOs;
using CookifyAPI.DTOs.Recipes;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public interface IRecipeService
{
    Task<IEnumerable<RecipeListDto>> GetRecipesListAsync();
    Task<RecipeDetailDto?> GetRecipeByIdAsync(int id);
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
                    .ToList(),
                PreviewImageUrl = r.Images
                    .OrderBy(i => i.Order)
                    .Select(i => i.Url)
                    .FirstOrDefault()
            })
            .ToListAsync();
        
        
    }
    
    public async Task<RecipeDetailDto?> GetRecipeByIdAsync(int id)
    {
        return await _context.Recipes
            .Where(r => r.Id == id)
            .Select(r => new RecipeDetailDto
            {
                Id = r.Id,
                Title = r.Title,
                CookingTimeMinutes = r.CookingTimeMin,
                Servings = r.Servings,
                AuthorId = r.AuthorId,
                Calories100g = r.Calories100g,
                Protein100g = r.Protein100g,
                Fat100g = r.Fat100g,
                Carb100g = r.Carb100g,
                CreatedAt = r.CreatedAt,
                Description = r.Description,
                Difficulty = r.Difficulty,

                Images = r.Images
                    .OrderBy(i => i.Order)
                    .Select(i => new RecipeImageDto
                    {
                        Id = i.Id,
                        Url = i.Url,
                        Order = i.Order
                    })
                    .ToList(),

                Steps = r.Steps
                    .OrderBy(s => s.StepNumber)
                    .Select(s => new RecipeStepDto
                    {
                        Id = s.Id,
                        Title = s.Title,
                        StepNumber = s.StepNumber,
                        Description = s.Description,
                        ImageUrl = s.ImageUrl
                    })
                    .ToList(),
                Tags = r.Tags
                    .Select(rt => rt.Tag.Name)
                    .ToList(),
                Ingredients = r.Ingredients
                    .Select(ri => new IngredientDto
                    {
                        Id = ri.Ingredient.Id,
                        Name = ri.Ingredient.Name,
                        Calories100g = r.Calories100g,
                        Protein100g = r.Protein100g,
                        Fat100g = r.Fat100g,
                        Carb100g = r.Carb100g,
                        Amount = ri.Amount,
                        Unit = ri.Unit
                    })
                    .ToList()
            })
            .FirstOrDefaultAsync();
    }
}