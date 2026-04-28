namespace CookifyAPI.Models.DTOs.Requests;

public record ConfirmOtpRequest(string Login, string Code);