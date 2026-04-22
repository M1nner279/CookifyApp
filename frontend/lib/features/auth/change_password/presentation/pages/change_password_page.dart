import 'package:cookify/features/auth/change_password/di/change_password_di.dart';
import 'package:cookify/features/auth/change_password/presentation/bloc/change_password_cubit.dart';
import 'package:cookify/features/auth/change_password/presentation/pages/change_password_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (_) => ChangePasswordDi.getIt(),
      child: const ChangePasswordPageContent(),
    );
  }
}
