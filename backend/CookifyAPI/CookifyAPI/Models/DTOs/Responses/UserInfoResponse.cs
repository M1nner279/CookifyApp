namespace CookifyAPI.Models.DTOs.Responses;

public record UserStatisticResponse(
    int FavoriteRecipesCount,
    int CreatedRecipesCount,
    int PublishedRecipesCount
);

public record UserInfoResponse
(
    int Id,
    string? AvatarUrl,
    string Login,
    string Email,
    DateTime CreatedAt,
    UserStatisticResponse? Statistic
);