namespace CookifyAPI.Models;

public class RecipeImage
{
    public int Id { get; set; } // img_id

    public int RecipeId { get; set; }
    public Recipe Recipe { get; set; } = null!;

    public string Url { get; set; } = null!;
    public int Order { get; set; }
}