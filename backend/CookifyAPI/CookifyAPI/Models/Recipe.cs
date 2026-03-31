namespace CookifyAPI.Models;

public class Recipe
{
    public int Id { get; set; } // r_id

    public string Title { get; set; } = null!; // nvarchar(200)

    public int CookingTimeMin { get; set; }
    public int Servings { get; set; }

    public int AuthorId { get; set; }
    public User Author { get; set; } = null!;

    public float Calories100g { get; set; } // TO Do decimal 6,2
    public float Protein100g { get; set; }
    public float Fat100g { get; set; }
    public float Carb100g { get; set; }

    public DateTime CreatedAt { get; set; }

    public string Description { get; set; } = null!; // nvarchar(511)
    public int Difficulty { get; set; }

    // Navigation

    public List<RecipeStep> Steps { get; set; } = new();
    public List<RecipeImage> Images { get; set; } = new();

    public List<M2MRecipeIngredient> Ingredients { get; set; } = new();
    public List<M2MRecipeTag> Tags { get; set; } = new();

    //public List<Favorite> Favorites { get; set; } = new();
}