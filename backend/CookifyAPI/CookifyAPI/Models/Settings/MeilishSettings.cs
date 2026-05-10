namespace CookifyAPI.Models.Settings;

public record MeilisearchSettings
{
    public string Url { get; init; } = string.Empty;
    public string MasterKey { get; init; } = string.Empty;
}