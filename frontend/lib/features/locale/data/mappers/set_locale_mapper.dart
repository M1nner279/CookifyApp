import 'package:cookify/features/locale/data/requests/set_locale_request.dart';
import 'package:cookify/features/locale/domain/payloads/set_locale_payload.dart';

abstract class SetLocaleMapper {
  static SetLocaleRequest toRequest(SetLocalePayload payload) {
    return SetLocaleRequest(locale: payload.locale.toString());
  }
}
