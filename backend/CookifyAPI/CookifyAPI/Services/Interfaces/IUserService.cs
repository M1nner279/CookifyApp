using CookifyAPI.Models.DTOs.Responses;

namespace CookifyAPI.Services;

public interface IUserService
{
    Task<UserInfoResponse?> GetCurrentUserProfileAsync(int userId);
    Task<string?> UpdateAvatarAsync(int userId, IFormFile file);
}