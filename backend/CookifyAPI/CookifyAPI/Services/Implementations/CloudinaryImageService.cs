using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using CookifyAPI.Services;

namespace CookifyAPI.Services;

public class CloudinaryImageService : IImageService
{
    private readonly Cloudinary _cloudinary;
    private readonly HashSet<string> _allowedExtensions = new(StringComparer.OrdinalIgnoreCase)
    {
        ".jpg", ".jpeg", ".png", ".webp"
    };
    
    public CloudinaryImageService(IConfiguration config)
    {
        var cloudName = config["Cloudinary:CloudName"];
        var apiKey = config["Cloudinary:ApiKey"];
        var apiSecret = config["Cloudinary:ApiSecret"];

        _cloudinary = new Cloudinary(new Account(cloudName, apiKey, apiSecret));
    }

    public async Task<string> UploadAsync(IFormFile file, string folder, int maxFileSizeMb = 10)
    {
        if (file == null || file.Length == 0)
            throw new ArgumentException("File is empty");

        // Проверка размера
        var maxBytes = maxFileSizeMb * 1024 * 1024;
        if (file.Length > maxBytes)
            throw new PayloadTooLargeException($"File size exceeds {maxFileSizeMb} MB");

        // Проверка расширения
        var ext = Path.GetExtension(file.FileName);
        if (!_allowedExtensions.Contains(ext))
            throw new InvalidOperationException("Only jpg, png, webp images are allowed");

        await using var stream = file.OpenReadStream();

        var uploadParams = new ImageUploadParams
        {
            File = new FileDescription(file.FileName, stream),
            Folder = folder,
            Overwrite = true,
            UseFilename = true
        };

        var result = await _cloudinary.UploadAsync(uploadParams);

        if (result.StatusCode != System.Net.HttpStatusCode.OK)
            throw new Exception(result.Error?.Message ?? "Failed to upload image");

        return result.SecureUrl.ToString();
    }

    public async Task<string?> UploadImageBase64Async(string base64String, string folder)
    {
        if (string.IsNullOrWhiteSpace(base64String)) return null;

        // Cloudinary умеет принимать Data URI (data:image/png;base64,...)
        // Если клиент присылает чистый Base64, добавим префикс
        var prefix = "data:image/png;base64,";
        var imageData = base64String.StartsWith("data:image") ? base64String : prefix + base64String;

        var uploadParams = new ImageUploadParams
        {
            File = new FileDescription(imageData),
            Folder = folder,
            Transformation = new Transformation().Quality("auto").FetchFormat("auto") // Оптимизация
        };

        var uploadResult = await _cloudinary.UploadAsync(uploadParams);
        return uploadResult.SecureUrl?.ToString();
    }
}

public class PayloadTooLargeException : Exception
{
    public PayloadTooLargeException(string message) : base(message) { }
}