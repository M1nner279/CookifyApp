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
        
        var tags = new List<Tag>
        {
            new Tag { Name = "Суп" },
            new Tag { Name = "Быстро" },
            new Tag { Name = "Завтрак" },
            new Tag { Name = "Выпечка" }
        };

        var ingredients = new List<Ingredient>
        {
            new Ingredient { Name = "Курица бройлерная" },
            new Ingredient { Name = "Рис" },
            new Ingredient { Name = "Чеснок" },
            new Ingredient { Name = "Масло сливочное" },
            new Ingredient { Name = "Лук репчатый" },
            new Ingredient { Name = "Морковь" },
            new Ingredient { Name = "Томатная паста" },
            new Ingredient { Name = "Зелень" },
            new Ingredient { Name = "Соль" },
            new Ingredient { Name = "Вода" },
            new Ingredient { Name = "Картофель" },
            new Ingredient { Name = "Сметана" },
            new Ingredient { Name = "Мука" },
        };
        
        context.Users.Add(user);
        context.Tags.AddRange(tags);
        context.Ingredients.AddRange(ingredients);

        await context.SaveChangesAsync(); // Сохраняем пользователя, чтобы EF сгенерировал ID
        
        var recipe = new Recipe
        {
            Title = "Картофельные драники",
            Description = "Картофельные драники - очень быстро, очень просто, очень вкусно!",
            AuthorId = user.Id,
            CookingTimeMin = 30,
            Servings = 4,
            Difficulty = 1
        };

        context.Recipes.Add(recipe);
        await context.SaveChangesAsync();
        
        context.RecipeImages.AddRange(
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/4/big_3618.jpg", Order = 0 },
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/4/big_3619.jpg", Order = 1 },
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/4/big_3620.jpg", Order = 2 },
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/4/big_3621.jpg", Order = 3 }
        );

        context.RecipeSteps.AddRange(
            new RecipeStep { RecipeId = recipe.Id, StepNumber = 1, Title = "1 шак", Description = "Картофель натереть на крупной тёрке, отжать, добавить муку, сметану, соль, перемешать.", ImageUrl = "https://www.russianfood.com/dycontent/images_upl/4/big_3619.jpg" },
            new RecipeStep { RecipeId = recipe.Id, StepNumber = 2, Title = "title нужен?", Description = "Выкладывать столовой ложкой на очень хорошо разогретую сковороду в растопленное масло.", ImageUrl = "https://www.russianfood.com/dycontent/images_upl/4/big_3620.jpg" },
            new RecipeStep { RecipeId = recipe.Id, StepNumber = 3, Description = "Обжаривать драники с обеих сторон до золотистой корочки. Подавать горячими со сметаной.", ImageUrl = "https://www.russianfood.com/dycontent/images_upl/4/big_3621.jpg" }
        );

        await context.SaveChangesAsync();
        
        recipe = new Recipe
        {
            Title = "Суп «Харчо»",
            Description = "Суп харчо - вкусный, ароматный, острый. Традиционно харчо варят из говядины, но по этому рецепту готовится суп с курицей.",
            AuthorId = user.Id,
            CookingTimeMin = 60,
            Servings = 6,
            Difficulty = 2
        };

        context.Recipes.Add(recipe);
        await context.SaveChangesAsync();

        // Images
        context.RecipeImages.AddRange(
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/31/big_30806.jpg", Order = 0 },
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/31/big_30807.jpg", Order = 1 },
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/31/big_30822.jpg", Order = 2 },
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/31/big_30808.jpg", Order = 3 },
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/31/big_30809.jpg", Order = 4 },
            new RecipeImage { RecipeId = recipe.Id, Url = "https://www.russianfood.com/dycontent/images_upl/31/big_30823.jpg", Order = 5 }
        );

        // Steps
        context.RecipeSteps.AddRange(
            new RecipeStep { RecipeId = recipe.Id, StepNumber = 1, Description = "Все ингредиенты подготовить.", ImageUrl = "https://www.russianfood.com/dycontent/images_upl/31/big_30807.jpg" },
            new RecipeStep { RecipeId = recipe.Id, StepNumber = 2, Description = "Курицу нарезать.", ImageUrl = "https://www.russianfood.com/dycontent/images_upl/31/big_30822.jpg" },
            new RecipeStep { RecipeId = recipe.Id, StepNumber = 3, Description = "Варить курицу.", ImageUrl = "https://www.russianfood.com/dycontent/images_upl/31/big_30808.jpg" },
            new RecipeStep { RecipeId = recipe.Id, StepNumber = 4, Description = "Добавить рис.", ImageUrl = "https://www.russianfood.com/dycontent/images_upl/31/big_30809.jpg" },
            new RecipeStep { RecipeId = recipe.Id, StepNumber = 5, Description = "Добавить овощи.", ImageUrl = "https://www.russianfood.com/dycontent/images_upl/31/big_30823.jpg" }
        );

        var recipeTags = new List<RecipeTag>
        {
            new RecipeTag { RecipeId = recipe.Id, TagId = tags.First(t => t.Name == "Быстро").Id },
            new RecipeTag { RecipeId = recipe.Id, TagId = tags.First(t => t.Name == "Суп").Id },
            new RecipeTag { RecipeId = recipe.Id, TagId = tags.First(t => t.Name == "Завтрак").Id }
        };
        context.AddRange(recipeTags);
        var recipeIngredients = new List<RecipeIngredient>
        {
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Курица бройлерная").Id, Amount = 1, Unit = "шт."},
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Рис").Id, Amount = 0.5f, Unit = "стакана"},
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Чеснок").Id, Amount = 1, Unit = "головка"},
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Масло сливочное").Id, Amount = 50, Unit = "г"},
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Лук репчатый").Id, Amount = 1, Unit = "шт."},
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Морковь").Id, Amount = 1, Unit = "шт."},
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Томатная паста").Id, Amount = 2, Unit = "ст. ложки"},
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Зелень").Id, Amount = 55, Unit = "г"}, // Среднее значение от 50-60
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Соль").Id, Amount = 1, Unit = "ст. ложка"},
            new RecipeIngredient { RecipeId = recipe.Id, IngredientId = ingredients.First(t => t.Name == "Вода").Id, Amount = 2.5f, Unit = "л"}

        };
        context.AddRange(recipeIngredients);
        
        await context.SaveChangesAsync();

    }
}
