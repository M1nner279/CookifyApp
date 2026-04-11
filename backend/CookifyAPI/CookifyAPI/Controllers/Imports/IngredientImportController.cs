using System.Text.Json;
using System.Text.Json.Serialization;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers.Imports;

[ApiController]
[Route("api/[controller]")]
public class IngredientImportController : ControllerBase
{
    private readonly IngredientImportService _importService;

    public IngredientImportController(IngredientImportService importService)
    {
        _importService = importService;
    }

    [HttpPost("import")]
    public async Task<IActionResult> Import(IFormFile file)
    {
        if (file == null || file.Length == 0)
            return BadRequest("Файл отсутствует");

        if (!file.FileName.EndsWith(".json"))
            return BadRequest("Требуется JSON файл");

        using var reader = new StreamReader(file.OpenReadStream());
        var json = await reader.ReadToEndAsync();

        await _importService.ImportAsync(json);

        return Ok(new { message = "Импорт завершён" });
    }
}