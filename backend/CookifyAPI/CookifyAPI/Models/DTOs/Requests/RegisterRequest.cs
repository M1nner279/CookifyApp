namespace CookifyAPI.Models.DTOs.Requests;

public record RegisterRequest(string Login, string Email, string Password);