namespace CookifyAPI.DTOs.Steps;

public class StepDto
{
    public int Id { get; set; }
    public string Title {get; set;}
    public int StepNumber { get; set; }
    public string Description { get; set; } = null!;
    public string? ImageUrl { get; set; }
}