namespace CookifyAPI.Models;

public class RecipeStep
{
    public int Id { get; set; } // rs_id
    public string? Title { get; set; }
    public int RecipeId { get; set; }
    public Recipe Recipe { get; set; } = null!;

    public int StepNumber { get; set; }

    public string? ImageUrl { get; set; }

    public string Description { get; set; } = null!; // nvarchar(max)
}