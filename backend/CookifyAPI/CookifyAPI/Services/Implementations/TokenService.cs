using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using CookifyAPI.Models.Entities;
using CookifyAPI.Services;
using Microsoft.IdentityModel.Tokens;

namespace CookifyAPI.Services;

public class TokenService(IConfiguration config) : ITokenService {
    public string GenerateAccessToken(User user) {
        var claims = new List<Claim> {
            new(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new(ClaimTypes.Name, user.UserName!),
            new(ClaimTypes.Email, user.Email!)
        };

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(config["AuthSettings:Key"]!));
        var token = new JwtSecurityToken(
            issuer: config["AuthSettings:Issuer"],
            audience: config["AuthSettings:Audience"],
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(15), // Access token живет недолго
            signingCredentials: new SigningCredentials(key, SecurityAlgorithms.HmacSha256)
        );
        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    public string GenerateRefreshToken() => Convert.ToBase64String(RandomNumberGenerator.GetBytes(64));
}