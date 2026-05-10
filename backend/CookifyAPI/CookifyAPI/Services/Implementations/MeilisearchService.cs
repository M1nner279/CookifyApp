using CookifyAPI.Models.DTOs.Search;
using Meilisearch;

namespace CookifyAPI.Services;

public class MeilisearchService(MeilisearchClient client) : ISearchService
{
    private const string TagsIndex = "tags";
    private const string IngredientsIndex = "ingredients";
    
    
    public async Task<IReadOnlyCollection<TagSearchDocument>> SearchTagsAsync(string query, int limit = 20)
    {
        var index = client.Index(TagsIndex);
        var searchQuery = new SearchQuery { Limit = limit };
        
        var result = await index.SearchAsync<TagSearchDocument>(query, searchQuery);
        return result.Hits;
    }

    public async Task<IReadOnlyCollection<IngredientSearchDocument>> SearchIngredientsAsync(string query, int limit = 20)
    {
        var index = client.Index(IngredientsIndex);
        var searchQuery = new SearchQuery { Limit = limit };
        
        var result = await index.SearchAsync<IngredientSearchDocument>(query, searchQuery);
        return result.Hits;
    }

    public async Task IndexTagsAsync(IEnumerable<TagSearchDocument> tags)
    {
        var index = client.Index(TagsIndex);
        await index.AddDocumentsAsync(tags);
    }

    public Task IndexIngredientsAsync(IEnumerable<IngredientSearchDocument> ingredients)
    {
        var index = client.Index(IngredientsIndex);
        return index.AddDocumentsAsync(ingredients);
    }

    public async Task SetupIndicesAsync()
    {
        await client.Index(TagsIndex).UpdateSearchableAttributesAsync(new[] { "name" });
        await client.Index(IngredientsIndex).UpdateSearchableAttributesAsync(new[] { "name" });
    }
}