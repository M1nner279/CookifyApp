namespace CookifyAPI.DTOs.Recipes;

public class RecipeImageDto
{
    public int Id { get; set; }
    public string Url { get; set; } = null!;
    public int Order { get; set; }
}
