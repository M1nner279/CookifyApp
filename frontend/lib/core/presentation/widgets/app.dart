import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/locale/presentation/bloc/locale_bloc.dart';
import 'package:cookify/features/locale/presentation/bloc/locale_state.dart';
import 'package:cookify/features/locale/presentation/pages/locale_wrapper.dart';
import 'package:cookify/navigations/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast? fToast;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return LocaleWrapper(
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Cookify',
            routerConfig: navigator,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF1E100A),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1E100A),
              ),
            ),
            locale: state.locale,
            localizationsDelegates: MyLocale.localizationsDelegates,
            supportedLocales: MyLocale.supportedLocales,
          );
        },
      ),
    );
  }
}
