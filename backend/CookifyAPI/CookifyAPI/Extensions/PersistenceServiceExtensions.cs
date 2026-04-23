using CookifyAPI.Data;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Extensions;

public static class PersistenceServiceExtensions
{
    public static IServiceCollection AddPersistanceSeervices(this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddDbContext<AppDbContext>(options =>
            options.UseSqlServer(
                    configuration.GetConnectionString("DefaultConnection"),
                    sqlOptions =>
                    {
                        sqlOptions.EnableRetryOnFailure(
                            maxRetryCount: 10,
                            maxRetryDelay: TimeSpan.FromSeconds(5),
                            errorNumbersToAdd: null);
                    })
                .UseSnakeCaseNamingConvention()
        );
        return services;
    }
}