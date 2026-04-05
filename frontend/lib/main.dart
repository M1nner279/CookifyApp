import 'package:cookify/config/app/app.dart';
import 'package:cookify/di/di.dart';
import 'package:cookify/service/di/auth_di.dart';
import 'package:cookify/service/di/di.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthDI.init();
  await DI.init();
  await Di.init();

  runApp(const App());
}
