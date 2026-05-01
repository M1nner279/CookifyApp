import 'package:cookify/features/token/data/mappers/token_mapper.dart';
import 'package:cookify/features/token/data/requests/set_token_request.dart';
import 'package:cookify/features/token/domain/payloads/set_token_payload.dart';

abstract class SetTokenMapper {
  static SetTokenRequest toRequest(SetTokenPayload payload) {
    return SetTokenRequest(token: TokenMapper.toModel(payload.token));
  }
}
