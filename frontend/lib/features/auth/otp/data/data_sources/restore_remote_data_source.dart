import 'package:cookify/features/auth/otp/data/requests/confirm_code_request.dart';
import 'package:cookify/features/auth/otp/data/requests/resend_code_request.dart';
import 'package:cookify/features/token/data/models/token_model.dart';

abstract class OtpRemoteDataSource {
  Future<TokenModel> confirmCode(ConfirmCodeRequest request);

  Future<void> resendCode(ResendCodeRequest request);
}