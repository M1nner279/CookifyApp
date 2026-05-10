using CookifyAPI.Data;
using CookifyAPI.Models.DTOs;
using CookifyAPI.Models.DTOs.Pagination;
using CookifyAPI.Models.DTOs.Recipes;
using CookifyAPI.Models.DTOs.Requests;
using CookifyAPI.Models.Entities;
using CookifyAPI.Services;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public class RecipeService(
    AppDbContext context,
    ISearchService searchService) : IRecipeService
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
            .AsSplitQuery()
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

    public async Task<List<RecipeDetailDto>> SearchRecipesDetailedAsync(RecipeSearchRequest request)
    {
        var query = context.Recipes.AsNoTracking();
        
        if (!string.IsNullOrWhiteSpace(request.Title))
        {
            var recipeIds = await searchService.SearchRecipeIdsAsync(request.Title);
            
            // Если Meili ничего не нашел, возвращаем пустой список, чтобы не делать запрос к БД
            if (recipeIds.Length == 0)
            {
                Console.WriteLine($"No recipes found for {request.Title}");
                return new List<RecipeDetailDto>();
            }
            
            query = query.Where(r => recipeIds.Contains(r.Id));
        }
        
        if (request.MaxCookingTime.HasValue) query = query.Where(r => r.CookingTimeMin <= request.MaxCookingTime);
        if (request.Difficulty.HasValue) query = query.Where(r => r.Difficulty == request.Difficulty);

        // Фильтры по БЖУ и Калориям
        if (request.MinCalories.HasValue) query = query.Where(r => r.Calories100g >= request.MinCalories);
        if (request.MaxCalories.HasValue) query = query.Where(r => r.Calories100g <= request.MaxCalories);
        
        if (request.MinProtein.HasValue) query = query.Where(r => r.Protein100g >= request.MinProtein);
        if (request.MaxProtein.HasValue) query = query.Where(r => r.Protein100g <= request.MaxProtein);
        
        if (request.MinFat.HasValue) query = query.Where(r => r.Fat100g >= request.MinFat);
        if (request.MaxFat.HasValue) query = query.Where(r => r.Fat100g <= request.MaxFat);
        
        if (request.MinCarb.HasValue) query = query.Where(r => r.Carb100g >= request.MinCarb);
        if (request.MaxCarb.HasValue) query = query.Where(r => r.Carb100g <= request.MaxCarb);
        
        if (request.TagIds is { Length: > 0 })
        {
            query = query.Where(r => r.Tags.Any(t => request.TagIds.Contains(t.TagId)));
        }

        if (request.IngredientIds is { Length: > 0 })
        {
            query = query.Where(r => r.Ingredients.Any(i => request.IngredientIds.Contains(i.IngredientId)));
        }

        var recipes = await query
            .AsSplitQuery()
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

                // Маппим связанные списки (Коллекции)
                Images = r.Images.Select(img => new RecipeImageDto 
                {
                    Id = img.Id,
                    Url = img.Url // Подставьте свои поля
                }).ToList(),

                Steps = r.Steps.Select(step => new RecipeStepDto
                {
                    Id = step.Id,
                    StepNumber = step.StepNumber,
                    Description = step.Description
                }).ToList(),

                // Для M2M: Достаем Name из связанной таблицы Tag
                Tags = r.Tags.Select(m2m => m2m.Tag.Name).ToList(),

                // Для M2M: Создаем IngredientDto из связанной таблицы Ingredient
                Ingredients = r.Ingredients.Select(m2m => new IngredientDto
                {
                    Id = m2m.Ingredient.Id,
                    Name = m2m.Ingredient.Name,
                    Amount = m2m.Amount // Предположим, количество хранится в M2M таблице
                }).ToList()
            })
            .ToListAsync();

        return recipes;
    }
}