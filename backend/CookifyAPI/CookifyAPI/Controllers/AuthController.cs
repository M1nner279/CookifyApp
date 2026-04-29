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
    public async Task<IActionResult> SignUp([FromBody] RegisterRequest request)
    {
        var result = await authService.SignUpAsync(request);

        if (!result.Succeeded)
        {
            // Если есть ошибки (например, email занят), возвращаем их
            return BadRequest(result.Errors);
        }

        return Ok(new { message = "OTP code sent to email" });
    }
    
    [HttpPost("restore")]
    public async Task<IActionResult> Restore(RestoreRequest request)
    {
        var result = await authService.SendOtpCodeAsync(request.Login);
        return result ? Ok(new { message = "OTP sent" }) : BadRequest("Account not found");
    }
    
    [HttpPost("reset-password")]
    public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordRequest request)
    {
        var response = await authService.ResetPasswordAsync(request);

        if (response == null)
        {
            return BadRequest(new { 
                message = "Invalid code, account not found, or password does not meet requirements." 
            });
        }

        // Возвращаем access_token и refresh_token
        return Ok(response);
    }
    
    [HttpPost("otp/resend")]
    public async Task<IActionResult> ResendOtp(ResendOtpRequest request)
    {
        var result = await authService.SendOtpCodeAsync(request.Login);
        return result ? Ok(new { message = "OTP resent" }) : BadRequest("Account not found");
    }

    [HttpPost("otp/confirm")]
    public async Task<IActionResult> Confirm([FromBody] ConfirmOtpRequest request)
    {
        var response = await authService.VerifyCodeAsync(request);
        if (response == null) return BadRequest(new { message = "Invalid code or email" });
        
        return Ok(response);
    }
    
}