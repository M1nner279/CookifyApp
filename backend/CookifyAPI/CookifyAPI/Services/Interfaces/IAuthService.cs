using CookifyAPI.Models.DTOs.Requests;
using CookifyAPI.Models.DTOs.Responses;
using Microsoft.AspNetCore.Identity;

namespace CookifyAPI.Services;

public interface IAuthService {
    Task<AuthResponse?> LoginAsync(LoginRequest request);
    Task<AuthResponse?> RefreshAsync(RefreshRequest request);
    Task<IdentityResult> SignUpAsync(RegisterRequest request);
    Task<AuthResponse?> VerifyCodeAsync(VerifyCodeRequest request);
}