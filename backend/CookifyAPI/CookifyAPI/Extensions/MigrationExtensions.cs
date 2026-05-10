using CookifyAPI.Data;
using CookifyAPI.Models.DTOs.Search;
using CookifyAPI.Services;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Extensions;

public static class MigrationExtensions
{
    public static async Task ApplyMigrations(this IApplicationBuilder app)
    {
        using var scope = app.ApplicationServices.CreateScope();
        var services = scope.ServiceProvider;
        
        var db = services.GetRequiredService<AppDbContext>();
        var searchService = services.GetRequiredService<ISearchService>();

        // Попытка применить миграции несколько раз (защита от медленного старта БД)
        var retries = 20;
        var dbReady = false;

        while (retries > 0)
            try
            {
                db.Database.Migrate();
                Console.WriteLine("Database check/migration completed successfully.");
                dbReady = true;
                break;
            }
            catch (Exception ex)
            {
                retries--;
                if (retries == 0)
                {
                    Console.WriteLine("CRITICAL ERROR: Database is not ready after multiple retries.");
                    throw; // Приложение упадет, и Docker его перезапустит
                }

                Console.WriteLine($"WARNING: Database is starting up... waiting. ({retries} attempts left)");
                Thread.Sleep(10000);
            }

        if (dbReady)
            try
            {
                Console.WriteLine("Starting Meilisearch index synchronization...");
                await searchService.SetupIndicesAsync();

                // Синхронизируем Ингредиенты
                var ingredients = await db.Ingredients
                    .AsNoTracking()
                    .Select(i => new IngredientSearchDocument(i.Id, i.Name, i.Calories100g,  i.Protein100g, i.Fat100g, i.Carb100g))
                    .ToListAsync();
                
                if (ingredients.Count != 0)
                    await searchService.IndexIngredientsAsync(ingredients);

                // Синхронизируем Теги
                var tags = await db.Tags
                    .AsNoTracking()
                    .Select(t => new TagSearchDocument(t.Id, t.Name))
                    .ToListAsync();

                if (tags.Count != 0)
                    await searchService.IndexTagsAsync(tags);
                
                // Синхронизируем Рецепты
                var recipes = await db.Recipes
                    .AsNoTracking()
                    .Select(r => new RecipeSearchDocument(r.Id, r.Title))
                    .ToListAsync();
                
                if (recipes.Count != 0)
                    await searchService.IndexRecipesAsync(recipes);

                Console.WriteLine("Meilisearch synchronization completed successfully.");
                
            }
            catch (Exception ex)
            {
                Console.WriteLine($"ERROR: Failed to sync Meilisearch: {ex.Message}");
            }
    }
}