namespace CookifyAPI.DTOs.Ingredients;

public class IngredientDto
{
    public int Id { get; set; }
    public string Name { get; set; }
    public float Calories100g { get; set; }
    public float Protein100g { get; set; }
    public float Fat100g { get; set; }
    public float Carb100g { get; set; }
    public float Amount { get; set; }
    public string Unit { get; set; }
}