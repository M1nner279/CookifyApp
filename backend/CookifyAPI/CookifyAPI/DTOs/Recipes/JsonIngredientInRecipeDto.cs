using System.Text.Json.Serialization;

namespace CookifyAPI.DTOs.Recipes;

public class JsonIngredientInRecipeDto
{
    [JsonPropertyName("name")]
    public string Name { get; set; }
    [JsonPropertyName("amount")]
    public float Amount { get; set; }
    [JsonPropertyName("unit")]
    public string Unit { get; set; }
}