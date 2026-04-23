import 'package:cookify/navigations/router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1E100A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E100A),
        ),
      ),
    ),
  );
}
