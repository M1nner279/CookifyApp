using CookifyAPI.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddControllers();

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.Migrate(); // создаст базу, если её нет, и таблицы
    
//    if (!await db.Recipes.AnyAsync())
    {
        try
        {
            await DbSeeder.SeedAsync(db);
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex);
        }
    }
}

app.MapControllers();

app.Run();