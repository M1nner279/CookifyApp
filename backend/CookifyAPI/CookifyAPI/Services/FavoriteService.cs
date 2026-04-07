using CookifyAPI.Data;
using CookifyAPI.DTOs.Favorites;
using CookifyAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public interface IFavoriteService
{
    //Task AddFavoriteAsync(int userId, int recipeId);
    Task<bool> AddFavoriteAsync(int userId, int recipeId);
    Task RemoveFavoriteAsync(int userId, int recipeId);
    Task<IEnumerable<FavoriteDto>> GetFavoritesAsync(int userId);
}

public class FavoriteService : IFavoriteService
{
    private readonly AppDbContext _context;

    public FavoriteService(AppDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<FavoriteDto>> GetFavoritesAsync(int userId)
    {
        var query = _context.Favorites
            .AsNoTracking();
            //.AsSplitQuery();

        var items = await query
            .OrderBy(f => f.RecipeId)
            .Where(f => f.UserId == userId)
            .Select(f => new FavoriteDto()
            {
                Id = f.Recipe.Id,
                Title = f.Recipe.Title,
                CookingTimeMin = f.Recipe.CookingTimeMin,
                Difficulty = f.Recipe.Difficulty,

                PreviewImageUrl = f.Recipe.Images
                    .OrderBy(i => i.Id)
                    .Select(i => i.Url)
                    .FirstOrDefault(),

                Tags = f.Recipe.Tags
                    .Select(t => t.Tag.Name)
                    .ToList()
            })
            .ToListAsync<FavoriteDto>();
        
        return items;
    }

    public async Task<bool> AddFavoriteAsync(int userId, int recipeId)
    {
        var now = DateTime.UtcNow;

        var rows = await _context.Database.ExecuteSqlInterpolatedAsync($@"
            INSERT INTO Favorites (user_id, recipe_id, added_at)
            SELECT {userId}, {recipeId}, {now}
            WHERE NOT EXISTS (
                SELECT 1 
                FROM Favorites 
                WHERE user_id = {userId} AND recipe_id = {recipeId}
            )");
        return rows > 0;
    }
    
    public async Task RemoveFavoriteAsync(int userId, int recipeId)
    {
        await _context.Database.ExecuteSqlInterpolatedAsync($@"
        DELETE FROM Favorites
        WHERE user_id = {userId} AND recipe_id = {recipeId}");
    }
}