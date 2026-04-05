import 'package:cookify/config/router/animated_go_route.dart';
import 'package:cookify/feature/profile/presentation/page/profile_page.dart';

const profileRoutePath = '/profile';
const profileRouteName = 'profile';

final profileRoute = AnimatedGoRoute(
  path: profileRoutePath,
  name: profileRouteName,
  builder: (context, state) => const ProfilePage(),
);
