import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_page_args.freezed.dart';

@freezed
abstract class ChangePasswordPageArgs with _$ChangePasswordPageArgs {
  const factory ChangePasswordPageArgs({required Function goNext}) =
      _ChangePasswordPageArgs;
}
