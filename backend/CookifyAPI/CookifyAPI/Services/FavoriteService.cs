using CookifyAPI.Data;
using CookifyAPI.DTOs.Favorites;
using CookifyAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public interface IFavoriteService
{
    //Task AddFavoriteAsync(int userId, int recipeId);
    //Task RemoveFavoriteAsync(int userId, int recipeId);
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
            .AsNoTracking()
            .AsSplitQuery();

        var items = await query
            .OrderBy(f => f.RecipeId)
            .Where(f => f.UserId == userId)
            .Select(f => new FavoriteDto()
            {
                Id = f.RecipeId,
                
                Title = "",
                CookingTimeMin = 0
            })
            .ToListAsync<FavoriteDto>();
        
        return items;
    }
}