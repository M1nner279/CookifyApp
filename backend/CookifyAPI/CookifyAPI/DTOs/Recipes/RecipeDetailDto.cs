using CookifyAPI.DTOs;
namespace CookifyAPI.DTOs.Recipes;

public class RecipeDetailDto
{
    // Поля из recipes
    public int Id { get; set; }
    public string Title { get; set; } = null!;
    public int CookingTimeMinutes { get; set; }
    public int Servings { get; set; }
    public int AuthorId { get; set; }
    public float Calories100g { get; set; }
    public float Protein100g { get; set; }
    public float Fat100g { get; set; }
    public float Carb100g { get; set; }
    public DateTime? CreatedAt { get; set; }
    public string Description { get; set; } = null!;
    public int Difficulty { get; set; }

    // Связанные данные
    public List<RecipeImageDto> Images { get; set; } = new();
    public List<RecipeStepDto> Steps { get; set; } = new();
    public List<string> Tags { get; set; } = new();
    public List<IngredientDto> Ingredients { get; set; }
}