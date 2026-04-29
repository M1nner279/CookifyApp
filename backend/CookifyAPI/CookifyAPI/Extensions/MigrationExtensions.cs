using CookifyAPI.Data;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Extensions;

public static class MigrationExtensions
{
    public static void ApplyMigrations(this IApplicationBuilder app)
    {
        using (var scope = app.ApplicationServices.CreateScope())
        {
            var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    
            // Попытка применить миграции несколько раз (защита от медленного старта БД)
            int retries = 20;
            while (retries > 0)
            {
                try
                {
                    db.Database.Migrate();
                    Console.WriteLine("Database check/migration completed successfully.");
                    break;
                }
                catch (Exception ex)
                {
                    retries--;
                    if (retries == 0)
                    {
                        Console.WriteLine("CRITICAL ERROR: Database is not ready after multiple retries.");
                        throw; // Приложение упадет, и Docker его перезапустит
                    }
                    Console.WriteLine($"WARNING: Database is starting up... waiting. ({retries} attempts left)");
                    Thread.Sleep(10000);
                }
            }
        }
    }
}