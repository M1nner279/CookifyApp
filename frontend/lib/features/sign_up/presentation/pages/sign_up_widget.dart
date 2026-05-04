import 'package:cookify/di/di.dart';
import 'package:cookify/features/sign_up/di/sign_up_di.dart';
import 'package:cookify/features/sign_up/navigators/sign_up_navigator.dart';
import 'package:cookify/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:cookify/features/sign_up/presentation/pages/sign_up_widget_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key, required this.signUpNavigator});

  final SignUpNavigator signUpNavigator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(
        signUpNavigator: signUpNavigator,
        signUpDependency: Di.signUpDependency,
        signUpUseCase: SignUpDi.signUpUseCase,
      ),
      child: const SignUpWidgetContent(),
    );
  }
}
