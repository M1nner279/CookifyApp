namespace CookifyAPI.Models;

public class M2MRecipeIngredient
{ 
    public int RecipeId { get; set; } 
    public Recipe Recipe { get; set; } = null!;

    public int IngredientId { get; set; }
    public Ingredient Ingredient { get; set; } = null!;

    public float Amount { get; set; }
    public string Unit { get; set; } = null!;
}