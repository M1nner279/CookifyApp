using CookifyAPI.Models.Entities;

namespace CookifyAPI.Services;

public interface ITokenService {
    string GenerateAccessToken(User user);
    string GenerateRefreshToken();
}