import 'package:cookify/config/constant/app_constant.dart';
import 'package:cookify/config/l10n/s.dart';
import 'package:cookify/config/router/router.dart';
import 'package:cookify/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: appName,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      locale: S.ru,
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
