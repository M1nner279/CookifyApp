import 'package:cookify/config/router/profile_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextRouteExtension on BuildContext {
  void goProfile() => go(profileRouteName);
  void push(String location) => GoRouter.of(this).push(location);
}