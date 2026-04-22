import 'package:cookify/features/auth/sign_up/data/requests/sign_up_request.dart';

abstract class SignUpRemoteDataSource {
  Future<void> signUp(SignUpRequest request);
}