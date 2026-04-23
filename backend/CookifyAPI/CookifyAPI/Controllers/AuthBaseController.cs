using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers;

[ApiController]
public abstract class AuthBaseController : ControllerBase
{
    protected int CurrentUserId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
}