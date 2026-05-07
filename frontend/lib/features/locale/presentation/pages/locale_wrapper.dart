import 'package:cookify/features/locale/di/locale_di.dart';
import 'package:cookify/features/locale/presentation/bloc/locale_bloc.dart';
import 'package:cookify/features/locale/presentation/bloc/locale_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleWrapper extends StatelessWidget {
  const LocaleWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: LocaleBloc(
        getLocaleUseCase: LocaleDi.getLocaleUseCase,
        listenLocaleUseCase: LocaleDi.listenLocaleUseCase,
      )..add(InitLocale()),
      child: child,
    );
  }
}
