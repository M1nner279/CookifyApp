using CookifyAPI.Extensions;
using CookifyAPI.Models.DTOs.Requests;
using CookifyAPI.Models.DTOs.Responses;
using CookifyAPI.Models.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace CookifyAPI.Services;

public class AuthService(
    UserManager<User> userManager, 
    ITokenService tokenService,
    IEmailService emailService,
    IOptions<AuthSettings> authSettings) : IAuthService 
{
    private readonly AuthSettings _settings = authSettings.Value;
    public async Task<AuthResponse?> LoginAsync(LoginRequest request) {
        var user = await userManager.FindByEmailAsync(request.Login) 
                   ?? await userManager.FindByNameAsync(request.Login);

        if (user == null || !await userManager.CheckPasswordAsync(user, request.Password))
            return null;

        return await UpdateTokens(user);
    }

    public async Task<AuthResponse?> RefreshAsync(RefreshRequest request) {
        var user = await userManager.Users
            .FirstOrDefaultAsync(u => u.RefreshToken == request.Refresh_token);

        if (user == null || user.RefreshTokenExpiryTime <= DateTime.UtcNow)
            return null;

        return await UpdateTokens(user);
    }

    private async Task<AuthResponse> UpdateTokens(User user) {
        var access = tokenService.GenerateAccessToken(user);
        var refresh = tokenService.GenerateRefreshToken();

        user.RefreshToken = refresh;
        user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(7);
        await userManager.UpdateAsync(user);

        return new AuthResponse(access, refresh);
    }
    
    public async Task<IdentityResult> SignUpAsync(RegisterRequest request)
    {
        var user = new User
        {
            UserName = request.Login,
            Email = request.Email,
            CreatedAt = DateTime.UtcNow
        };

        // Создаем пользователя. Пароль автоматически захешируется.
        var result = await userManager.CreateAsync(user, request.Password);
        
        if (result.Succeeded) 
        {
            // Генерируем 6-значный цифровой код
            var code = await userManager.GenerateTwoFactorTokenAsync(user, "Email");
            await emailService.SendOtpCodeAsync(user.Email!, code);
        }
        return result;
    }
    
    public async Task<AuthResponse?> VerifyCodeAsync(VerifyCodeRequest request)
    {
        var user = await userManager.FindByEmailAsync(request.Email);
        if (user == null) return null;
        
        bool isCodeValid = _settings.SkipVerification || 
                           await userManager.VerifyTwoFactorTokenAsync(user, "Email", request.Code);

        if (!isCodeValid) return null;

        // Активируем пользователя
        user.EmailConfirmed = true;
        await userManager.UpdateAsync(user);

        // Сразу возвращаем токены
        return await UpdateTokens(user);
    }
}