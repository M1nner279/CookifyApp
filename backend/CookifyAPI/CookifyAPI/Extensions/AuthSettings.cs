namespace CookifyAPI.Extensions;

public record AuthSettings
{
    public string Key { get; init; } = string.Empty;
    public string Issuer { get; init; } = string.Empty;
    public string Audience { get; init; } = string.Empty;
    public int AccessTokenExpirationMinutes { get; init; }
    public int RefreshTokenExpirationDays { get; init; }
    public bool SkipVerification { get; init; }
    
    public string GoogleClientId { get; init; } = string.Empty; 
}