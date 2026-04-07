using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CookifyAPI.Migrations
{
    /// <inheritdoc />
    public partial class AddSnakeCase : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Favorites_Recipes_RecipeId",
                table: "Favorites");

            migrationBuilder.DropForeignKey(
                name: "FK_Favorites_Users_UserId",
                table: "Favorites");

            migrationBuilder.DropForeignKey(
                name: "FK_RecipeImages_Recipes_RecipeId",
                table: "RecipeImages");

            migrationBuilder.DropForeignKey(
                name: "FK_RecipeIngredients_Ingredients_IngredientId",
                table: "RecipeIngredients");

            migrationBuilder.DropForeignKey(
                name: "FK_RecipeIngredients_Recipes_RecipeId",
                table: "RecipeIngredients");

            migrationBuilder.DropForeignKey(
                name: "FK_Recipes_Users_AuthorId",
                table: "Recipes");

            migrationBuilder.DropForeignKey(
                name: "FK_RecipeSteps_Recipes_RecipeId",
                table: "RecipeSteps");

            migrationBuilder.DropForeignKey(
                name: "FK_RecipeTags_Recipes_RecipeId",
                table: "RecipeTags");

            migrationBuilder.DropForeignKey(
                name: "FK_RecipeTags_Tags_TagId",
                table: "RecipeTags");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Users",
                table: "Users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Tags",
                table: "Tags");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Recipes",
                table: "Recipes");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Ingredients",
                table: "Ingredients");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Favorites",
                table: "Favorites");

            migrationBuilder.DropPrimaryKey(
                name: "PK_RecipeTags",
                table: "RecipeTags");

            migrationBuilder.DropPrimaryKey(
                name: "PK_RecipeSteps",
                table: "RecipeSteps");

            migrationBuilder.DropPrimaryKey(
                name: "PK_RecipeIngredients",
                table: "RecipeIngredients");

            migrationBuilder.DropPrimaryKey(
                name: "PK_RecipeImages",
                table: "RecipeImages");

            migrationBuilder.RenameTable(
                name: "Users",
                newName: "users");

            migrationBuilder.RenameTable(
                name: "Tags",
                newName: "tags");

            migrationBuilder.RenameTable(
                name: "Recipes",
                newName: "recipes");

            migrationBuilder.RenameTable(
                name: "Ingredients",
                newName: "ingredients");

            migrationBuilder.RenameTable(
                name: "Favorites",
                newName: "favorites");

            migrationBuilder.RenameTable(
                name: "RecipeTags",
                newName: "recipe_tags");

            migrationBuilder.RenameTable(
                name: "RecipeSteps",
                newName: "recipe_steps");

            migrationBuilder.RenameTable(
                name: "RecipeIngredients",
                newName: "recipe_ingredients");

            migrationBuilder.RenameTable(
                name: "RecipeImages",
                newName: "recipe_images");

            migrationBuilder.RenameColumn(
                name: "Username",
                table: "users",
                newName: "username");

            migrationBuilder.RenameColumn(
                name: "Email",
                table: "users",
                newName: "email");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "users",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "PasswordHash",
                table: "users",
                newName: "password_hash");

            migrationBuilder.RenameColumn(
                name: "CreatedAt",
                table: "users",
                newName: "created_at");

            migrationBuilder.RenameColumn(
                name: "AvatarUrl",
                table: "users",
                newName: "avatar_url");

            migrationBuilder.RenameIndex(
                name: "IX_Users_Email",
                table: "users",
                newName: "ix_users_email");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "tags",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "tags",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "Title",
                table: "recipes",
                newName: "title");

            migrationBuilder.RenameColumn(
                name: "Servings",
                table: "recipes",
                newName: "servings");

            migrationBuilder.RenameColumn(
                name: "Protein100g",
                table: "recipes",
                newName: "protein100g");

            migrationBuilder.RenameColumn(
                name: "Fat100g",
                table: "recipes",
                newName: "fat100g");

            migrationBuilder.RenameColumn(
                name: "Difficulty",
                table: "recipes",
                newName: "difficulty");

            migrationBuilder.RenameColumn(
                name: "Description",
                table: "recipes",
                newName: "description");

            migrationBuilder.RenameColumn(
                name: "Carb100g",
                table: "recipes",
                newName: "carb100g");

            migrationBuilder.RenameColumn(
                name: "Calories100g",
                table: "recipes",
                newName: "calories100g");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "recipes",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "CreatedAt",
                table: "recipes",
                newName: "created_at");

            migrationBuilder.RenameColumn(
                name: "CookingTimeMin",
                table: "recipes",
                newName: "cooking_time_min");

            migrationBuilder.RenameColumn(
                name: "AuthorId",
                table: "recipes",
                newName: "author_id");

            migrationBuilder.RenameIndex(
                name: "IX_Recipes_AuthorId",
                table: "recipes",
                newName: "ix_recipes_author_id");

            migrationBuilder.RenameColumn(
                name: "Protein100g",
                table: "ingredients",
                newName: "protein100g");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "ingredients",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "Fat100g",
                table: "ingredients",
                newName: "fat100g");

            migrationBuilder.RenameColumn(
                name: "Carb100g",
                table: "ingredients",
                newName: "carb100g");

            migrationBuilder.RenameColumn(
                name: "Calories100g",
                table: "ingredients",
                newName: "calories100g");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "ingredients",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "AddedAt",
                table: "favorites",
                newName: "added_at");

            migrationBuilder.RenameColumn(
                name: "RecipeId",
                table: "favorites",
                newName: "recipe_id");

            migrationBuilder.RenameColumn(
                name: "UserId",
                table: "favorites",
                newName: "user_id");

            migrationBuilder.RenameIndex(
                name: "IX_Favorites_RecipeId",
                table: "favorites",
                newName: "ix_favorites_recipe_id");

            migrationBuilder.RenameColumn(
                name: "TagId",
                table: "recipe_tags",
                newName: "tag_id");

            migrationBuilder.RenameColumn(
                name: "RecipeId",
                table: "recipe_tags",
                newName: "recipe_id");

            migrationBuilder.RenameIndex(
                name: "IX_RecipeTags_TagId",
                table: "recipe_tags",
                newName: "ix_recipe_tags_tag_id");

            migrationBuilder.RenameColumn(
                name: "Title",
                table: "recipe_steps",
                newName: "title");

            migrationBuilder.RenameColumn(
                name: "Description",
                table: "recipe_steps",
                newName: "description");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "recipe_steps",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "StepNumber",
                table: "recipe_steps",
                newName: "step_number");

            migrationBuilder.RenameColumn(
                name: "RecipeId",
                table: "recipe_steps",
                newName: "recipe_id");

            migrationBuilder.RenameColumn(
                name: "ImageUrl",
                table: "recipe_steps",
                newName: "image_url");

            migrationBuilder.RenameIndex(
                name: "IX_RecipeSteps_RecipeId",
                table: "recipe_steps",
                newName: "ix_recipe_steps_recipe_id");

            migrationBuilder.RenameColumn(
                name: "Unit",
                table: "recipe_ingredients",
                newName: "unit");

            migrationBuilder.RenameColumn(
                name: "Amount",
                table: "recipe_ingredients",
                newName: "amount");

            migrationBuilder.RenameColumn(
                name: "IngredientId",
                table: "recipe_ingredients",
                newName: "ingredient_id");

            migrationBuilder.RenameColumn(
                name: "RecipeId",
                table: "recipe_ingredients",
                newName: "recipe_id");

            migrationBuilder.RenameIndex(
                name: "IX_RecipeIngredients_IngredientId",
                table: "recipe_ingredients",
                newName: "ix_recipe_ingredients_ingredient_id");

            migrationBuilder.RenameColumn(
                name: "Url",
                table: "recipe_images",
                newName: "url");

            migrationBuilder.RenameColumn(
                name: "Order",
                table: "recipe_images",
                newName: "order");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "recipe_images",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "RecipeId",
                table: "recipe_images",
                newName: "recipe_id");

            migrationBuilder.RenameIndex(
                name: "IX_RecipeImages_RecipeId",
                table: "recipe_images",
                newName: "ix_recipe_images_recipe_id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_users",
                table: "users",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_tags",
                table: "tags",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_recipes",
                table: "recipes",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_ingredients",
                table: "ingredients",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_favorites",
                table: "favorites",
                columns: new[] { "user_id", "recipe_id" });

            migrationBuilder.AddPrimaryKey(
                name: "pk_recipe_tags",
                table: "recipe_tags",
                columns: new[] { "recipe_id", "tag_id" });

            migrationBuilder.AddPrimaryKey(
                name: "pk_recipe_steps",
                table: "recipe_steps",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_recipe_ingredients",
                table: "recipe_ingredients",
                columns: new[] { "recipe_id", "ingredient_id" });

            migrationBuilder.AddPrimaryKey(
                name: "pk_recipe_images",
                table: "recipe_images",
                column: "id");

            migrationBuilder.AddForeignKey(
                name: "fk_favorites_recipes_recipe_id",
                table: "favorites",
                column: "recipe_id",
                principalTable: "recipes",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_favorites_users_user_id",
                table: "favorites",
                column: "user_id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_recipe_images_recipes_recipe_id",
                table: "recipe_images",
                column: "recipe_id",
                principalTable: "recipes",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_recipe_ingredients_ingredients_ingredient_id",
                table: "recipe_ingredients",
                column: "ingredient_id",
                principalTable: "ingredients",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_recipe_ingredients_recipes_recipe_id",
                table: "recipe_ingredients",
                column: "recipe_id",
                principalTable: "recipes",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_recipe_steps_recipes_recipe_id",
                table: "recipe_steps",
                column: "recipe_id",
                principalTable: "recipes",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_recipe_tags_recipes_recipe_id",
                table: "recipe_tags",
                column: "recipe_id",
                principalTable: "recipes",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_recipe_tags_tags_tag_id",
                table: "recipe_tags",
                column: "tag_id",
                principalTable: "tags",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_recipes_users_author_id",
                table: "recipes",
                column: "author_id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_favorites_recipes_recipe_id",
                table: "favorites");

            migrationBuilder.DropForeignKey(
                name: "fk_favorites_users_user_id",
                table: "favorites");

            migrationBuilder.DropForeignKey(
                name: "fk_recipe_images_recipes_recipe_id",
                table: "recipe_images");

            migrationBuilder.DropForeignKey(
                name: "fk_recipe_ingredients_ingredients_ingredient_id",
                table: "recipe_ingredients");

            migrationBuilder.DropForeignKey(
                name: "fk_recipe_ingredients_recipes_recipe_id",
                table: "recipe_ingredients");

            migrationBuilder.DropForeignKey(
                name: "fk_recipe_steps_recipes_recipe_id",
                table: "recipe_steps");

            migrationBuilder.DropForeignKey(
                name: "fk_recipe_tags_recipes_recipe_id",
                table: "recipe_tags");

            migrationBuilder.DropForeignKey(
                name: "fk_recipe_tags_tags_tag_id",
                table: "recipe_tags");

            migrationBuilder.DropForeignKey(
                name: "fk_recipes_users_author_id",
                table: "recipes");

            migrationBuilder.DropPrimaryKey(
                name: "pk_users",
                table: "users");

            migrationBuilder.DropPrimaryKey(
                name: "pk_tags",
                table: "tags");

            migrationBuilder.DropPrimaryKey(
                name: "pk_recipes",
                table: "recipes");

            migrationBuilder.DropPrimaryKey(
                name: "pk_ingredients",
                table: "ingredients");

            migrationBuilder.DropPrimaryKey(
                name: "pk_favorites",
                table: "favorites");

            migrationBuilder.DropPrimaryKey(
                name: "pk_recipe_tags",
                table: "recipe_tags");

            migrationBuilder.DropPrimaryKey(
                name: "pk_recipe_steps",
                table: "recipe_steps");

            migrationBuilder.DropPrimaryKey(
                name: "pk_recipe_ingredients",
                table: "recipe_ingredients");

            migrationBuilder.DropPrimaryKey(
                name: "pk_recipe_images",
                table: "recipe_images");

            migrationBuilder.RenameTable(
                name: "users",
                newName: "Users");

            migrationBuilder.RenameTable(
                name: "tags",
                newName: "Tags");

            migrationBuilder.RenameTable(
                name: "recipes",
                newName: "Recipes");

            migrationBuilder.RenameTable(
                name: "ingredients",
                newName: "Ingredients");

            migrationBuilder.RenameTable(
                name: "favorites",
                newName: "Favorites");

            migrationBuilder.RenameTable(
                name: "recipe_tags",
                newName: "RecipeTags");

            migrationBuilder.RenameTable(
                name: "recipe_steps",
                newName: "RecipeSteps");

            migrationBuilder.RenameTable(
                name: "recipe_ingredients",
                newName: "RecipeIngredients");

            migrationBuilder.RenameTable(
                name: "recipe_images",
                newName: "RecipeImages");

            migrationBuilder.RenameColumn(
                name: "username",
                table: "Users",
                newName: "Username");

            migrationBuilder.RenameColumn(
                name: "email",
                table: "Users",
                newName: "Email");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Users",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "password_hash",
                table: "Users",
                newName: "PasswordHash");

            migrationBuilder.RenameColumn(
                name: "created_at",
                table: "Users",
                newName: "CreatedAt");

            migrationBuilder.RenameColumn(
                name: "avatar_url",
                table: "Users",
                newName: "AvatarUrl");

            migrationBuilder.RenameIndex(
                name: "ix_users_email",
                table: "Users",
                newName: "IX_Users_Email");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "Tags",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Tags",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "title",
                table: "Recipes",
                newName: "Title");

            migrationBuilder.RenameColumn(
                name: "servings",
                table: "Recipes",
                newName: "Servings");

            migrationBuilder.RenameColumn(
                name: "protein100g",
                table: "Recipes",
                newName: "Protein100g");

            migrationBuilder.RenameColumn(
                name: "fat100g",
                table: "Recipes",
                newName: "Fat100g");

            migrationBuilder.RenameColumn(
                name: "difficulty",
                table: "Recipes",
                newName: "Difficulty");

            migrationBuilder.RenameColumn(
                name: "description",
                table: "Recipes",
                newName: "Description");

            migrationBuilder.RenameColumn(
                name: "carb100g",
                table: "Recipes",
                newName: "Carb100g");

            migrationBuilder.RenameColumn(
                name: "calories100g",
                table: "Recipes",
                newName: "Calories100g");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Recipes",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "created_at",
                table: "Recipes",
                newName: "CreatedAt");

            migrationBuilder.RenameColumn(
                name: "cooking_time_min",
                table: "Recipes",
                newName: "CookingTimeMin");

            migrationBuilder.RenameColumn(
                name: "author_id",
                table: "Recipes",
                newName: "AuthorId");

            migrationBuilder.RenameIndex(
                name: "ix_recipes_author_id",
                table: "Recipes",
                newName: "IX_Recipes_AuthorId");

            migrationBuilder.RenameColumn(
                name: "protein100g",
                table: "Ingredients",
                newName: "Protein100g");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "Ingredients",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "fat100g",
                table: "Ingredients",
                newName: "Fat100g");

            migrationBuilder.RenameColumn(
                name: "carb100g",
                table: "Ingredients",
                newName: "Carb100g");

            migrationBuilder.RenameColumn(
                name: "calories100g",
                table: "Ingredients",
                newName: "Calories100g");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Ingredients",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "added_at",
                table: "Favorites",
                newName: "AddedAt");

            migrationBuilder.RenameColumn(
                name: "recipe_id",
                table: "Favorites",
                newName: "RecipeId");

            migrationBuilder.RenameColumn(
                name: "user_id",
                table: "Favorites",
                newName: "UserId");

            migrationBuilder.RenameIndex(
                name: "ix_favorites_recipe_id",
                table: "Favorites",
                newName: "IX_Favorites_RecipeId");

            migrationBuilder.RenameColumn(
                name: "tag_id",
                table: "RecipeTags",
                newName: "TagId");

            migrationBuilder.RenameColumn(
                name: "recipe_id",
                table: "RecipeTags",
                newName: "RecipeId");

            migrationBuilder.RenameIndex(
                name: "ix_recipe_tags_tag_id",
                table: "RecipeTags",
                newName: "IX_RecipeTags_TagId");

            migrationBuilder.RenameColumn(
                name: "title",
                table: "RecipeSteps",
                newName: "Title");

            migrationBuilder.RenameColumn(
                name: "description",
                table: "RecipeSteps",
                newName: "Description");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "RecipeSteps",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "step_number",
                table: "RecipeSteps",
                newName: "StepNumber");

            migrationBuilder.RenameColumn(
                name: "recipe_id",
                table: "RecipeSteps",
                newName: "RecipeId");

            migrationBuilder.RenameColumn(
                name: "image_url",
                table: "RecipeSteps",
                newName: "ImageUrl");

            migrationBuilder.RenameIndex(
                name: "ix_recipe_steps_recipe_id",
                table: "RecipeSteps",
                newName: "IX_RecipeSteps_RecipeId");

            migrationBuilder.RenameColumn(
                name: "unit",
                table: "RecipeIngredients",
                newName: "Unit");

            migrationBuilder.RenameColumn(
                name: "amount",
                table: "RecipeIngredients",
                newName: "Amount");

            migrationBuilder.RenameColumn(
                name: "ingredient_id",
                table: "RecipeIngredients",
                newName: "IngredientId");

            migrationBuilder.RenameColumn(
                name: "recipe_id",
                table: "RecipeIngredients",
                newName: "RecipeId");

            migrationBuilder.RenameIndex(
                name: "ix_recipe_ingredients_ingredient_id",
                table: "RecipeIngredients",
                newName: "IX_RecipeIngredients_IngredientId");

            migrationBuilder.RenameColumn(
                name: "url",
                table: "RecipeImages",
                newName: "Url");

            migrationBuilder.RenameColumn(
                name: "order",
                table: "RecipeImages",
                newName: "Order");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "RecipeImages",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "recipe_id",
                table: "RecipeImages",
                newName: "RecipeId");

            migrationBuilder.RenameIndex(
                name: "ix_recipe_images_recipe_id",
                table: "RecipeImages",
                newName: "IX_RecipeImages_RecipeId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Users",
                table: "Users",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Tags",
                table: "Tags",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Recipes",
                table: "Recipes",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Ingredients",
                table: "Ingredients",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Favorites",
                table: "Favorites",
                columns: new[] { "UserId", "RecipeId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_RecipeTags",
                table: "RecipeTags",
                columns: new[] { "RecipeId", "TagId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_RecipeSteps",
                table: "RecipeSteps",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_RecipeIngredients",
                table: "RecipeIngredients",
                columns: new[] { "RecipeId", "IngredientId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_RecipeImages",
                table: "RecipeImages",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Favorites_Recipes_RecipeId",
                table: "Favorites",
                column: "RecipeId",
                principalTable: "Recipes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Favorites_Users_UserId",
                table: "Favorites",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_RecipeImages_Recipes_RecipeId",
                table: "RecipeImages",
                column: "RecipeId",
                principalTable: "Recipes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_RecipeIngredients_Ingredients_IngredientId",
                table: "RecipeIngredients",
                column: "IngredientId",
                principalTable: "Ingredients",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_RecipeIngredients_Recipes_RecipeId",
                table: "RecipeIngredients",
                column: "RecipeId",
                principalTable: "Recipes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Recipes_Users_AuthorId",
                table: "Recipes",
                column: "AuthorId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_RecipeSteps_Recipes_RecipeId",
                table: "RecipeSteps",
                column: "RecipeId",
                principalTable: "Recipes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_RecipeTags_Recipes_RecipeId",
                table: "RecipeTags",
                column: "RecipeId",
                principalTable: "Recipes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_RecipeTags_Tags_TagId",
                table: "RecipeTags",
                column: "TagId",
                principalTable: "Tags",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
