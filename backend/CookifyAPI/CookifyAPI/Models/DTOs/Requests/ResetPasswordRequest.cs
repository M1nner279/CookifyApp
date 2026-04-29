using System.ComponentModel.DataAnnotations;

namespace CookifyAPI.Models.DTOs.Requests;

public record ResetPasswordRequest(
    [Required] string Login,
    [Required] string Code,
    [Required] string NewPassword
);