using CookifyAPI.Models.DTOs.Requests;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers;

[ApiController]
[Route("api")]
public class AuthController(IAuthService authService) : ControllerBase
{
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginRequest request)
    {
        var response = await authService.LoginAsync(request);
        if (response == null) return Unauthorized(new { message = "Invalid login or password" });
        return Ok(response);
    }

    [HttpPost("refresh")]
    public async Task<IActionResult> Refresh([FromBody] RefreshRequest request)
    {
        var response = await authService.RefreshAsync(request);
        if (response == null) return BadRequest(new { message = "Invalid refresh token" });
        return Ok(response);
    }
    
    [HttpPost("sign-up")]
    public async Task<IActionResult> Register([FromBody] RegisterRequest request)
    {
        var result = await authService.RegisterAsync(request);

        if (!result.Succeeded)
        {
            // Если есть ошибки (например, email занят), возвращаем их
            return BadRequest(result.Errors);
        }

        return Ok(new { message = "Registration successful" });
    }
}