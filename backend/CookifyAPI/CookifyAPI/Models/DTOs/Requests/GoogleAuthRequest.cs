using System.ComponentModel.DataAnnotations;

namespace CookifyAPI.Models.DTOs.Requests;

public record GoogleAuthRequest(
    [Required] string IdToken
);