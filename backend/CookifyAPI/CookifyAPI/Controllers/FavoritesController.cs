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
    
}