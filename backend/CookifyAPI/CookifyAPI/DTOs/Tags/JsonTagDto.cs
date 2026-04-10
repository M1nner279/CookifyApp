using System.Text.Json.Serialization;

namespace CookifyAPI.DTOs.Tags;

public class JsonTagDto
{
    [JsonPropertyName("name")]
    public string Name { get; set; } = null!;
}