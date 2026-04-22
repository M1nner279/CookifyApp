using Microsoft.AspNetCore.Identity;

namespace CookifyAPI.Models.Entities;

    public class User : IdentityUser<int>
    {
        public string? AvatarUrl { get; set; }
        public DateTime CreatedAt { get; set; }
        public string? RefreshToken { get; set; }
        public DateTime? RefreshTokenExpiryTime { get; set; }
        // Navigation
        public List<Recipe> Recipes { get; set; } = new();
        //public List<Favorite> Favorites { get; set; } = new();
    }