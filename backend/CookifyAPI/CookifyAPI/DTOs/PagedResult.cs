namespace CookifyAPI.DTOs;

public class PagedResult<T>
{
    public List<T> Items { get; set; } = [];
    public int? TotalCount { get; set; } // null для keyset
    public int PageSize { get; set; }
    public int? Page { get; set; }
    public int? LastId { get; set; }
}