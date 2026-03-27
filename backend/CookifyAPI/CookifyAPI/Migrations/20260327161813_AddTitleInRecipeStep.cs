using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CookifyAPI.Migrations
{
    /// <inheritdoc />
    public partial class AddTitleInRecipeStep : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Title",
                table: "RecipeSteps",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Title",
                table: "RecipeSteps");
        }
    }
}
