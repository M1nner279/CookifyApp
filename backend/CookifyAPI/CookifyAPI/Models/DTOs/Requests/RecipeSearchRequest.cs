using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Models.DTOs.Requests;

public record RecipeSearchRequest(
    string? Title,
    int? MaxCookingTime,
    float? MinCarb, float? MaxCarb,
    float? MinProtein, float? MaxProtein,
    float? MinFat, float? MaxFat,
    float? MinCalories, float? MaxCalories,
    [FromQuery] int[]? Difficulty,
    [FromQuery] int[]? TagIds,
    [FromQuery] int[]? IngredientIds
);