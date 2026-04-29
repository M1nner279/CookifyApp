namespace CookifyAPI.Services;

public interface IEmailService
{
    Task SendOtpCodeAsync(string email, string code);
}