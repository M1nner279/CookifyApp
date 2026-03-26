namespace CookifyAPI.Models;

public class Tag
{
    public int Id { get; set; } // t_id

    public string Name { get; set; } = null!; // nvarchar(100)

    public List<RecipeTag> Recipes { get; set; } = new();
}