using CookifyAPI.Data;
using CookifyAPI.DTOs.Ingredients;
using CookifyAPI.DTOs.Pagination;
using CookifyAPI.DTOs.Recipes;
using CookifyAPI.DTOs.Steps;
using CookifyAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public interface IRecipeService
{
    Task<IEnumerable<RecipeListDto>> GetRecipesListAsync();
    Task<RecipeDetailDto?> GetRecipeByIdAsync(int id);
    Task<OffsetPagedResult<RecipeListDto>> GetRecipesOffsetAsync(int page);
    Task<KeysetPagedResult<RecipeListDto>> GetRecipesKeysetAsync(int? lastId);
}

public class RecipeService(AppDbContext context) : IRecipeService
{
    public async Task<IEnumerable<RecipeListDto>> GetRecipesListAsync()
    {
        return await context.Recipes
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
        return await context.Recipes
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
                    .Select(s => new StepDto
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
    
    public async Task<OffsetPagedResult<RecipeListDto>> GetRecipesOffsetAsync(int page)
    {
        //page = Math.Max(page, 1);
        //pageSize = Math.Clamp(pageSize, 1, 50);
        var query = context.Recipes
            .AsNoTracking()
            .AsSplitQuery();

        var total = await query.CountAsync();
        
        var result = new OffsetPagedResult<RecipeListDto>
        {
            TotalCount = total,
            Page = page
        };

        int pageSize = result.PageSize;
        
        var items = await query
            .OrderBy(r => r.Id) // обязательно
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .Select(r => new RecipeListDto
            {
                Id = r.Id,
                Title = r.Title,
                CookingTimeMin = r.CookingTimeMin,
                Servings = r.Servings,
                Difficulty = r.Difficulty,
                Tags = r.Tags.Select(t => t.Tag.Name).ToList(),
                PreviewImageUrl = r.Images
                    .OrderBy(i => i.Order)
                    .Select(i => i.Url)
                    .FirstOrDefault()
            })
            .ToListAsync();

        result.Items = items;
        return result;
    }

    private int _pageSize = 15; 
    public async Task<KeysetPagedResult<RecipeListDto>> GetRecipesKeysetAsync(int? lastId)
    {
        //_pageSize = Math.Clamp(_pageSize, 1, 50);

        IQueryable<Recipe> query = context.Recipes
            .AsNoTracking()
            .AsSplitQuery()
            .OrderBy(r => r.Id);

        if (lastId.HasValue)
        {
            query = query.Where(r => r.Id > lastId.Value);
        }

        var items = await query
            .Take(_pageSize)
            .Select(r => new RecipeListDto
            {
                Id = r.Id,
                Title = r.Title,
                CookingTimeMin = r.CookingTimeMin,
                Servings = r.Servings,
                Difficulty = r.Difficulty,
                Tags = r.Tags.Select(t => t.Tag.Name).ToList(),
                PreviewImageUrl = r.Images
                    .OrderBy(i => i.Order)
                    .Select(i => i.Url)
                    .FirstOrDefault()
            })
            .ToListAsync();

        var newLastId = items.LastOrDefault()?.Id;

        return new KeysetPagedResult<RecipeListDto>
        {
            Items = items,
            LastId = newLastId
        };
    }
}