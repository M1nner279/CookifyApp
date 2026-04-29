using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Options;
using MimeKit;
using CookifyAPI.Models.Settings;

namespace CookifyAPI.Services;

public class EmailService(IOptions<EmailSettings> options) : IEmailService
{
    private readonly EmailSettings _settings = options.Value;

    public async Task SendOtpCodeAsync(string email, string code)
    {
        var message = new MimeMessage();
        
        // Отправитель
        message.From.Add(new MailboxAddress(_settings.SenderName, _settings.SenderEmail));
        
        // Получатель
        message.To.Add(new MailboxAddress("", email));
        
        // Тема письма
        message.Subject = $"{code} — ваш код подтверждения Cookify";

        // Тело письма (HTML верстка)
        var bodyBuilder = new BodyBuilder
        {
            HtmlBody = $"""
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #eee; padding: 20px;">
                <h2 style="color: #4CAF50; text-align: center;">Добро пожаловать в Cookify!</h2>
                <p>Вы начали регистрацию в приложении рецептов. Для подтверждения вашего Email введите следующий код:</p>
                <div style="background-color: #f9f9f9; padding: 20px; text-align: center; font-size: 32px; font-weight: bold; letter-spacing: 5px; color: #333; border-radius: 10px;">
                    {code}
                </div>
                <p style="color: #777; font-size: 12px; margin-top: 30px;">
                    Если вы не регистрировались в нашем приложении, просто проигнорируйте это письмо. Код действителен 15 минут.
                </p>
            </div>
            """
        };

        message.Body = bodyBuilder.ToMessageBody();

        using var client = new SmtpClient();
        try
        {
            // Подключение к серверу (для 587 порта используем StartTls)
            await client.ConnectAsync(_settings.SmtpServer, _settings.Port, SecureSocketOptions.StartTls);
            
            // Авторизация
            await client.AuthenticateAsync(_settings.SenderEmail, _settings.Password);
            
            // Отправка
            await client.SendAsync(message);
        }
        catch (Exception ex)
        {
            // Логируем ошибку (в реальном проекте используйте ILogger)
            Console.WriteLine($"Error sending email: {ex.Message}");
            throw; // Пробрасываем ошибку выше
        }
        finally
        {
            await client.DisconnectAsync(true);
        }
    }
}