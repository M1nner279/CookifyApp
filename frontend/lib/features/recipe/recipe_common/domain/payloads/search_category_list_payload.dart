import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_category_list_payload.freezed.dart';

@freezed
abstract class SearchCategoryListPayload with _$SearchCategoryListPayload {
  const factory SearchCategoryListPayload({
    required List<CategoryEntity>? categories,
    required String name,
  }) = _SearchCategoryListPayload;
}
