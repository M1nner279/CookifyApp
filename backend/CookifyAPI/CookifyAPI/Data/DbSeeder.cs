using CookifyAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Data;

public static class DbSeeder
{
    public static async Task SeedAsync(AppDbContext context)
    {
        // Проверка, есть ли пользователи — чтобы не дублировать
        if (await context.Users.AnyAsync())
            return;

        var user = new User
        {
            Email = "my@gmail.com",
            Username = "hi_there",
            PasswordHash = "0"
        };

        context.Users.Add(user);
        await context.SaveChangesAsync(); // Сохраняем пользователя, чтобы EF сгенерировал ID

        var recipes = new List<Recipe>
        {
            new Recipe { Title = "Pasta Carbonara", Description = "Classic Italian pasta", AuthorId = user.Id },
            new Recipe { Title = "Tomato Soup", Description = "Simple soup", AuthorId = user.Id },
            new Recipe { Title = "Pancakes", Description = "Breakfast classic", AuthorId = user.Id }
        };

        context.Recipes.AddRange(recipes);
        await context.SaveChangesAsync();
    }
}
