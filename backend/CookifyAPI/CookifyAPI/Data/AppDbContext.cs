using CookifyAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace CookifyAPI.Data;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<User> Users => Set<User>();
    public DbSet<Recipe> Recipes => Set<Recipe>();
    public DbSet<RecipeStep> RecipeSteps => Set<RecipeStep>();
    public DbSet<RecipeImage> RecipeImages => Set<RecipeImage>();
    public DbSet<Ingredient> Ingredients => Set<Ingredient>();
    public DbSet<Tag> Tags => Set<Tag>();
    public DbSet<Favorite> Favorites => Set<Favorite>();
    public DbSet<M2MRecipeIngredient> RecipeIngredients => Set<M2MRecipeIngredient>();
    public DbSet<M2MRecipeTag> RecipeTags => Set<M2MRecipeTag>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Composite keys
        modelBuilder.Entity<Favorite>()
            .HasKey(f => new { f.UserId, f.RecipeId });

        modelBuilder.Entity<M2MRecipeIngredient>()
            .HasKey(x => new { x.RecipeId, x.IngredientId });

        modelBuilder.Entity<M2MRecipeTag>()
            .HasKey(x => new { x.RecipeId, x.TagId });

        // Default values (SQL side)

        // User → Recipes (NO CASCADE)
        modelBuilder.Entity<Recipe>()
            .HasOne(r => r.Author)
            .WithMany(u => u.Recipes)
            .HasForeignKey(r => r.AuthorId)
            .OnDelete(DeleteBehavior.Restrict);

        // Favorite → User (NO CASCADE)
        modelBuilder.Entity<Favorite>()
            .HasOne(f => f.User)
            .WithMany() //упрощенная модель TODO сделать 2стороннюю связь
            .HasForeignKey(f => f.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        // Favorite → Recipe (CASCADE OK)
        modelBuilder.Entity<Favorite>()
            .HasOne(f => f.Recipe)
            .WithMany() // аналогично favorite -> User
            .HasForeignKey(f => f.RecipeId)
            .OnDelete(DeleteBehavior.Cascade);

        // RecipeStep → Recipe
        modelBuilder.Entity<RecipeStep>()
            .HasOne(s => s.Recipe)
            .WithMany(r => r.Steps)
            .HasForeignKey(s => s.RecipeId)
            .OnDelete(DeleteBehavior.Cascade);

        // RecipeImage → Recipe
        modelBuilder.Entity<RecipeImage>()
            .HasOne(i => i.Recipe)
            .WithMany(r => r.Images)
            .HasForeignKey(i => i.RecipeId)
            .OnDelete(DeleteBehavior.Cascade);

        // M2MRecipeIngredient
        modelBuilder.Entity<M2MRecipeIngredient>()
            .HasOne(x => x.Recipe)
            .WithMany(r => r.Ingredients)
            .HasForeignKey(x => x.RecipeId)
            .OnDelete(DeleteBehavior.Cascade);

        modelBuilder.Entity<M2MRecipeIngredient>()
            .HasOne(x => x.Ingredient)
            .WithMany(i => i.Recipes)
            .HasForeignKey(x => x.IngredientId)
            .OnDelete(DeleteBehavior.Restrict);

        // M2MRecipeTag
        modelBuilder.Entity<M2MRecipeTag>()
            .HasOne(x => x.Recipe)
            .WithMany(r => r.Tags)
            .HasForeignKey(x => x.RecipeId)
            .OnDelete(DeleteBehavior.Cascade);

        modelBuilder.Entity<M2MRecipeTag>()
            .HasOne(x => x.Tag)
            .WithMany(t => t.Recipes)
            .HasForeignKey(x => x.TagId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<User>()
            .Property(x => x.CreatedAt)
            .HasDefaultValueSql("GETDATE()");

        modelBuilder.Entity<Recipe>()
            .Property(x => x.CreatedAt)
            .HasDefaultValueSql("GETDATE()");

        modelBuilder.Entity<Favorite>()
            .Property(x => x.AddedAt)
            .HasDefaultValueSql("GETDATE()");

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