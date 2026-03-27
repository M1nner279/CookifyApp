namespace CookifyAPI.DTOs.Recipes;

public class RecipeStepDto
{
    public int Id { get; set; }
    public int StepNumber { get; set; }
    public string Description { get; set; } = null!;
    public string? ImageUrl { get; set; }
}