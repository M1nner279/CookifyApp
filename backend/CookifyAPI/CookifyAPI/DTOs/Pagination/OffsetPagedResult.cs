namespace CookifyAPI.DTOs.Pagination;

public class OffsetPagedResult<T>
{
    public List<T> Items { get; set; } = [];
    public int? TotalCount { get; set; }
    public int PageSize { get; set; } = 10; //

    public int? Page { get; set; } = 1;
    
    public int TotalPages => (int)Math.Ceiling((double)TotalCount / PageSize);

    public bool HasNext => Page * PageSize < TotalCount;
    public bool HasPrevious => Page > 1;
}