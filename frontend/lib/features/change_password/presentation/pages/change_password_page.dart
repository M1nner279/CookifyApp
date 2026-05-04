import 'package:cookify/di/di.dart';
import 'package:cookify/features/change_password/di/change_password_di.dart';
import 'package:cookify/features/change_password/navigators/change_password_navigator.dart';
import 'package:cookify/features/change_password/presentation/bloc/change_password_bloc.dart';
import 'package:cookify/features/change_password/presentation/pages/change_password_page_args.dart';
import 'package:cookify/features/change_password/presentation/pages/change_password_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({
    super.key,
    required this.changePasswordNavigator,
    required this.args,
  });

  final ChangePasswordNavigator changePasswordNavigator;
  final ChangePasswordPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(
        changePasswordNavigator: changePasswordNavigator,
        changePasswordDependency: Di.changePasswordDependency,
        changePasswordUseCase: ChangePasswordDi.changePasswordUseCase,
        goNext: args.goNext,
      ),
      child: const ChangePasswordPageContent(),
    );
  }
}
