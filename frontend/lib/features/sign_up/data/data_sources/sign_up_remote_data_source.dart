import 'package:cookify/features/sign_up/data/requests/sign_up_request.dart';

abstract interface class SignUpRemoteDataSource {
  Future<void> signUp(SignUpRequest request);
}
