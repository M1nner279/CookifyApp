namespace CookifyAPI.Models.DTOs.Requests;

public record RecipePublishStepRequest
(
    string Title,
    int StepNumber,
    string Description,
    string? ImageBase64
);