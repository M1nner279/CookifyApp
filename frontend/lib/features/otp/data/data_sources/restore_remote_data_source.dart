import 'package:cookify/features/otp/data/requests/confirm_code_request.dart';
import 'package:cookify/features/otp/data/requests/resend_code_request.dart';
import 'package:cookify/features/token/data/models/token_model.dart';

abstract interface class OtpRemoteDataSource {
  Future<TokenModel> confirmCode(ConfirmCodeRequest request);

  Future<void> resendCode(ResendCodeRequest request);
}