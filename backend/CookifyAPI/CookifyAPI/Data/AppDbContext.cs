using CookifyAPI.Models;

namespace CookifyAPI.Data;

using Microsoft.EntityFrameworkCore;

public class AppDbContext : DbContext
{
    // public DbSet<User> Users { get; set; }
    //
    // public AppDbContext(DbContextOptions<AppDbContext> options)
    //     : base(options) { }
    //
    // protected override void OnModelCreating(ModelBuilder modelBuilder)
    // {
    //     base.OnModelCreating(modelBuilder);
    //     modelBuilder.Entity<User>()
    //         .Property(x => x.CreatedAt)
    //         .HasDefaultValueSql("GETDATE()");
    // }
    
    public DbSet<User> Users => Set<User>();
    public DbSet<Recipe> Recipes => Set<Recipe>();
    public DbSet<RecipeStep> RecipeSteps => Set<RecipeStep>();
    public DbSet<RecipeImage> RecipeImages => Set<RecipeImage>();
    public DbSet<Ingredient> Ingredients => Set<Ingredient>();
    public DbSet<Tag> Tags => Set<Tag>();
    //public DbSet<Favorite> Favorites => Set<Favorite>();
    public DbSet<RecipeIngredient> RecipeIngredients => Set<RecipeIngredient>();
    public DbSet<RecipeTag> RecipeTags => Set<RecipeTag>();

    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Composite keys
        //modelBuilder.Entity<Favorite>()
        //    .HasKey(f => new { f.UserId, f.RecipeId });

        modelBuilder.Entity<RecipeIngredient>()
            .HasKey(x => new { x.RecipeId, x.IngredientId });

        modelBuilder.Entity<RecipeTag>()
            .HasKey(x => new { x.RecipeId, x.TagId });

        // Default values (SQL side)
        modelBuilder.Entity<User>()
            .Property(x => x.CreatedAt)
            .HasDefaultValueSql("GETDATE()");

        modelBuilder.Entity<Recipe>()
            .Property(x => x.CreatedAt)
            .HasDefaultValueSql("GETDATE()");

        // modelBuilder.Entity<Favorite>()
        //     .Property(x => x.AddedAt)
        //     .HasDefaultValueSql("GETDATE()");

        // Length constraints
        modelBuilder.Entity<User>()
            .Property(x => x.Email)
            .HasMaxLength(100);

        modelBuilder.Entity<User>()
            .HasIndex(x => x.Email)
            .IsUnique();

        modelBuilder.Entity<RecipeStep>()
            .Property(x => x.Description)
            .HasColumnType("nvarchar(max)");
    }
}