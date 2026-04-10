using System.Text.Json;
using CookifyAPI.Data;
using CookifyAPI.Models;
using CookifyAPI.DTOs.Ingredients;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Services;

public class IngredientImportService
{
    private readonly AppDbContext _context;

    public IngredientImportService(AppDbContext context)
    {
        _context = context;
    }

    public async Task ImportAsync(string json)
    {
        if (string.IsNullOrWhiteSpace(json))
            throw new ArgumentException("JSON пустой");

        var items = JsonSerializer.Deserialize<List<JsonIngredientDto>>(json);
        if (items == null || !items.Any())
            return;

        // 1. Нормализованные имена для поиска существующих
        var normalizedNames = items
            .Select(i => Normalize(i.Name))
            .ToList();

        var existing = await _context.Ingredients
            .Where(i => normalizedNames.Contains(i.Name))
            .ToListAsync();

        var existingDict = existing.ToDictionary(i => Normalize(i.Name));

        var toInsert = new List<Ingredient>();

        foreach (var item in items)
        {
            var normalized = Normalize(item.Name);

            if (existingDict.TryGetValue(normalized, out var existingItem))
            {
                // обновление (если нужно)
                existingItem.Calories100g = item.Calories100g;
                existingItem.Protein100g = item.Protein100g;
                existingItem.Fat100g = item.Fat100g;
                existingItem.Carb100g = item.Carb100g;
            }
            else
            {
                toInsert.Add(new Ingredient
                {
                    Name = normalized,
                    Calories100g = item.Calories100g,
                    Protein100g = item.Protein100g,
                    Fat100g = item.Fat100g,
                    Carb100g = item.Carb100g
                });
            }
        }
        
        _context.Ingredients.AddRange(toInsert);

        // 4. Сохраняем изменения апдейтов
        await _context.SaveChangesAsync();
    }

    private string Normalize(string name)
    {
        return name?.Trim().ToLowerInvariant() ?? string.Empty;
    }
}