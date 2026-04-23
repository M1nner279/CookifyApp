namespace CookifyAPI.Models.DTOs.Requests;

public record VerifyCodeRequest(string Email, string Code);