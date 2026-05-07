// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get profileTitle => 'Профиль';

  @override
  String profileUserInfoCreatedAt(Object date) {
    return 'На кухне с $date';
  }

  @override
  String get profileUserStatisticInfoFavorite => 'Сохранено';

  @override
  String get profileUserStatisticInfoCreated => 'Создано';

  @override
  String get profileUserStatisticInfoPublished => 'Опубликовано';

  @override
  String get profileSettings => 'Настройки';

  @override
  String get profileSettingsLocale => 'Сменить язык';

  @override
  String get profileSettingsChangePassword => 'Смена пароля';

  @override
  String get profileSettingsSignout => 'Выйти из аккаунта';
}
