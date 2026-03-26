namespace CookifyAPI.Models;

public class Ingredient
{
    public int Id { get; set; } // i_id

    public string Name { get; set; } = null!; // nvarchar(100)

    public float Calories100g { get; set; }
    public float Protein100g { get; set; }
    public float Fat100g { get; set; }
    public float Carb100g { get; set; }

    // Navigation

    public List<RecipeIngredient> Recipes { get; set; } = new();
}