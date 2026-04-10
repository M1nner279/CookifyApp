import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/feature/auth/restore/presentation/bloc/restore_cubit.dart';
import 'package:cookify/feature/auth/restore/presentation/bloc/restore_state.dart';
import 'package:cookify/feature/auth/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RestorePageContent extends StatefulWidget {
  const RestorePageContent({super.key});

  @override
  State<RestorePageContent> createState() => _RestorePageContentState();
}

class _RestorePageContentState extends State<RestorePageContent> {
  final loginOrEmailController = TextEditingController();

  @override
  void dispose() {
    loginOrEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestoreCubit, RestoreState>(
      builder: (context, state) {
        return Column(
          spacing: 40.0,
          children: [
            Column(
              spacing: 24.0,
              children: [
                AuthTextField(
                  controller: loginOrEmailController,
                  label: 'ЛОГИН ИЛИ EMAIL',
                  hint: 'Введите логин или email',
                  isPassword: false,
                ),

                AuthButton(
                  onPressed: () {
                    context.read<RestoreCubit>().restore(
                      loginOrEmailController.text,
                    );
                  },
                  title: 'Восстановить',
                  isLoading: state is SignInLoading,
                ),
              ],
            ),

            const AuthDivider(),

            Row(
              spacing: 16.0,
              children: [
                Expanded(
                  child: AuthServiceButton(
                    onPressed: () {},
                    imagePath: 'google',
                  ),
                ),

                Expanded(
                  child: AuthServiceButton(
                    onPressed: () {},
                    imagePath: 'apple',
                  ),
                ),
              ],
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state is RestoreSuccess) {
          context.push('/auth/otp', extra: {
            'verifyCode': context.read<RestoreCubit>().verifyCode,
            'resendCode': context.read<RestoreCubit>().resendCode,
            'isPasswordRestore': true,
          });
        } else if (state is RestoreError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Проверьте логин или email'),
            ),
          );
        }
      },
    );
  }
}
