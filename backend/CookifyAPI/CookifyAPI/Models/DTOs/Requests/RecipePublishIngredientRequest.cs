using System.ComponentModel.DataAnnotations;

namespace CookifyAPI.Models.DTOs.Requests;

public record  RecipePublishIngredientRequest
(
    int Id,
    float Amount,
    string Unit
);