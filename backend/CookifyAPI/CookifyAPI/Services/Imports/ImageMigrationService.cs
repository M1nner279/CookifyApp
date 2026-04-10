using System.Text.Json;
using System.Text.Json.Serialization;
using CookifyAPI.DTOs.Ingredients;

namespace CookifyAPI.Services;

public class JsonRecipeDto
{
    [JsonPropertyName("title")]
    public string Title { get; set; }

    [JsonPropertyName("cooking_time_min")]
    public int CookingTimeMin { get; set; }

    [JsonPropertyName("servings")]
    public int Servings { get; set; }

    [JsonPropertyName("difficulty_text")]
    public string DifficultyText { get; set; }

    [JsonPropertyName("description")]
    public string Description { get; set; }

    [JsonPropertyName("calories")]
    public double Calories { get; set; }

    [JsonPropertyName("protein")]
    public double Protein { get; set; }

    [JsonPropertyName("fat")]
    public double Fat { get; set; }

    [JsonPropertyName("carb")]
    public double Carb { get; set; }

    [JsonPropertyName("ingredients")]
    public List<JsonIngredientDto> Ingredients { get; set; }

    [JsonPropertyName("tags")]
    public List<string> Tags { get; set; }

    [JsonPropertyName("steps")]
    public List<JsonStepDto> Steps { get; set; }

    [JsonPropertyName("images")]
    public List<string> Images { get; set; }
}

public class JsonStepDto
{
    [JsonPropertyName("title")]
    public string Title { get; set; }

    [JsonPropertyName("step_number")]
    public int StepNumber { get; set; }

    [JsonPropertyName("description")]
    public string Description { get; set; }

    [JsonPropertyName("image_url")]
    public string ImageUrl { get; set; }
}

// public class JsonIngredientDto
// {
//     [JsonPropertyName("name")]
//     public string Name { get; set; }
//
//     [JsonPropertyName("amount")]
//     public double Amount { get; set; }
//
//     [JsonPropertyName("unit")]
//     public string Unit { get; set; }
// }

public class ImageMigrationService
{
    private readonly HttpClient _httpClient;
    private readonly IImageService _imageService;
    //private readonly Dictionary<string, string> _cache = new();

    public ImageMigrationService(
        HttpClient httpClient,
        IImageService imageService)
    {
        _httpClient = httpClient;
        _imageService = imageService;
    }
    
    public async Task<string> ProcessImageAsync(string url, string folder)
    {
        if (string.IsNullOrWhiteSpace(url))
            return null;

        // if (_cache.TryGetValue(url, out var cached))
        //     return cached;

        try
        {
            using var stream = await _httpClient.GetStreamAsync(url);

            var uploadedUrl = await _imageService.UploadAsync(stream, "image.jpg", folder);

            //_cache[url] = uploadedUrl;

            return uploadedUrl;
        }
        catch
        {
            // ошибка сети или cloudinary
            return null;
        }
    }
    
    public async Task ProcessRecipeAsync(JsonRecipeDto recipe)
    {
        // 1. Основные изображения
        if (recipe.Images != null)
        {
            for (int i = 0; i < recipe.Images.Count; i++)
            {
                var newUrl = await ProcessImageAsync(recipe.Images[i], "CookifyApp/recipes");
                if (newUrl != null)
                    recipe.Images[i] = newUrl;
            }
        }

        // 2. Шаги
        if (recipe.Steps != null)
        {
            foreach (var step in recipe.Steps)
            {
                var newUrl = await ProcessImageAsync(step.ImageUrl, "CookifyApp/steps");
                if (newUrl != null)
                    step.ImageUrl = newUrl;
            }
        }
    }
    
    public async Task<List<JsonRecipeDto>> ProcessAllAsync(string json)
    {
        var recipes = JsonSerializer.Deserialize<List<JsonRecipeDto>>(json);

        foreach (var recipe in recipes)
        {
            await ProcessRecipeAsync(recipe);
        }

        return recipes;
    }
}