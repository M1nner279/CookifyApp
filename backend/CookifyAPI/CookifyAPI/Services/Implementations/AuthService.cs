using CookifyAPI.Extensions;
using CookifyAPI.Models.DTOs.Requests;
using CookifyAPI.Models.DTOs.Responses;
using CookifyAPI.Models.Entities;
using Google.Apis.Auth;
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

    public async Task<bool> SendOtpCodeAsync(string login)
    {
        var user = await userManager.FindByEmailAsync(login)
            ?? await userManager.FindByNameAsync(login);
        if (user == null)
            return false;

        await SendOtpInternal(user);
        return true;
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
        
        if (result.Succeeded && !_settings.SkipVerification) // влияет на отправку кода
            await SendOtpInternal(user);
        
        return result;
    }

    public async Task<AuthResponse?> ResetPasswordAsync(ResetPasswordRequest request)
    {
        var user = await userManager.FindByEmailAsync(request.Login)
            ?? await userManager.FindByNameAsync(request.Login);
        if (user == null) return null;
        
        bool isCodeValid = _settings.SkipVerification || // влияет на верификацию кода
                           await userManager.VerifyTwoFactorTokenAsync(user, "Email", request.Code);
        
        if (!isCodeValid) return null;
        
        var resetToken = await userManager.GeneratePasswordResetTokenAsync(user);
        
        var result = await userManager.ResetPasswordAsync(user, resetToken, request.NewPassword);

        if (result.Succeeded)
        {
            user.EmailConfirmed = true; // На случай если это новый юзер
            await userManager.UpdateAsync(user);
            return await UpdateTokens(user);
        }

        return null;
    }

    public async Task<AuthResponse?> GoogleAuthAsync(GoogleAuthRequest request)
    {
        GoogleJsonWebSignature.Payload payload;
        try
        {
            // 1. Проверка токена от Google
            var settings = new GoogleJsonWebSignature.ValidationSettings
            {
                Audience = new[] { _settings.GoogleClientId }
            };
            payload = await GoogleJsonWebSignature.ValidateAsync(request.IdToken, settings);
        }
        catch (InvalidJwtException ex)
        {
            // Токен подделан или просрочен
            Console.WriteLine(ex.Message);
            return null;
        }

        // 2. Ищем пользователя по Email
        var user = await userManager.FindByEmailAsync(payload.Email);

        if (user == null)
        {
            // 3. Регистрация нового пользователя "на лету"
            user = new User
            {
                UserName = payload.Email, // В качестве логина используем email
                Email = payload.Email,
                EmailConfirmed = true, // Почта от Google уже подтверждена!
                AvatarUrl = payload.Picture, // Берем аватарку из Google
                CreatedAt = DateTime.UtcNow
            };

            // Создаем пользователя БЕЗ пароля
            var result = await userManager.CreateAsync(user);

            if (!result.Succeeded)
            {
                // Логируем ошибку, если что-то пошло не так (например, БД недоступна)
                throw new Exception("Failed to create user via Google Auth");
            }
        }

        // 4. Генерируем НАШИ токены и возвращаем их
        return await UpdateTokens(user);
    }

    public async Task<AuthResponse?> VerifyCodeAsync(ConfirmOtpRequest request)
    {
        var user = await userManager.FindByEmailAsync(request.Login) 
                   ?? await userManager.FindByNameAsync(request.Login);
        if (user == null) return null;
        
        bool isCodeValid = _settings.SkipVerification || // влияет на верификацию кода
                           await userManager.VerifyTwoFactorTokenAsync(user, "Email", request.Code);

        if (!isCodeValid) return null;

        // Активируем пользователя
        user.EmailConfirmed = true;
        await userManager.UpdateAsync(user);

        // Сразу возвращаем токены
        return await UpdateTokens(user);
    }
        
    private async Task SendOtpInternal(User user)
    {
        var code = await userManager.GenerateTwoFactorTokenAsync(user, "Email");
        await emailService.SendOtpCodeAsync(user.Email!, code);
    }
    
    private async Task<AuthResponse> UpdateTokens(User user) {
        var access = tokenService.GenerateAccessToken(user);
        var refresh = tokenService.GenerateRefreshToken();

        user.RefreshToken = refresh;
        user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(7);
        await userManager.UpdateAsync(user);

        return new AuthResponse(access, refresh);
    }
}