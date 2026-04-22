using CookifyAPI.Models.DTOs.Requests;
using CookifyAPI.Models.DTOs.Responses;
using Microsoft.AspNetCore.Identity;

namespace CookifyAPI.Services;

public interface IAuthService {
    Task<AuthResponse?> LoginAsync(LoginRequest request);
    Task<AuthResponse?> RefreshAsync(RefreshRequest request);
    Task<IdentityResult> RegisterAsync(RegisterRequest request);
}