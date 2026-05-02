import 'package:cookify/di/di.dart';
import 'package:cookify/features/locale/data/data_sources/locale_local_data_source.dart';
import 'package:cookify/features/locale/data/data_sources/locale_local_data_source_impl.dart';
import 'package:cookify/features/locale/data/repositories/locale_repository_impl.dart';
import 'package:cookify/features/locale/domain/repositories/locale_repository.dart';
import 'package:cookify/features/locale/domain/use_cases/get_locale_use_case.dart';
import 'package:cookify/features/locale/domain/use_cases/set_locale_use_case.dart';

abstract class LocaleDi {
  static LocaleLocalDataSource get _localeLocalDataSource =>
      LocaleLocalDataSourceImpl(sharedPreferences: Di.sharedPreferences);

  static LocaleRepository get _localeRepository =>
      LocaleRepositoryImpl(localDataSource: _localeLocalDataSource);

  static GetLocaleUseCase get getLocaleUseCase =>
      GetLocaleUseCase(_localeRepository);

  static SetLocaleUseCase get setLocaleUseCase =>
      SetLocaleUseCase(_localeRepository);
}
