namespace CookifyAPI.DTOs.Favorites;

public class FavoriteDto
{
    public int Id { get; set; }
    public string Title { get; set; } = null!;
    public string? PreviewImageUrl { get; set; } 
    public int CookingTimeMin { get; set; }
    //public int Servings { get; set; }
    public int Difficulty { get; set; }
    public List<string> Tags { get; set; } = new();
}