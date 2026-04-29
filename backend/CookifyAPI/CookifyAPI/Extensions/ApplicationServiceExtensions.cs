using CookifyAPI.Services;

namespace CookifyAPI.Extensions;

public static class ApplicationServiceExtensions
{
    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        services.AddScoped<ITokenService, TokenService>();
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<IRecipeService, RecipeService>();
        services.AddScoped<IFavoriteService, FavoriteService>();
        services.AddScoped<IImageService, CloudinaryImageService>();
        services.AddScoped<IEmailService, EmailService>();
            

        // Автоматический поиск профилей AutoMapper
        //services.AddAutoMapper(Assembly.GetExecutingAssembly());
        return services;
    }
}