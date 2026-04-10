using System.Text.Json.Serialization;

namespace CookifyAPI.DTOs.Ingredients;

public class JsonIngredientDto
{
    [JsonPropertyName("name")]
    public string Name { get; set; }

    [JsonPropertyName("calories_100g")]
    public float? Calories100g { get; set; }

    [JsonPropertyName("protein_100g")]
    public float? Protein100g { get; set; }

    [JsonPropertyName("fat_100g")]
    public float? Fat100g { get; set; }

    [JsonPropertyName("carb_100g")]
    public float? Carb100g { get; set; }
}