// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get profileTitle => 'Profile';

  @override
  String profileUserInfoCreatedAt(Object date) {
    return 'In the kitchen since $date';
  }

  @override
  String get profileUserStatisticInfoFavorite => 'Saved';

  @override
  String get profileUserStatisticInfoCreated => 'Created';

  @override
  String get profileUserStatisticInfoPublished => 'Published';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileSettingsLocale => 'Change language';

  @override
  String get profileSettingsChangePassword => 'Change password';

  @override
  String get profileSettingsSignout => 'Sign out';
}
