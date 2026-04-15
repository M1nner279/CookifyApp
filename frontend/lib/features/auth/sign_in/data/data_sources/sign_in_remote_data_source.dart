import 'package:cookify/features/auth/sign_in/data/requests/sign_in_request.dart';

abstract class SignInRemoteDataSource {
  Future<void> signIn(SignInRequest request);
}