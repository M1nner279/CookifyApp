import 'package:cookify/features/locale/data/requests/set_locale_request.dart';

abstract interface class LocaleLocalDataSource {
  Future<String?> getLocale();

  Future<String> setLocale(SetLocaleRequest request);
}