import 'package:cookify/features/locale/data/consts/locale_keys.dart';
import 'package:cookify/features/locale/data/data_sources/locale_local_data_source.dart';
import 'package:cookify/features/locale/data/requests/set_locale_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocaleLocalDataSourceImpl implements LocaleLocalDataSource {
  LocaleLocalDataSourceImpl({required SharedPreferencesAsync sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferencesAsync _sharedPreferences;

  @override
  Future<String?> getLocale() {
    return _sharedPreferences.getString(localeKey);
  }

  @override
  Future<String> setLocale(SetLocaleRequest request) async {
    await _sharedPreferences.setString(localeKey, request.locale);
    return request.locale;
  }
}
