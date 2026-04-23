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
[Authorize]
[Route("api/[controller]")]
[Produces("application/json")]
public class FavoritesController(IFavoriteService service) : AuthBaseController
{
    /// <summary>
    ///     Возвращает список избранных рецептов пользователя
    /// </summary>
    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult> GetFavorites()
    {
        return Ok(await service.GetFavoritesAsync(CurrentUserId));
    }

    /// <summary>
    ///     Добавляет рецепт в избранное пользователя.
    /// </summary>
    /// <param name="recipeId">Идентификатор рецепта</param>
    /// <response code="201">201 Created — рецепт добавлен в избранное</response>
    /// <response code="204">204 NoContent — рецепт уже был в избранном</response>
    [HttpPost("{recipeId}")]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    public async Task<IActionResult> AddToFavorites(int recipeId)
    {
        var created = await service.AddFavoriteAsync(CurrentUserId, recipeId);

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
    [HttpDelete("{recipeId}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    public async Task<IActionResult> RemoveFromFavorites(int recipeId)
    {
        await service.RemoveFavoriteAsync(CurrentUserId, recipeId);

        return NoContent();
    }
}