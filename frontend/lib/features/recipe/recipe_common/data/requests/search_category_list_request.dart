import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_category_list_request.freezed.dart';
part 'search_category_list_request.g.dart';

@freezed
abstract class SearchCategoryListRequest with _$SearchCategoryListRequest {
  const factory SearchCategoryListRequest({
    required int? lastId,
    required String name,
  }) = _SearchCategoryListRequest;

  factory SearchCategoryListRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchCategoryListRequestFromJson(json);
}
