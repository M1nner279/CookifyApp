using System.Text;
using CookifyAPI.Data;
using CookifyAPI.Models.Entities;
using CookifyAPI.Models.Settings;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;

namespace CookifyAPI.Extensions;

public static class IdentityServiceExtensions
{
    public static IServiceCollection AddIdentityServices(this IServiceCollection services, IConfiguration configuration)
    {
        // --- НАСТРОЙКА IDENTITY ---
        services.AddIdentity<User, IdentityRole<int>>(options =>
            {
                configuration.GetSection("IdentityOptions").Bind(options);
            })
            .AddEntityFrameworkStores<AppDbContext>()
            .AddDefaultTokenProviders();
        
        var authSection = configuration.GetSection("AuthSettings");
        services.Configure<AuthSettings>(authSection);
        var authSettings = authSection.Get<AuthSettings>();
        
        if (authSettings == null || string.IsNullOrEmpty(authSettings.Key))
        {
            throw new InvalidOperationException("JWT Key is not configured in AuthSettings.");
        }
        
        services.Configure<EmailSettings>(configuration.GetSection("EmailSettings"));

        // --- НАСТРОЙКА JWT АУТЕНТИФИКАЦИИ ---
        services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
            .AddJwtBearer(options =>
            {
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = authSettings.Issuer,
                    ValidAudience = authSettings.Audience,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(authSettings.Key)),
                    ClockSkew = TimeSpan.Zero // Убирает 5-минутную задержку просрочки токена
                };
            });

        services.AddAuthorization();
        
        return services;
    }
}