using AutoMapper;
using CookifyAPI.Data;
using CookifyAPI.Models.DTOs.Responses;
using CookifyAPI.Models.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public class UserService(
    UserManager<User> userManager,
    AppDbContext context,
    IImageService imageService) : IUserService
{
    public async Task<UserInfoResponse?> GetCurrentUserProfileAsync(int userId)
    {
        var user = await userManager.FindByIdAsync(userId.ToString());

        if (user == null) return null;

        // Собираем статистику напрямую из БД через CountAsync (это быстро)
        var favoriteCount = 0;
            await context.Favorites
            .CountAsync(f => f.UserId == userId);

        var totalCreated = 0; 
            await context.Recipes
            .CountAsync();
            
        var publishedCount = await context.Recipes
            .CountAsync(r => r.AuthorId == userId);

        UserStatisticResponse statistic = new UserStatisticResponse(
            favoriteCount,
            totalCreated,
            publishedCount
        );
        
        var response = new UserInfoResponse(
            user.Id,
            user.AvatarUrl,
            user.UserName,
            user.Email,
            user.CreatedAt,
            statistic);
        
        return response;
    }
    
    public async Task<string?> UpdateAvatarAsync(int userId, IFormFile file)
    {
        var user = await context.Users.FindAsync(userId);
        if (user == null) return null;

        // Загружаем картинку в облако
        var avatarUrl = await imageService.UploadAsync(file, "avatars");
        if (avatarUrl == null) throw new Exception("Failed to upload image");

        // Обновляем сущность пользователя
        user.AvatarUrl = avatarUrl;
        await context.SaveChangesAsync();

        return avatarUrl;
    }
}