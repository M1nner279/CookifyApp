import 'package:cookify/features/token/domain/enums/token_status.dart';

abstract interface class TokenStreamDataSource {
  Future<Stream<TokenStatus>> getTokenStream();

  Future<void> markTokenAsInvalid();
}