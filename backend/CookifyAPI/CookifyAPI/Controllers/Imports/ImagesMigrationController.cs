using System.Text.Json;
using System.Text.Json.Serialization;
using CookifyAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers.Imports;

[ApiController]
[Route("api/[controller]")]
public class ImagesMigrationController : ControllerBase
{
    private readonly ImageMigrationService _migrationService;

    public ImagesMigrationController(ImageMigrationService migrationService)
    {
        _migrationService = migrationService;
    }

    [HttpPost("process-json")]
    public async Task<IActionResult> ProcessJson(IFormFile file)
    {
        if (file == null || file.Length == 0)
            return BadRequest("File is empty");

        string json;

        using (var reader = new StreamReader(file.OpenReadStream()))
        {
            json = await reader.ReadToEndAsync();
        }

        var processed = await _migrationService.ProcessAllAsync(json);

        var resultJson = JsonSerializer.Serialize(processed, new JsonSerializerOptions
        {
            WriteIndented = true,
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
        });

        return Content(resultJson, "application/json");
    }
}