using System.Text.Json.Serialization;
using CookifyAPI.DTOs.Steps;

namespace CookifyAPI.DTOs.Recipes;

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
    public float Calories { get; set; }

    [JsonPropertyName("protein")]
    public float Protein { get; set; }

    [JsonPropertyName("fat")]
    public float Fat { get; set; }

    [JsonPropertyName("carb")]
    public float Carb { get; set; }

    [JsonPropertyName("ingredients")]
    public List<JsonIngredientInRecipeDto> Ingredients { get; set; }

    [JsonPropertyName("tags")]
    public List<string> Tags { get; set; }

    [JsonPropertyName("steps")]
    public List<JsonStepDto> Steps { get; set; }

    [JsonPropertyName("images")]
    public List<string> Images { get; set; }
}