import 'package:cookify/config/app/app.dart';
import 'package:cookify/service/di/di.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DI.init();

  runApp(const App());
}
