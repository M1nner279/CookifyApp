import 'package:cookify/core/presentation/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/.env/.env');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Верхняя панель (Status Bar)
      statusBarColor: Color(0xFF1E100A), // Сделать прозрачной
      statusBarIconBrightness:
          Brightness.dark, // Темные иконки (для светлых фонов)
      // Нижняя панель (Navigation Bar)
      systemNavigationBarColor: Color(0xFF1E100A), // Ваш цвет из кода выше
      systemNavigationBarIconBrightness: Brightness.light, // Светлые иконки
    ),
  );

  runApp(const App());
}
