import 'package:cookify/features/auth/auth_common/presentation/pages/auth_page.dart';
import 'package:go_router/go_router.dart';

final authRoute = GoRoute(
  path: '/auth',
  builder: (context, state) => const AuthPage(),
);
