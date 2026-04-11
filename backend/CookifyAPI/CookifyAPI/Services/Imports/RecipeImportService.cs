using System.Text.Json;
using CookifyAPI.Data;
using CookifyAPI.DTOs.Recipes;
using CookifyAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public class RecipeImportService
{
    private readonly AppDbContext _context;

    public RecipeImportService(AppDbContext context)
    {
        _context = context;
    }

    public async Task ImportAsync(Stream stream)
    {
        var recipes = await JsonSerializer.DeserializeAsync<List<JsonRecipeDto>>(stream);

        if (recipes == null || recipes.Count == 0)
            return;

        // --- 1. PRELOAD ---

        var ingredientNames = recipes
            .SelectMany(r => r.Ingredients)
            .Select(i => Normalize(i.Name))
            .Distinct()
            .ToList();

        var tagNames = recipes
            .SelectMany(r => r.Tags)
            .Select(Normalize)
            .Distinct()
            .ToList();

        var ingredients = await _context.Ingredients
            .Where(i => ingredientNames.Contains(i.Name))
            .ToListAsync();

        var tags = await _context.Tags
            .Where(t => tagNames.Contains(t.Name))
            .ToListAsync();

        var ingredientDict = ingredients.ToDictionary(i => i.Name);
        var tagDict = tags.ToDictionary(t => t.Name);
        
        var adminId = await _context.Users
            .Where(u => u.Username == "admin")
            .Select(u => u.Id)
            .FirstOrDefaultAsync();

        if (adminId == 0)
            throw new Exception("Admin not found");

        // --- 2. ИМПОРТ ---

        foreach (var dto in recipes)
        {
            var recipe = new Recipe
            {
                AuthorId = adminId,
                Title = dto.Title,
                Description = dto.Description,
                CookingTimeMin = dto.CookingTimeMin,
                Servings = dto.Servings,
                Difficulty = 0,//dto.DifficultyText,

                Calories100g = dto.Calories,
                Protein100g = dto.Protein,
                Fat100g = dto.Fat,
                Carb100g = dto.Carb,

                Ingredients = new List<M2MRecipeIngredient>(),
                Tags = new List<M2MRecipeTag>(),
                Steps = new List<RecipeStep>(),
                Images = new List<RecipeImage>()
            };

            // --- INGREDIENTS ---
            foreach (var ing in dto.Ingredients
                         .GroupBy(i => Normalize(i.Name))
                         .Select(g => g.First()))
            {
                var normalized = Normalize(ing.Name);

                if (!ingredientDict.TryGetValue(normalized, out var ingredient))
                    continue; // или логировать

                recipe.Ingredients.Add(new M2MRecipeIngredient
                {
                    IngredientId = ingredient.Id,
                    Amount = ing.Amount,
                    Unit = ing.Unit
                });
            }

            // --- TAGS ---
            foreach (var tagName in dto.Tags
                         .Select(Normalize)
                         .Distinct())
            {
                if (!tagDict.TryGetValue(tagName, out var tag))
                    continue;

                recipe.Tags.Add(new M2MRecipeTag
                {
                    TagId = tag.Id
                });
            }

            // --- STEPS ---
            recipe.Steps = dto.Steps
                .OrderBy(s => s.StepNumber)
                .Select(s => new RecipeStep
                {
                    Title = s.Title,
                    StepNumber = s.StepNumber,
                    Description = s.Description,
                    ImageUrl = s.ImageUrl
                })
                .ToList();

            // --- IMAGES ---
            recipe.Images = dto.Images
                .Select(url => new RecipeImage
                {
                    Url = url   //несоответствие, отсутствует очередность
                })
                .ToList();

            _context.Recipes.Add(recipe);
        }

        await _context.SaveChangesAsync();
    }

    private string Normalize(string name)
    {
        return name?.Trim().ToLowerInvariant() ?? string.Empty;
    }
}