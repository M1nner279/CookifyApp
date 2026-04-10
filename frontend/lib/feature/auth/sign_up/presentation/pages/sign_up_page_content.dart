import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/feature/auth/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:cookify/feature/auth/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPageContent extends StatefulWidget {
  const SignUpPageContent({super.key});

  @override
  State<SignUpPageContent> createState() => _SignUpPageContentState();
}

class _SignUpPageContentState extends State<SignUpPageContent> {
  final loginController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Column(
          spacing: 40.0,
          children: [
            Column(
              spacing: 24.0,
              children: [
                AuthTextField(
                  controller: loginController,
                  label: 'ЛОГИН',
                  hint: 'Введите логин',
                  isPassword: false,
                  failureMessage: state is SignUpError && state.hasLoginError
                      ? 'Длина логина минимум 4 символа'
                      : null,
                ),

                AuthTextField(
                  controller: emailController,
                  label: 'EMAIL',
                  hint: 'Введите email',
                  isPassword: false,
                  failureMessage: state is SignUpError && state.hasEmailError
                      ? 'Невалидный email'
                      : null,
                ),

                AuthTextField(
                  controller: passwordController,
                  label: 'ПАРОЛЬ',
                  hint: 'Введите пароль',
                  isPassword: true,
                  failureMessage: state is SignUpError && state.hasPasswordError
                      ? 'Слишком легкий пароль'
                      : null,
                ),

                AuthTextField(
                  controller: confirmPasswordController,
                  label: 'ПОВТОРИТЕ ПАРОЛЬ',
                  hint: 'Введите пароль повторно',
                  isPassword: true,
                  failureMessage:
                      state is SignUpError && state.hasConfirmPasswordError
                      ? 'Пароли не совпадают'
                      : null,
                ),

                AuthButton(
                  onPressed: () {
                    context.read<SignUpCubit>().signUp(
                      loginController.text,
                      emailController.text,
                      passwordController.text,
                      confirmPasswordController.text,
                    );
                  },
                  title: 'Зарегистрироваться',
                  isLoading: state is SignUpLoading,
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
        if (state is SignUpSuccess) {
          context.push('/auth/otp', extra: {
            'verifyCode': context.read<SignUpCubit>().verifyCode,
            'resendCode': context.read<SignUpCubit>().resendCode,
          });
        }
        else if (state is SignUpError &&
            !state.hasLoginError &&
            !state.hasEmailError &&
            !state.hasPasswordError &&
            !state.hasConfirmPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Такой пользователь уже существует')),
          );
        }
      },
    );
  }
}
