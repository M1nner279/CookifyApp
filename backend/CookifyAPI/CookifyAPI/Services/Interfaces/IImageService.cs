namespace CookifyAPI.Services.Implementations.Interfaces;

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
}