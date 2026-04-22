import 'package:cookify/navigations/router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp.router(routerConfig: router, debugShowCheckedModeBanner: false),
  );
}
