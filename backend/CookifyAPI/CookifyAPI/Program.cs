using System.Reflection;
using System.Text;
using System.Text.Json;
using CookifyAPI.Data;
using CookifyAPI.Models.Entities;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// --- Настройка базы данных ---
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

// --- НАСТРОЙКА IDENTITY ---
builder.Services.AddIdentity<User, IdentityRole<int>>(options =>
    {
        // Настройки сложности пароля (упрощено для разработки)
        options.Password.RequireDigit = false;
        options.Password.RequiredLength = 6;
        options.Password.RequireNonAlphanumeric = false;
        options.Password.RequireUppercase = false;
        options.Password.RequireLowercase = false;
        
        options.User.RequireUniqueEmail = true;
    })
    .AddEntityFrameworkStores<AppDbContext>()
    .AddDefaultTokenProviders();

// --- НАСТРОЙКА JWT АУТЕНТИФИКАЦИИ ---
builder.Services.AddAuthentication(options =>
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
            ValidIssuer = builder.Configuration["AuthSettings:Issuer"],
            ValidAudience = builder.Configuration["AuthSettings:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["AuthSettings:Key"]!)),
            ClockSkew = TimeSpan.Zero // Убирает 5-минутную задержку просрочки токена
        };
    });

builder.Services.AddAuthorization();

// --- РЕГИСТРАЦИЯ СЕРВИСОВ (DI) ---
builder.Services.AddScoped<ITokenService, TokenService>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IRecipeService, RecipeService>();
builder.Services.AddScoped<IFavoriteService, FavoriteService>();
builder.Services.AddScoped<IImageService, CloudinaryImageService>();

// Автоматический поиск профилей AutoMapper
//builder.Services.AddAutoMapper(Assembly.GetExecutingAssembly());

// Контроллеры и настройка JSON (Snake Case)
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower;
    });

// Swagger и OpenAPI
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    var xmlFilename = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    c.IncludeXmlComments(Path.Combine(AppContext.BaseDirectory, xmlFilename));

    // Описание кнопки Authorize
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "Введите токен в формате: Bearer {ваш_токен}",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", b => b.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
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
                Console.WriteLine("CRITICAL: Database is not ready after multiple retries.");
                throw; // Приложение упадет, и Docker его перезапустит
            }
            Console.WriteLine($"Database is starting up... waiting. ({retries} attempts left)");
            Thread.Sleep(15000);
        }
    }
}

app.UseHttpsRedirection();
app.UseCors("AllowAll");

app.UseAuthentication(); 
app.UseAuthorization();

app.MapControllers();

app.Run();