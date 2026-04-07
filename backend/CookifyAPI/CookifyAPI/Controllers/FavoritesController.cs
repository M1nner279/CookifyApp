using CookifyAPI.Services;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class FavoritesController : ControllerBase
{
    private readonly IFavoriteService _service;

    public FavoritesController(IFavoriteService service)
    {
        _service = service;
    }
    
    // GET: api/favorites
    [HttpGet]
    public async Task<ActionResult> GetFavorites(
        int userId)
    {
        return Ok(await _service.GetFavoritesAsync(userId));
    }
    
    // POST: api/favorites/{recipeId}
    [HttpPost("{recipeId}")]
    public async Task<IActionResult> AddToFavorites(int recipeId, int userId)
    {
        //int userId =  // из JWT TODO авторизованный пользователь по jwt токену

        var created = await _service.AddFavoriteAsync(userId, recipeId);
        
        if (created)
        {
            return Created(
                $"/api/favorites/{recipeId}",
                null
            );
        }
        
        return NoContent(); // идемпотентно
    }
    
    // DELETE: api/favorites/{recipeId}
    [HttpDelete("{recipeId}")]
    public async Task<IActionResult> RemoveFromFavorites(int recipeId, int userId)
    {
        await _service.RemoveFavoriteAsync(userId, recipeId);
        
        return NoContent();
    }
}