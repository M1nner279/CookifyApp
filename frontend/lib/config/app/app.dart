import 'package:cookify/config/constant/app_constant.dart';
import 'package:cookify/config/l10n/s.dart';
import 'package:cookify/config/router/app_router.dart';
import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp.router(
        routerConfig: router,
        title: appName,
        theme: T.light,
        darkTheme: T.dark,
        themeMode: ThemeMode.system,
        locale: S.ru,
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
