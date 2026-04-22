import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_detail_page_args.freezed.dart';

@freezed
abstract class RecipeDetailPageArgs with _$RecipeDetailPageArgs {
  const factory RecipeDetailPageArgs({required String id}) =
      _RecipeDetailPageArgs;
}
