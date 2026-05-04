import 'package:cookify/features/sign_in/data/requests/sign_in_request.dart';
import 'package:cookify/features/token/data/models/token_model.dart';

abstract interface class SignInRemoteDataSource {
  Future<TokenModel> signIn(SignInRequest request);
}
