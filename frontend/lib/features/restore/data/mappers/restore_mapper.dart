import 'package:cookify/features/restore/data/requests/restore_request.dart';
import 'package:cookify/features/restore/domain/payloads/restore_payload.dart';

abstract class RestoreMapper {
  static RestoreRequest toRequest(RestorePayload payload) {
    return RestoreRequest(login: payload.login);
  }
}
