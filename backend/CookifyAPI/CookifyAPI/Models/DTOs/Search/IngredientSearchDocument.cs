namespace CookifyAPI.Models.DTOs.Search;

public record IngredientSearchDocument(
    int Id,
    string Name,
    float? Calories100g,
    float? Protein100g,
    float? Fat100g,
    float? Carb100g
);