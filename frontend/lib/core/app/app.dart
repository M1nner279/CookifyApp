import 'package:cookify/core/constant/app_constant.dart';
import 'package:cookify/core/l10n/s.dart';
import 'package:cookify/core/router/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: appName,
      locale: S.ru,
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}