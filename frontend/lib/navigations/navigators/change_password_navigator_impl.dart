import 'package:cookify/features/change_password/navigators/change_password_navigator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class ChangePasswordNavigatorImpl implements ChangePasswordNavigator {
  ChangePasswordNavigatorImpl(this.context);

  final BuildContext context;
  
  @override
  void pop() {
    context.pop();
  }
}
