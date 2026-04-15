using CookifyAPI.DTOs.Favorites;

namespace CookifyAPI.Services.Implementations.Interfaces;

public interface IFavoriteService
{
    //Task AddFavoriteAsync(int userId, int recipeId);
    Task<bool> AddFavoriteAsync(int userId, int recipeId);
    Task RemoveFavoriteAsync(int userId, int recipeId);
    Task<IEnumerable<FavoriteDto>> GetFavoritesAsync(int userId);
}