using System.Text.Json;

namespace CookifyAPI.Extensions;

public static class WebServiceExtensions
{
    public static IServiceCollection AddWebServices(this IServiceCollection services)
    {
        // Контроллеры и настройка JSON (Snake Case)
        services.AddControllers()
            .AddJsonOptions(options =>
            {
                options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower;
            });

        services.AddCors(options =>
        {
            options.AddPolicy("AllowAll", b => b.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
        });
        
        return services;
    }
}