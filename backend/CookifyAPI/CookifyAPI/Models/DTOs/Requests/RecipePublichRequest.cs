namespace CookifyAPI.Models.DTOs.Requests;

public record RecipePublishRequest(
    string Title,
    int CookingTimeMinutes,
    int Servings,
    float Calories100g,
    float Protein100g,
    float Fat100g,
    float Carb100g,
    string Description,
    int Difficulty,

    string? MainImageBase64,
    List<RecipePublishStepRequest> Steps,
    List<int> Tags,
    List<RecipePublishIngredientRequest> Ingredients
);
