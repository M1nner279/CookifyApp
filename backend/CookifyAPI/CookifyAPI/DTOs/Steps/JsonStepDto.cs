

using System.Text.Json.Serialization;

namespace CookifyAPI.DTOs.Steps;

public class JsonStepDto
{
    [JsonPropertyName("title")]
    public string Title { get; set; }

    [JsonPropertyName("step_number")]
    public int StepNumber { get; set; }

    [JsonPropertyName("description")]
    public string Description { get; set; }

    [JsonPropertyName("image_url")]
    public string ImageUrl { get; set; }
}