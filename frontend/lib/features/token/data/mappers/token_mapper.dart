import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

abstract class TokenMapper {
  static Token fromModel(TokenModel model) {
    return Token(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
    );
  }

  static TokenModel toModel(Token entity) {
    return TokenModel(
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
    );
  }
}
