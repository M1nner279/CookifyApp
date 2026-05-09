using System.Reflection;
using CookifyAPI.Services;
using Meilisearch;

namespace CookifyAPI.Extensions;

public static class ApplicationServiceExtensions
{
    public static IServiceCollection AddApplicationServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddScoped<ITokenService, TokenService>();
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<IRecipeService, RecipeService>();
        services.AddScoped<IFavoriteService, FavoriteService>();
        services.AddScoped<IImageService, CloudinaryImageService>();
        services.AddScoped<IEmailService, EmailService>();
        services.AddScoped<IUserService, UserService>();
        
        var meiliUrl = configuration["MeilisearchSettings:Url"];
        var meiliKey = configuration["MeilisearchSettings:MasterKey"];

        if (string.IsNullOrEmpty(meiliUrl) || string.IsNullOrEmpty(meiliKey))
            throw new InvalidOperationException("Meilisearch Url or MasterKey is not configured.");
        
        // Регистрируем клиент (Singleton, т.к. он держит HTTP-соединения открытыми)
        services.AddSingleton(new MeilisearchClient(meiliUrl, meiliKey));
        services.AddScoped<ISearchService, MeilisearchService>();

        // Автоматический поиск профилей AutoMapper
        //services.AddAutoMapper(Assembly.GetExecutingAssembly());
        return services;
    }
}