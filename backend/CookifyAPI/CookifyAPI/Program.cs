using CookifyAPI.Extensions;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddPersistanceSeervices(builder.Configuration);
builder.Services.AddIdentityServices(builder.Configuration);
builder.Services.AddSwaggerServices();

builder.Services.AddApplicationServices();
builder.Services.AddWebServices();

var app = builder.Build();
app.UseHttpsRedirection();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Cookify API V1");
        c.RoutePrefix = string.Empty; 
    });
}

app.ApplyMigrations();

app.UseCors("AllowAll");
app.UseAuthentication(); 
app.UseAuthorization();
app.MapControllers();

app.Run();