import 'package:cookify/features/auth/sign_up/di/sign_up_di.dart';
import 'package:cookify/features/auth/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:cookify/features/auth/sign_up/presentation/pages/sign_up_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpDi.getIt(),
      child: const SignUpPageContent(),
    );
  }
}
