using CloudinaryDotNet;
using CloudinaryDotNet.Actions;

namespace CookifyAPI.Services;

public interface IImageService
{
    /// <summary>
    /// Загружает изображение в Cloudinary и возвращает публичный URL
    /// </summary>
    /// <param name="file">Файл для загрузки</param>
    /// <param name="folder">Папка в Cloudinary</param>
    /// <param name="maxFileSizeMb">Максимальный размер файла в МБ</param>
    /// <returns>Публичный URL картинки</returns>
    Task<string> UploadAsync(IFormFile file, string folder, int maxFileSizeMb = 10);
    Task<string> UploadAsync(Stream stream, string fileName,  string folder, int maxFileSizeMb = 10);
}

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

    public async Task<string> UploadAsync(Stream stream, string fileName,  string folder, int maxFileSizeMb = 10)
    {
        // if (file == null || file.Length == 0)
        //     throw new ArgumentException("File is empty");
        //
        // // Проверка размера
        // var maxBytes = maxFileSizeMb * 1024 * 1024;
        // if (file.Length > maxBytes)
        //     throw new PayloadTooLargeException($"File size exceeds {maxFileSizeMb} MB");
        //
        // // Проверка расширения
        // var ext = Path.GetExtension(file.FileName);
        // if (!_allowedExtensions.Contains(ext))
        //     throw new InvalidOperationException("Only jpg, png, webp images are allowed");

        //await using var stream = file.OpenReadStream();

        var uploadParams = new ImageUploadParams
        {
            File = new FileDescription(fileName, stream),
            Folder = folder,
            Overwrite = true,
            UseFilename = true
        };

        var result = await _cloudinary.UploadAsync(uploadParams);

        if (result.StatusCode != System.Net.HttpStatusCode.OK)
            throw new Exception(result.Error?.Message ?? "Failed to upload image");

        return result.SecureUrl.ToString();
    }
}

public class PayloadTooLargeException : Exception
{
    public PayloadTooLargeException(string message) : base(message) { }
}