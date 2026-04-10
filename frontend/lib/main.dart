import 'package:cookify/config/app/app.dart';
import 'package:cookify/di/di.dart';
import 'package:cookify/feature/auth/auth_common/di/auth_di.dart';
import 'package:cookify/service/di/di.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<String>('recipes');
  await AuthDi.init();
  await DI.init();
  await Di.init();

  runApp(const App());
}
