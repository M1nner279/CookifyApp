using System.Reflection;
using System.Text.Json;
using CookifyAPI.Data;
using CookifyAPI.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// 1. Настройка базы данных
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        sqlOptions =>
        {
            sqlOptions.EnableRetryOnFailure(
                maxRetryCount: 10,
                maxRetryDelay: TimeSpan.FromSeconds(5),
                errorNumbersToAdd: null);
        })
        .UseSnakeCaseNamingConvention()
);

// 2. Регистрация сервисов (DI)
builder.Services.AddScoped<IRecipeService, RecipeService>();
builder.Services.AddScoped<IFavoriteService, FavoriteService>();
builder.Services.AddScoped<IImageService, CloudinaryImageService>();

// 3. Контроллеры и настройка JSON (Snake Case)
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower;
    });

// 4. Swagger и OpenAPI
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    var xmlFilename = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    c.IncludeXmlComments(Path.Combine(AppContext.BaseDirectory, xmlFilename));
});

var app = builder.Build();

// 5. Конфигурация HTTP-конвейера (Middleware)
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Cookify API V1");
        c.RoutePrefix = string.Empty; // Swagger открывается сразу по адресу http://localhost:5022
    });
}

// 6. Применение миграций с проверкой готовности БД (для Docker)
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    
    // Попытка применить миграции несколько раз (защита от медленного старта БД)
    int retries = 5;
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
                Console.WriteLine("CRITICAL: Database is not ready after multiple retries.");
                throw; // Приложение упадет, и Docker его перезапустит
            }
            Console.WriteLine($"Database is starting up... waiting. ({retries} attempts left)");
            Thread.Sleep(5000);
        }
    }
}

app.MapControllers();

app.Run();