import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_page_args.freezed.dart';

@freezed
abstract class OtpPageArgs with _$OtpPageArgs {
  const factory OtpPageArgs({required String login, required String nextPage}) =
      _OtpPageArgs;
}
