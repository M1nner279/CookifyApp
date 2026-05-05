import 'package:cookify/di/di.dart';
import 'package:cookify/features/sign_in/di/sign_in_di.dart';
import 'package:cookify/features/sign_in/navigators/sign_in_navigator.dart';
import 'package:cookify/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:cookify/features/sign_in/presentation/pages/sign_in_widget_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key, required this.signInNavigator});

  final SignInNavigator signInNavigator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInBloc(
        signInNavigator: signInNavigator,
        signInDependency: Di.signInDependency,
        signInUseCase: SignInDi.signInUseCase,
      ),
      child: const SignInWidgetContent(),
    );
  }
}
