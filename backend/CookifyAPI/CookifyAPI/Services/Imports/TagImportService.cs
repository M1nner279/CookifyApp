using System.Text.Json;
using CookifyAPI.Data;
using CookifyAPI.DTOs.Tags;
using CookifyAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public class TagImportService
{
    private readonly AppDbContext _context;

    public TagImportService(AppDbContext context)
    {
        _context = context;
    }
    
    public async Task ImportAsync(string json)
    {
        if (string.IsNullOrWhiteSpace(json))
            throw new ArgumentException("JSON пустой");

        var items = JsonSerializer.Deserialize<List<JsonTagDto>>(json);
        if (items == null || !items.Any())
            return;

        // 1. Нормализованные имена для поиска существующих
        var normalizedNames = items
            .Select(i => Normalize(i.Name))
            .ToList();

        var existing = await _context.Tags
            .Where(i => normalizedNames.Contains(i.Name))
            .ToListAsync();

        var existingDict = existing.ToDictionary(i => Normalize(i.Name));

        var toInsert = new List<Tag>();

        foreach (var item in items)
        {
            var normalized = Normalize(item.Name);

            if (existingDict.TryGetValue(normalized, out Tag existingItem))
            {
                // обновление (если нужно)
                existingItem.Name = item.Name;
            }
            else
            {
                toInsert.Add(new Tag
                {
                    Name = normalized
                });
            }
        }
        
        _context.Tags.AddRange(toInsert);

        // 4. Сохраняем изменения апдейтов
        await _context.SaveChangesAsync();
    }

    private string Normalize(string name)
    {
        return name?.Trim().ToLowerInvariant() ?? string.Empty;
    }
}