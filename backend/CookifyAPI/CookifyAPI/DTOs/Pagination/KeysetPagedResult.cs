namespace CookifyAPI.DTOs.Pagination;

public class KeysetPagedResult<T>
{
    public List<T> Items { get; set; } = [];
    public int? LastId { get; set; }
}