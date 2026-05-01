import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_locale_request.freezed.dart';
part 'set_locale_request.g.dart';

@freezed
abstract class SetLocaleRequest with _$SetLocaleRequest {
  const factory SetLocaleRequest({
    required String locale,
  }) = _SetLocaleRequest;

  factory SetLocaleRequest.fromJson(Map<String, dynamic> json) =>
      _$SetLocaleRequestFromJson(json);
}