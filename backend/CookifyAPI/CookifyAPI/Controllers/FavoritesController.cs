using System.Security.Claims;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers;

/// <summary>
/// Контроллер для управления избранными рецептами пользователей.
/// Предоставляет API для добавления рецептов в закладки, их удаления и получения списка избранного.
/// </summary>
/// <param name="service">Сервис для работы с бизнес-логикой избранного.</param>
[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class FavoritesController(IFavoriteService service) : ControllerBase
{
    /// <summary>
    ///     Возвращает список избранных рецептов пользователя
    /// </summary>
    [Authorize]
    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult> GetFavorites()
    {
        var userIdString = User.FindFirstValue(ClaimTypes.NameIdentifier); // временно парсим в контроллере
        if (string.IsNullOrEmpty(userIdString))
        {
            return Unauthorized();
        }
        int userId = int.Parse(userIdString);
        
        var favorites = await service.GetFavoritesAsync(userId);
        return Ok(favorites);
    }

    /// <summary>
    ///     Добавляет рецепт в избранное пользователя.
    /// </summary>
    /// <param name="recipeId">Идентификатор рецепта</param>
    /// <param name="userId">Идентификатор пользователя(исчезнет с появлением авторизации)</param>
    /// <response code="201">201 Created — рецепт добавлен в избранное</response>
    /// <response code="204">204 NoContent — рецепт уже был в избранном</response>
    [HttpPost("{recipeId}")]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    public async Task<IActionResult> AddToFavorites(int recipeId, int userId)
    {
        //int userId =  // из JWT TODO авторизованный пользователь по jwt токену

        var created = await service.AddFavoriteAsync(userId, recipeId);

        if (created)
            return Created(
                $"/api/favorites/{recipeId}",
                null
            );

        return NoContent(); // идемпотентно
    }

    // DELETE: api/favorites/{recipeId}
    /// <summary>
    ///     Удаляет рецепт из избранного пользователя
    /// </summary>
    /// <param name="recipeId"></param>
    /// <param name="userId"></param>
    [HttpDelete("{recipeId}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    public async Task<IActionResult> RemoveFromFavorites(int recipeId, int userId)
    {
        await service.RemoveFavoriteAsync(userId, recipeId);

        return NoContent();
    }
}