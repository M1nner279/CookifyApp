namespace CookifyAPI.Models.Entities;

public class M2MRecipeTag
{
    public int RecipeId { get; set; }
    public Recipe Recipe { get; set; } = null!;

    public int TagId { get; set; }
    public Tag Tag { get; set; } = null!;
}