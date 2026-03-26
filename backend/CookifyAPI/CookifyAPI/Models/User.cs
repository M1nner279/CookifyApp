namespace CookifyAPI.Models;

    public class User
    {
        public int Id { get; set; } // u_id

        public string Username { get; set; } = null!; // nvarchar(50)
        public string Email { get; set; } = null!;    // nvarchar(100)
        public string PasswordHash { get; set; } = null!; // nvarchar(255)

        public DateTime CreatedAt { get; set; } // datetime2

        public string? AvatarUrl { get; set; } // nullable

        // Navigation

        public List<Recipe> Recipes { get; set; } = new(); // authored recipes
        //public List<Favorite> Favorites { get; set; } = new();
    }