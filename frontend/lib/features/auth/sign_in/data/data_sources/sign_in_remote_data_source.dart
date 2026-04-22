import 'package:cookify/features/auth/sign_in/data/requests/sign_in_request.dart';
import 'package:cookify/features/token/data/models/token_model.dart';

abstract class SignInRemoteDataSource {
  Future<TokenModel> signIn(SignInRequest request);
}