import 'package:cookify/features/auth/sign_in/di/sign_in_di.dart';
import 'package:cookify/features/auth/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:cookify/features/auth/sign_in/presentation/pages/sign_in_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => SignInDi.getIt(),
      child: const SignInPageContent(),
    );
  }
}
