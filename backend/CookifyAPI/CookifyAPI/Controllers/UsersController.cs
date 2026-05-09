using System.Security.Claims;
using CookifyAPI.Data;
using CookifyAPI.Models.Entities;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Controllers;

/// <summary>
/// Контроллер для взаимодействия с профилем пользователя.
/// Предоставляет API для получения данных профиля.
/// </summary>
/// <param name="service">Сервис для работы с бизнес-логикой профиля.</param>
[ApiController]
[Route("api/[controller]")]
[Authorize]
[Produces("application/json")]
public class UsersController(IUserService userService) : AuthBaseController
{
    // GET: api/recipes
    /// <summary>
    ///     Возвращает данные профиля
    /// </summary>
    /// <returns></returns>
    [HttpGet("me")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult> GetMe()
    {
        return Ok(await userService.GetCurrentUserProfileAsync(CurrentUserId));
    }
    
    
    [HttpPost("me/avatar")]
    public async Task<IActionResult> UpdateAvatar(IFormFile file)
    {
        // Проверяем, что файл вообще прислали
        if (file == null || file.Length == 0)
            return BadRequest(new { message = "File is empty or not provided" });

        // Базовая валидация на картинку
        if (!file.ContentType.StartsWith("image/"))
            return BadRequest(new { message = "Only images are allowed" });
        try
        {
            var avatarUrl = await userService.UpdateAvatarAsync(CurrentUserId, file);
            if (avatarUrl == null) return NotFound("User not found");
            
            return Ok(avatarUrl);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { message = "Error uploading avatar", details = ex.Message });
        }
    }
    
    
    //
    // [HttpPost]
    // public async Task<IActionResult> Create(User user)
    // {
    //     _db.Users.Add(user);
    //     await _db.SaveChangesAsync();
    //     return Ok(user);
    // }
}