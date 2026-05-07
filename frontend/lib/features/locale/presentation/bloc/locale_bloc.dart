import 'dart:async';

import 'package:cookify/features/locale/domain/use_cases/get_locale_use_case.dart';
import 'package:cookify/features/locale/domain/use_cases/listen_locale_use_case.dart';
import 'package:cookify/features/locale/presentation/bloc/locale_event.dart';
import 'package:cookify/features/locale/presentation/bloc/locale_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc({
    required GetLocaleUseCase getLocaleUseCase,
    required ListenLocaleUseCase listenLocaleUseCase,
  }) : _getLocaleUseCase = getLocaleUseCase,
       _listenLocaleUseCase = listenLocaleUseCase,
       super(LocaleState()) {
    on<InitLocale>(_onInitLocale);
  }

  final GetLocaleUseCase _getLocaleUseCase;
  final ListenLocaleUseCase _listenLocaleUseCase;
  StreamSubscription<Locale>? _localeStreamSubscription;

  Future<void> _onInitLocale(
    InitLocale event,
    Emitter<LocaleState> emit,
  ) async {
    final localeResult = await _getLocaleUseCase();
    if (isClosed) return;

    localeResult.fold(
      (failure) {},
      (locale) => emit(state.copyWith(locale: locale)),
    );

    final streamResult = await _listenLocaleUseCase();
    if (isClosed) return;

    await streamResult.fold((failure) {}, (stream) async {
      await emit.forEach<Locale>(
        stream,
        onData: (newLocale) {
          return state.copyWith(locale: newLocale);
        },
      );
    });
  }

  @override
  Future<void> close() async {
    _localeStreamSubscription?.cancel();
    return super.close();
  }
}
