using CookifyAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace CookifyAPI.Controllers.Imports;

[ApiController]
[Route("api/[controller]")]
public class TagImportController : ControllerBase
{
    private readonly TagImportService _service;

    public TagImportController(TagImportService service)
    {
        _service = service;
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

        await _service.ImportAsync(json);

        return Ok(new { message = "Импорт завершён" });
    }
}