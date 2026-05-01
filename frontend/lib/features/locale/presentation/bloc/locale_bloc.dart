import 'package:cookify/features/locale/domain/use_cases/get_locale_use_case.dart';
import 'package:cookify/features/locale/presentation/bloc/locale_event.dart';
import 'package:cookify/features/locale/presentation/bloc/locale_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc({required GetLocaleUseCase getLocaleUseCase})
    : _getLocaleUseCase = getLocaleUseCase,
      super(LocaleState()) {
    on<InitLocale>(_onInitLocale);
  }

  final GetLocaleUseCase _getLocaleUseCase;

  Future<void> _onInitLocale(
    InitLocale event,
    Emitter<LocaleState> emit,
  ) async {
    final result = await _getLocaleUseCase();
    if (isClosed) return;

    result.fold((failure) {}, (locale) => emit(state.copyWith(locale: locale)));
  }
}
